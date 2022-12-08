Y = fft(xrvIso(:,1,1));
S = waveform.SweepBandwidth / waveform.SweepTime;
Y = abs(Y);
Y = Y(1:L(1)/2);
L = size(xrvIso(:,1,1));
faxis = fs*(0:(L(1)/2-1))/(L(1)-1);
figure;
plot(faxis,Y);
[pks,locs] = findpeaks(Y);
max_peak = max(pks);

for i=1:L(1)/2
    if(Y(i) < max_peak*0.2)
        Y(i) = 0;
    end
end

plot(faxis,Y);
[~,locsr] = findpeaks(Y);
beats = fs*locsr/L(1);
ranges = beat2range(beats,S,c);
disp(ranges);

%take the fft along the indices of range detections
dopplerData = angle(squeeze(xrvIso(locsr,3,:)));
Ld = size(dopplerData);
dopplerFFT = zeros(Ld(1),Ld(2)/2);
fsd = 1/(Nt*waveform.SweepTime);
faxisd = linspace(0,lambda/(4*2*waveform.SweepTime),Ld(2)/2);

 for i=1:Ld(1)
    tFFT = fft(dopplerData(i,:)); 
   dopplerFFT(i,:) = abs(tFFT(1:Ld(2)/2));
 end
nObj = size(locsr);
locsd = [];
 for i=1:nObj(1)
     [dpeaks, ~] = findpeaks(dopplerFFT(i,:));
     %FILTERING THE NOISE
     for j = 1:Ld(2)/2
        if (dopplerFFT(i,j) < max(dpeaks))
            dopplerFFT(i,j) = 0;
        end
     end
     %processing
     [~,locs] = findpeaks(dopplerFFT(i,:));
     locsd = [locsd locs];
     dopplers = (1/Ld(2))*locs;
     speeds = doppler2speed(lambda,2*waveform.SweepTime,dopplers);
     figure;
     plot(faxisd, dopplerFFT(i,:));
     disp(speeds);
 end
%angle FFT
angleCube = [];
for idx = 1:nObj(1)
    angleCube = [angleCube;xrvIso(locsr(idx),:,locsd(idx))];
end

angleCube   =   angle(angleCube);

angleFFT    = fft(angleCube,Nt*Nr,1);

anaxis      = ((2*pi/(Nt*Nr))*linspace(0,2*pi,Nt*Nr))*(180/pi);
figure;
plot(anaxis, abs(angleFFT(1,:)));
figure;
plot(anaxis, abs(angleFFT(2,:)));

H = phased.ESPRITEstimator('SensorArray',varrayIso,'OperatingFrequency', 77e9);
doass = H(xvIso);
% 
% [dpeaks, locs] = findpeaks(dopplerFFT(2,:));
% for i = 1:Ld(2)/2
%     if (dopplerFFT(2,i) < max(dpeaks))
%         dopplerFFT(2,i) = 0;
%     end
% end
% 
% [~,locs] = findpeaks(dopplerFFT(2,:));
% dopplers = (1/Ld(2))*locs;
% speeds = doppler2speed(lambda,waveform.SweepTime,dopplers);
% plot(faxisd, dopplerFFT(2,:));
% %disp(speeds);
% 
% %root music
% [pks,locs] = findpeaks(Y);
% sweep_slope = waveform.SweepBandwidth/waveform.SweepTime;
% ant1data = squeeze(xrvIso(:,1,:));
% fb_rng = rootmusic(pulsint(ant1data,'coherent'),2,fs);
% rng_est = beat2range(fb_rng, sweep_slope, c);
% peak_loc = val2ind(rng_est, c/fs*2);
% fd = -rootmusic(ant1data(locs,:),1,1/waveform.SweepTime);
% v_est = dop2speed(fd,lambda)/2;
% disp(v_est);

