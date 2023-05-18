
frame = squeeze(xrvIso(:,1,:));
minReal = min(real(frame),[],"all");
minImag = min(imag(frame),[],"all");
frameScaled = frame/min(minReal,minImag);
fixFormat = fimath('RoundingMethod', 'Floor', 'OverflowAction', 'Wrap',ProductMode='KeepMSB',ProductFixedExponent=1,ProductFractionLength=15,SumMode='KeepMSB',SumFixedExponent=1,SumFractionLength=15,SumWordLength=16,ProductWordLength=16);

%frame = fi(frame, true, 16, 15,fixFormat);


framesize = size(frame);
rangeFFTlen = framesize(1);
dopplerFFTlen = framesize(2);

%wr = hann(64);
wr = kaiser(64,15);
%wd = hann(256);
wd = kaiser(256,25);
%w = fftshift(w);
frame = wr .* frame;

arraySize = [64 256];

rangeData = fftshift(fft(frame,64,1));
% rangeFFT = dsp.FFT('FFTLengthSource','Property','FFTLength',64,'ProductDataType','Custom');
% rangeData = complex(fi(zeros(arraySize), true,16,15,fixFormat), fi(zeros(arraySize), true,16,15,fixFormat));
% for i=1:256
%     rangeData(:,i) = rangeFFT(frame(:,i));
% end

rangeData = transpose(wd).* rangeData;

dopplerData = fftshift(fft(rangeData,256,2),2);

% dopplerFFT = dsp.FFT('FFTLengthSource','Property','FFTLength',256,'ProductDataType','Custom');
% dopplerData = complex(fi(zeros(arraySize), true,16,15,fixFormat), fi(zeros(arraySize), true,16,15,fixFormat));
% for i=1:64
%     dopplerData(i,:) = dopplerFFT(transpose(rangeData(i,:)));
% end


rangeDopplerMap2    = abs(dopplerData) ;
%rangeDopplerMap2 = uint16(rangeDopplerMap2);
% Target detection (thresholding example)
threshold = max(rangeDopplerMap2,[],"all")/8; % Set the detection threshold
rangeDopplerMap2(rangeDopplerMap2 < threshold ) = 0 ;

rangeax = ((-rangeFFTlen/2 : rangeFFTlen/2 - 1) * waveform.SampleRate)/rangeFFTlen;
rangeax = fftshift(rangeax);
rangeax = c * rangeax/(2*waveform.SweepBandwidth/waveform.SweepTime);

PRF = 1/(Nt*waveform.SweepTime);
velocityax = ((-dopplerFFTlen/2 : dopplerFFTlen/2 - 1) * PRF)/dopplerFFTlen;
velocityax = fftshift(velocityax);
velocityax = velocityax * lambda/(2*waveform.SweepTime);

% Visualize the range-Doppler map
% figure;
% imagesc(db(abs(rangeDopplerMap)));
% xlabel('Slow Time');
% ylabel('Fast Time');
% colorbar;
% title('Range-Doppler Map');

figure;
 %imagesc(rangeax,velocityax,db(rangeDopplerMap2));
 imagesc(db(rangeDopplerMap2));
 xlabel('Speed');
 ylabel('Range');
 %yticks(rangeax);
 %ylim([min(rangeax) max(rangeax)]);
 colorbar;
 title('Range-Doppler Map');

 