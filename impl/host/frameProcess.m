% Sample radar frame
radarFrame = squeeze(xrvIso(:,1,:)); % Replace with your actual radar frame data

% Range compression (matched filtering)
rangeCompressed = fft(radarFrame, [], 1);

% Doppler processing (range-Doppler map)
rangeDopplerMap = fftshift(fft(rangeCompressed, [], 2), 2);

% Target detection (thresholding example)
threshold = 0.5; % Set the detection threshold
detections = abs(rangeDopplerMap) > threshold;

% Visualize the range-Doppler map
figure;
imagesc(db(abs(rangeDopplerMap)));
xlabel('Slow Time');
ylabel('Fast Time');
colorbar;
title('Range-Doppler Map');

% Visualize the target detections
figure;
imagesc(detections);
xlabel('Slow Time');
ylabel('Fast Time');
title('Target Detections');

% Processed radar frame obtained after range compression and Doppler processing
processedFrame = rangeDopplerMap; % Replace with your actual processed radar frame

% CFAR parameters
guardCells = 4; % Number of guard cells on each side
trainingCells = 16; % Number of training cells on each side
probabilityFalseAlarm = 1e-3; % Desired probability of false alarm

% Size of the processed frame
[numRangeBins, numDopplerBins] = size(processedFrame);

% Threshold calculation
windowSize = (2 * guardCells + 2 * trainingCells) + 1;
numTrainingCellsTotal = 2 * trainingCells + 1;
numGuardCellsTotal = 2 * guardCells;
numCellsTotal = windowSize - numGuardCellsTotal - numTrainingCellsTotal;
numReferenceCells = numCellsTotal - 1;

thresholdFactor = (numCellsTotal * probabilityFalseAlarm) ^ (-1 / numReferenceCells);
threshold = thresholdFactor * sum(processedFrame(:)) / numCellsTotal;

% CFAR detection
detections = zeros(numRangeBins, numDopplerBins);

for i = (1 + guardCells):(numRangeBins - guardCells)
    for j = (1 + guardCells):(numDopplerBins - guardCells)
        trainingRegion = processedFrame((i - trainingCells):(i + trainingCells), ...
                                         (j - trainingCells):(j + trainingCells));
        referenceRegion = processedFrame((i - guardCells):(i + guardCells), ...
                                          (j - guardCells):(j + guardCells));
        
        thresholdRegion = threshold * sum(referenceRegion(:)) / numCellsTotal;
        
        if processedFrame(i, j) > thresholdRegion
            detections(i, j) = 1;
        end
    end
end

% Visualize the target detections
figure;
imagesc(detections);
xlabel('Doppler Bins');
ylabel('Range Bins');
title('Target Detections');

