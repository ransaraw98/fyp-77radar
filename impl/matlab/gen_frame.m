% Specify parameters
n_samples = 128;
n_frequencies = 4;
n_signals = 512;
fs = 12000; % Sampling frequency (Hz)
frequencies = [500 1000 2000 4000]; % Sine wave frequencies (Hz)

% Generate sine wave matrix
t = linspace(0, 1, n_samples); % Time vector
sine_matrix = zeros(n_frequencies, n_samples);
for ii = 1:n_frequencies
    sine_matrix(ii,:) = sin(2*pi*frequencies(ii)*t);
end

% Generate signal matrix
signal_matrix = zeros(n_signals, n_samples);
for ii = 1:n_signals
    % Choose random combination of frequencies for each signal
    freq_indices = randperm(n_frequencies);
    freq_indices = freq_indices(1:2); % Choose 2 frequencies
    signal_matrix(ii,:) = sine_matrix(freq_indices(1),:) + sine_matrix(freq_indices(2),:);
end

% Convert signal matrix to 32-bit integer array
signal_int_matrix = int32(signal_matrix*32767); % Scale and convert to 16-bit integer
signal_int_matrix = bitshift(signal_int_matrix, 16); % Shift bits to upper 16 bits
signal_int_matrix = bitshift(signal_int_matrix, -16); % Shift bits to upper 16 bits
signal_int_matrix = bitand(signal_int_matrix,int32(hex2dec('0000FFFF')));
% Compute Fourier transform
fft_signal_matrix = fftshift(fft(signal_matrix, [], 2), 2);
freq_axis = linspace(-fs/2, fs/2, n_samples);

% Write integer array to C header file
fileID = fopen('signal_data.h','w');
fprintf(fileID, 'const int signal_data[%d][%d] = {\n', n_signals, n_samples);
for ii = 1:n_signals
    fprintf(fileID, '{');
    fprintf(fileID, '%#x, ',signal_int_matrix(ii,1:end-1));
    fprintf(fileID, '%#x', signal_int_matrix(ii,end));
    fprintf(fileID, '}');
    if ii < n_signals
        fprintf(fileID, ',\n');
    else
        fprintf(fileID, '};\n');
    end
end
fclose(fileID);

% Display signals and Fourier transformed heatmap
figure
subplot(2,1,1)
plot(t, signal_matrix(1:10,:)')
xlabel('Time (s)')
ylabel('Amplitude')
title('Signals')
subplot(2,1,2)
imagesc(freq_axis, 1:n_signals, abs(fft_signal_matrix).^2)
xlabel('Frequency (Hz)')
ylabel('Signal')
title('Fourier Transform')
colorbar
