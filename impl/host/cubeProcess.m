radarImage = xrvIso;
radarImage_i = real(radarImage);
radarImage_q = imag(radarImage);
radarImage_abs = abs(radarImage);

sc_factors = min(radarImage_abs,[],[1 3]);
sc_factors(2) = sc_factors(2)*5;
sc_factors(3) = sc_factors(3)*5;
sc_factors(4) = sc_factors(4)*5;
sc_factors(5) = sc_factors(5)*5;
sc_factors(6) = sc_factors(6)*5;
sc_factors(7) = sc_factors(7)*5;

%sc_fct = min(radarImage_abs,[],"all");
radarImage_sc_i = zeros(64,8,256);
radarImage_sc_q = zeros(64,8,256);

for i = 1:size(radarImage,2)
    radarImage_sc_i(:,i,:) = int16(radarImage_i(:,i,:)/sc_factors(i));
    radarImage_sc_q(:,i,:) = int16(radarImage_q(:,i,:)/sc_factors(i));
end

%radarImage_sc_i = int16(radarImage_i/sc_fct);
%radarImage_sc_q = int16(radarImage_q/sc_fct);
radarImage_sc = complex(radarImage_sc_i,radarImage_sc_q);

wr = kaiser(64,15);
wrsc = int16((wr/min(wr,[],"all"))/22);

%radarImageWind = complex(radarImage_sc_i .* wrsc,radarImage_sc_q .* wrsc);

rangeData   =  int16(fftshift(fft(radarImage_sc,64,1)));

rangedopplerData = int16(fftshift(fft(rangeData,256,3),3));
%output  =   abs(rangedopplerData);

% Get the size of the complex array
[row,channel, col] = size(rangedopplerData);

% Initialize the absolute value array
output = int16(zeros(row,channel, col));

% Calculate absolute values using a for loop
for i = 1:channel
    for j = 1:row
        for k = 1:col
            realPart = single(real(rangedopplerData(j,i, k)));
            imagPart = single(imag(rangedopplerData(j,i, k)));
            output(j,i, k) = int16(sqrt(realPart^2 + imagPart^2));
        end
    end
end
figure;
imagesc(squeeze(output(:,1,:)));

co_sum_image = sum(output,2);

figure;
imagesc(squeeze(co_sum_image));

max_sum = max(squeeze(co_sum_image),[],"all");
thresholded_image = (squeeze(co_sum_image) > max_sum/2);
imagesc(thresholded_image);
[objR,objC] =   find(thresholded_image);
subArray = zeros(160,8);

for i = 1:size(objR)
    subArray(i,:) = rangedopplerData(objR(i),:,objC(i));
end

fftobjs = fft(subArray,64,2); 
f = rad2deg(asin(linspace(-0.5*wavelength/d,+0.5*wavelength/d,64)));
[val,locs] = maxk(abs(fftobjs),1,2);
AoAs = f(locs);

for i=1:size(objR)
    text(objC(i),objR(i),num2str(AoAs(i)));
end
% 
[col,row] = size(squeeze(radarImage_sc_i(:,1,:)));
% % row = 1;
% % col = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WRITE ROM 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileID1 = fopen('radarImageROM1.txt','w');
temp_real = radarImage_sc_i(:,1,:);
temp_imag = radarImage_sc_q(:,1,:);

for i = 1:row
    for j = 1:col
        addr = ((i-1)*col)+((j-1));       % matlab indexing starts at 1 for some reason
        data = strcat('32''h',dec2hex(temp_imag(j,i),4),dec2hex(temp_real(j,i),4));
        addrstr = strcat('14''d',string(addr));
        if(mod(addr+1,3)==0)
            completeStr = strcat(addrstr,':','data <=',data,';','\n');
        else
           completeStr = strcat(addrstr,':','data <=',data,'; ');
        end
        fprintf(fileID1,completeStr);
    end
end 
fclose(fileID1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WRITE ROM 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileID2 = fopen('radarImageROM2.txt','w');
temp_real = radarImage_sc_i(:,2,:);
temp_imag = radarImage_sc_q(:,2,:);

for i = 1:row
    for j = 1:col
        addr = ((i-1)*col)+((j-1));       % matlab indexing starts at 1 for some reason
        data = strcat('32''h',dec2hex(temp_imag(j,i),4),dec2hex(temp_real(j,i),4));
        addrstr = strcat('14''d',string(addr));
        if(mod(addr+1,3)==0)
            completeStr = strcat(addrstr,':','data <=',data,';','\n');
        else
           completeStr = strcat(addrstr,':','data <=',data,'; ');
        end
        fprintf(fileID2,completeStr);
    end
end 
fclose(fileID2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WRITE ROM 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileID3 = fopen('radarImageROM3.txt','w');
temp_real = radarImage_sc_i(:,3,:);
temp_imag = radarImage_sc_q(:,3,:);

for i = 1:row
    for j = 1:col
        addr = ((i-1)*col)+((j-1));       % matlab indexing starts at 1 for some reason
        data = strcat('32''h',dec2hex(temp_imag(j,i),4),dec2hex(temp_real(j,i),4));
        addrstr = strcat('14''d',string(addr));
        if(mod(addr+1,3)==0)
            completeStr = strcat(addrstr,':','data <=',data,';','\n');
        else
           completeStr = strcat(addrstr,':','data <=',data,'; ');
        end
        fprintf(fileID3,completeStr);
    end
end 
fclose(fileID3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WRITE ROM 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileID4 = fopen('radarImageROM4.txt','w');
temp_real = radarImage_sc_i(:,4,:);
temp_imag = radarImage_sc_q(:,4,:);

for i = 1:row
    for j = 1:col
        addr = ((i-1)*col)+((j-1));       % matlab indexing starts at 1 for some reason
        data = strcat('32''h',dec2hex(temp_imag(j,i),4),dec2hex(temp_real(j,i),4));
        addrstr = strcat('14''d',string(addr));
        if(mod(addr+1,3)==0)
            completeStr = strcat(addrstr,':','data <=',data,';','\n');
        else
           completeStr = strcat(addrstr,':','data <=',data,'; ');
        end
        fprintf(fileID4,completeStr);
    end
end 
fclose(fileID4);