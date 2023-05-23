% Sample MATLAB 2D array (complex data)
matlabArray = squeeze(xrvIso(:,1,:));
matlabArray = matlabArray/min(matlabArray,[],"all");
% Open a text file for writing
fileID = fopen('verilog_array.txt', 'w');

% Convert and write the Verilog array to the text file
[row, col] = size(matlabArray);
for r = 1:row
    for c = 1:col
        % Convert complex number to 16-bit fixed-point representation
        complexValue = matlabArray(r, c);
        realPart = fi(real(complexValue), 1, 16, 0);   % 16-bit signed fixed-point, 1 integer bit, 15 fractional bits
        imagPart = fi(imag(complexValue), 1, 16, 0);   % 16-bit signed fixed-point, 1 integer bit, 15 fractional bits
        
        % Convert real and imaginary parts to hex strings
        realHex = dec2hex(realPart, 4);
        imagHex = dec2hex(imagPart, 4);
        
        % Write the hex strings to the text file
        fprintf(fileID, '32''h%s%s\n', realHex, imagHex);
    end
end

% Close the text file
fclose(fileID);
