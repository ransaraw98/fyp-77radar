% Input 2D complex array
complexArray = [1+2i, 3+4i; 5+6i, 7+8i];

% Get the size of the complex array
[row, col] = size(complexArray);

% Initialize the absolute value array
absoluteArray = int16(zeros(row, col));

% Calculate absolute values using a for loop
for i = 1:row
    for j = 1:col
        realPart = real(complexArray(i, j));
        imagPart = imag(complexArray(i, j));
        absoluteArray(i, j) = int16(sqrt(realPart^2 + imagPart^2));
    end
end

% Display the original and absolute value arrays
disp('Original Complex Array:');
disp(complexArray);
disp('Absolute Value Array:');
disp(absoluteArray);
