window_size = 64;

wr = blackmanharris(64);
wr_scaled = wr * (2^3 -1);
wr_scaled_int = int16(wr_scaled);

wvtool(wr_scaled_int);

fileID = fopen('window1_coefficients.txt','w');

for i = 1:window_size
     addr = i-1;       % matlab indexing starts at 1 for some reason
     data = strcat('3''h',dec2hex(wr_scaled_int(i),1));
     addrstr = strcat('6''d',string(addr));
        if(mod(addr+1,3)==0)
            completeStr = strcat(addrstr,':','data <=',data,';','\n');
        else
           completeStr = strcat(addrstr,':','data <=',data,'; ');
        end
        fprintf(fileID,completeStr);
end
fclose(fileID);