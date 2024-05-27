% Save average velocity Data   added by Akira Matsudaira 07/17/2005

fid2 = fopen('Ave_vel_data.txt','wt');

fprintf(fid2,'%s','% Average velocity (unit: m/s).');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Column is corresponding to a average velocity vector with a fixed Vgs');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Row is corresponding to a average velocity vector with a fixed Vds');
fprintf(fid2,'\n');
fprintf(fid2,'\n');

k1=1;
for k2=1:NV_Gate
    fprintf(fid2,'%-9.2e',v_ave(k1,k2));
    fprintf(fid2,'%s',':');
end
fprintf(fid2,'\n');

fclose(fid2);
