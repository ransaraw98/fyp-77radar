fc = 77e9;
c = physconst('LightSpeed');
N = 16;
Nsubarray = 2;
lambda = c/fc;
Nr = 16;
Nt = 2;
dt = Nr*lambda/2; %increasing the spacing between transmit antennas to make a thin-full array
dr = lambda/2;


antenna_element = phased.CosineAntennaElement;
antenna_element.FrequencyRange = [73e9 83e9];
f_1 = figure;
pattern(antenna_element,fc);
subula = phased.ULA( 4, dt, 'Element',antenna_element);
f0 = figure;
pattern(subula, fc,0);
title('subarray radiation pattern');

txarray = phased.ReplicatedSubarray('Subarray',subula, 'GridSize',[1 Nsubarray]);
%f1 = figure;
%pattern(txarray,fc)
%txarray = phased.ULA(Nt,dt);
%rxarray = phased.ULA(Nr,dr);
rxarray = phased.ULA(Nr,dr);

refula = phased.ULA(8,0.5*c/fc,'Element',antenna_element);
f2= figure;
subplot(2,1,1), pattern(txarray,fc,-180:180,0,'Type','powerdb','CoordinateSystem','rectangular','PropagationSpeed',c); 
title('Subarrayed ULA Azimuth Cut'); axis([-90 90 -50 0]);
subplot(2,1,2), pattern(refula,fc,-180:180,0,'Type','powerdb','CoordinateSystem','rectangular','PropagationSpeed',c); 
title('ULA Azimuth Cut'); axis([-90 90 -50 0]);

f3 = figure;
ang = -90:90;
pattx = pattern(txarray,fc,ang,0,'Type','powerdb');
patrx = pattern(rxarray,fc,ang,0,'Type','powerdb');
pat2way = pattx+patrx;
helperPlotMultipledBPattern(ang,[pat2way pattx patrx],[-30 0],{'Two-way Pattern','Tx Pattern','Rx Pattern'},'Patterns of thin/full arrays - 2Tx, 4Rx',{'-','--','-.'});

varray = phased.ULA(32,dr);
patv = pattern(varray,fc,ang,0,'Type','powerdb');
helperPlotMultipledBPattern(ang,[pat2way patv],[-30 0],...
    {'Two-way Pattern','Virtual Array Pattern'},...
    'Patterns of thin/full arrays and virtual array',...
    {'-','--'},[1 2]);

waveform = helperDesignFMCWWaveform(c,lambda);
fs = waveform.SampleRate;

transmitter = phased.Transmitter('PeakPower',0.001,'Gain',36);
receiver = phased.ReceiverPreamp('Gain',40,'NoiseFigure',4.5,'SampleRate',fs);

txradiator = phased.Radiator('Sensor',txarray,'OperatingFrequency',fc,...
    'PropagationSpeed',c,'WeightsInputPort',true);

rxcollector = phased.Collector('Sensor',rxarray,'OperatingFrequency',fc,...
    'PropagationSpeed',c);

radar_speed = 100*1000/3600;     % Ego vehicle speed 100 km/h
radarmotion = phased.Platform('InitialPosition',[0;0;0.5],'Velocity',[radar_speed;0;0]);

car_dist = [40 50];              % Distance between sensor and cars (meters)
car_speed = [-80 96]*1000/3600;  % km/h -> m/s
car_az = [-10 10];
car_rcs = [20 40];
car_pos = [car_dist.*cosd(car_az);car_dist.*sind(car_az);0.5 0.5];

cars = phased.RadarTarget('MeanRCS',car_rcs,'PropagationSpeed',c,'OperatingFrequency',fc);
carmotion = phased.Platform('InitialPosition',car_pos,'Velocity',[car_speed;0 0;0 0]);

%%
% The propagation model is assumed to be free space.
channel = phased.FreeSpace('PropagationSpeed',c,...
    'OperatingFrequency',fc,'SampleRate',fs,'TwoWayPropagation',true);

%%
% The raw data cube received by the physical array of the TDM MIMO radar
% can then be simulated as follows:

rng(2017);
Nsweep = 64;
Dn = 2;      % Decimation factor
fs = fs/Dn;
xr = complex(zeros(fs*waveform.SweepTime,Nr,Nsweep));

w0 = [0;1];  % weights to enable/disable radiating elements

for m = 1:Nsweep
    % Update radar and target positions
    [radar_pos,radar_vel] = radarmotion(waveform.SweepTime);
    [tgt_pos,tgt_vel] = carmotion(waveform.SweepTime);
    [~,tgt_ang] = rangeangle(tgt_pos,radar_pos);

    % Transmit FMCW waveform
    sig = waveform();
    txsig = transmitter(sig);
    
    % Toggle transmit element
    w0 = 1-w0; 
    txsig = txradiator(txsig,tgt_ang,w0);
    
    % Propagate the signal and reflect off the target
    txsig = channel(txsig,radar_pos,tgt_pos,radar_vel,tgt_vel);
    txsig = cars(txsig);
    
    % Dechirp the received radar return
    rxsig = rxcollector(txsig,tgt_ang);
    rxsig = receiver(rxsig);    
    dechirpsig = dechirp(rxsig,sig);
    
    % Decimate the return to reduce computation requirements
    for n = size(xr,2):-1:1
        xr(:,n,m) = decimate(dechirpsig(:,n),Dn,'FIR');
    end
end


%% Virtual Array Processing
% The data cube received by the physical array must be processed to form
% the virtual array data cube. For the TDM-MIMO radar system used in this
% example, the measurements corresponding to the two transmit antenna
% elements can be recovered from two consecutive sweeps by taking every
% other page of the data cube.

Nvsweep = Nsweep/2;
xr1 = xr(:,:,1:2:end);
xr2 = xr(:,:,2:2:end);

%%
% Now the data cube in |xr1| contains the return corresponding to the first
% transmit antenna element, and the data cube in |xr2| contains the return
% corresponding to the second transmit antenna element. Hence, the data
% cube from the virtual array can be formed as:

xrv = cat(2,xr1,xr2);

%%
% Next, perform range-Doppler processing on the virtual data cube. Because
% the range-Doppler processing is linear, the phase information is
% preserved. Therefore, the resulting response can be used later to perform
% further spatial processing on the virtual aperture.

nfft_r = 2^nextpow2(size(xrv,1));
nfft_d = 2^nextpow2(size(xrv,3));

rngdop = phased.RangeDopplerResponse('PropagationSpeed',c,...
    'DopplerOutput','Speed','OperatingFrequency',fc,'SampleRate',fs,...
    'RangeMethod','FFT','PRFSource','Property',...
    'RangeWindow','Hann','PRF',1/(Nt*waveform.SweepTime),...
    'SweepSlope',waveform.SweepBandwidth/waveform.SweepTime,...
    'RangeFFTLengthSource','Property','RangeFFTLength',nfft_r,...
    'DopplerFFTLengthSource','Property','DopplerFFTLength',nfft_d,...
    'DopplerWindow','Hann');

[resp,r,sp] = rngdop(xrv);

%%
% The resulting |resp| is a data cube containing the range-Doppler response
% for each element in the virtual array. As an illustration, the
% range-Doppler map for the first element in the virtual array is shown. 
f6 = figure;
plotResponse(rngdop,squeeze(xrv(:,1,:)));

%%
% The detection can be performed on the range-Doppler map from each pair of
% transmit and receive element to identify the targets in scene. In this
% example, a simple threshold-based detection is performed on the map
% obtained between the first transmit element and the first receive
% element, which corresponds to the measurement at the first element in the
% virtual array. Based on the range-Doppler map shown in the previous
% figure, the threshold is set at 10 dB below the maximum peak.

respmap = squeeze(mag2db(abs(resp(:,1,:))));
ridx = helperRDDetection(respmap,-10);
   
%%
% Based on the detected range of the targets, the corresponding range cuts
% can be extracted from the virtual array data cube to perform further
% spatial processing. To verify that the virtual array provides a higher
% resolution compared to the physical array, the code below extracts the
% range cuts for both targets and combines them into a single data matrix.
% The beamscan algorithm is then performed over these virtual array
% measurements to estimate the directions of the targets.

xv = squeeze(sum(resp(ridx,:,:),1))';

f4 = figure;
doa = phased.BeamscanEstimator('SensorArray',varray,'PropagationSpeed',c,...
    'OperatingFrequency',fc,'DOAOutputPort',true,'NumSignals',2,'ScanAngles',ang);
[Pdoav,target_az_est] = doa(xv);

fprintf('target_az_est = [%s]\n',num2str(target_az_est));

%%
% The two targets are successfully separated. The actual angles for the two
% cars are -10 and 10 degrees.

%%
% The next figure compares the spatial spectrums from the virtual and the
% physical receive array.
doarx = phased.BeamscanEstimator('SensorArray',rxarray,'PropagationSpeed',c,...
    'OperatingFrequency',fc,'DOAOutputPort',true,'ScanAngles',ang);
Pdoarx = doarx(xr);

helperPlotMultipledBPattern(ang,mag2db(abs([Pdoav Pdoarx])),[-30 0],...
    {'Virtual Array','Physical Array'},...
    'Spatial spectrum for virtual array and physical array',{'-','--'});

