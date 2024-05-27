% Save gm/Id data added by Aman Singal and Akira Matsudaira 08/11/2005

fid2 = fopen('gm_data.txt','wt');

fprintf(fid2,'%s','% The gm/Id Information  (unit: /V).');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Column is corresponding to a gm/Id data with a fixed Vgs');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Row is corresponding to a gm/Id data with a fixed Vds');
fprintf(fid2,'\n');
fprintf(fid2,'\n');

A1=I(2,:);
A2=I(NV_Drain,:);

V_Gate;
y1=gradient(log(A1),V_Gate);
y2=gradient(log(A2),V_Gate);

for k1=1:NV_Gate
  fprintf(fid2,'%-9.2e',y1(k1));
  fprintf(fid2,'%s',':');
end
fprintf(fid2,'\n');

for k1=1:NV_Gate
  fprintf(fid2,'%-9.2e',y2(k1));
  fprintf(fid2,'%s',':');
end
fprintf(fid2,'\n');


fclose(fid2);
