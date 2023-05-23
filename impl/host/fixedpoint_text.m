% Create a fix16_15 format object
fixFormat = fimath('RoundingMethod', 'Floor', 'OverflowAction', 'Wrap');
fixPointObj = fi(0, true, 16, 15, fixFormat);

% Define the size of the array
arraySize = [10, 5];  % Example size: 10 rows and 5 columns

% Declare the array with zeros in complex fix16_15 format
zerosArray = complex(fi(zeros(arraySize), true,16,15,fixFormat), fi(zeros(arraySize), true,16,15,fixFormat));
