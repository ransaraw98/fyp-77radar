radarImage = squeeze(xrvIso(:,1,:));
radarImage_i = real(radarImage);
radarImage_q = imag(radarImage);
radarImage_abs = abs(radarImage);
sc_fct = min(radarImage_abs,[],"all");

radarImage_sc_i = int16(radarImage_i/sc_fct);
radarImage_sc_q = int16(radarImage_q/sc_fct);
radarImage_sc = complex(radarImage_sc_i,radarImage_sc_q);

wr = blackmanharris(64);
wr_scaled = wr * (2^7 -1);
wr_scaled_int = int16(wr_scaled);

%wrsc = int16((wr/min(wr,[],"all"))/22);

%radarImage_sc   =   complex(int16(radarImage_sc_i.*wr_scaled_int),int16(radarImage_sc_q.*wr_scaled_int));
%radarImageWind = complex(radarImage_sc_i .* wrsc,radarImage_sc_q .* wrsc); 
rangeData       =   int16(fftshift(fft(radarImage_sc,64,1)));
rangeData       =   complex(int16(real(rangeData)/5),int16(imag(rangeData)/5));

wd = hann(256);
wd_scaled = wd * (2^7 -1);
wd_scaled_int = int16(wd_scaled);
rangeDataReW = transpose(wd_scaled_int).* real(rangeData);
rangeDataImW = transpose(wd_scaled_int).* imag(rangeData);
%rangeData = complex(int16(rangeDataReW/256), int16(rangeDataImW/256));

%rangeData = complex(int16(transpose(wd_scaled_int).*(real(rangeData))),int16(transpose(wd_scaled_int).*(imag(rangeData))));
rangedopplerData = int16(fftshift(fft(rangeData,256,2),2));
%output  =   abs(rangedopplerData);

% Get the size of the complex array
[row, col] = size(rangedopplerData);

% Initialize the absolute value array
output = int16(zeros(row, col));

% Calculate absolute values using a for loop
for i = 1:row
    for j = 1:col
        realPart = single(real(rangedopplerData(i, j)));
        imagPart = single(imag(rangedopplerData(i, j)));
        output(i, j) = int16(sqrt(realPart^2 + imagPart^2));
    end
end

figure;
imagesc(output);

[col,row] = size(radarImage_sc_i);
% row = 1;
% col = 5;
fileID = fopen('radarImageROM.txt','w');


for i = 1:row
    for j = 1:col
        addr = ((i-1)*col)+((j-1));       % matlab indexing starts at 1 for some reason
        data = strcat('32''h',dec2hex(radarImage_sc_q(j,i),4),dec2hex(radarImage_sc_i(j,i),4));
        addrstr = strcat('14''d',string(addr));
        if(mod(addr+1,3)==0)
            completeStr = strcat(addrstr,':','data <=',data,';','\n');
        else
           completeStr = strcat(addrstr,':','data <=',data,'; ');
        end
        fprintf(fileID,completeStr);
    end
end

fclose(fileID);
