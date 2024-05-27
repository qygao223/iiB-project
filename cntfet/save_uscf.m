% Uscf Data added by Sayed Hasan 05/26/2004

fid2 = fopen('uscf_data.txt','w');

fprintf(fid2,'%s','%Self-Consistent Potential Information  (unit: eV).');
fprintf(fid2,'\n');
fprintf(fid2,'%s','%Each Column is corresponding to a Id-Vds vector with a fixed Vgs');
fprintf(fid2,'\n');
fprintf(fid2,'%s','%Each Row is corresponding to a Id-Vgs vector with a fixed Vds');
fprintf(fid2,'\n');
fprintf(fid2,'\n');

for k1=1:NV_Drain
    for k2=1:NV_Gate
        fprintf(fid2,'%-9.2e',Us(k1,k2));
        fprintf(fid2,'%s',':');
    end
    fprintf(fid2,'\n');
end

fclose(fid2);
