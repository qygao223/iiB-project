% Save Current Data   added by Jing Wang 09/09/2003
% Last Modified by: Sayed Hasan (05/24/2004)

fid2 = fopen('current_data.txt','w');

fprintf(fid2,'%s','% The Current Information  (unit: muA/mum).');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Column is corresponding to a Id-Vds vector with a fixed Vgs');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Row is corresponding to a Id-Vgs vector with a fixed Vds');
fprintf(fid2,'\n');
fprintf(fid2,'\n');

for k1=1:NV_Drain
    for k2=1:NV_Gate
        fprintf(fid2,'%-9.2e',I(k1,k2)*1e6);
        fprintf(fid2,'%s',':');
    end
    fprintf(fid2,'\n');
end

fclose(fid2);
