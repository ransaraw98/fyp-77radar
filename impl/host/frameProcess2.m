
frame = squeeze(xrvIso(:,1,:));

%w = kaiser(64,4);
frame = w .* frame;

rangeCompressed = fftshift(fft(frame, [], 1));
rangeData = fftshift(fft(frame,64,1));
rangeDataPhase = angle(rangeData);

%rangeData = w.* rangeData;
%dopplerData = fftshift(fft(rangeDataPhase,256,2));
dopplerData = fftshift(fft(rangeData,256,2));
rangeDopplerMap = fftshift(fft(rangeCompressed, 256, 2), 2);

%rangeDopplerMap2    = abs(rangeData) + abs(dopplerData);
rangeDopplerMap2    = abs(dopplerData) ;
% Target detection (thresholding example)
threshold = max(rangeDopplerMap2,[],"all")/32; % Set the detection threshold
rangeDopplerMap2(rangeDopplerMap < threshold ) = 0 ;

% Visualize the range-Doppler map
% figure;
% imagesc(db(abs(rangeDopplerMap)));
% xlabel('Slow Time');
% ylabel('Fast Time');
% colorbar;
% title('Range-Doppler Map');

figure;
 imagesc(db(rangeDopplerMap2));
 xlabel('Slow Time');
 ylabel('Fast Time');
 colorbar;
 title('Range-Doppler Map');

 