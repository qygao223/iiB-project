% Save Quantum capacitance Data   added by Akira Matsudaira 07/17/2005

fid2 = fopen('CQ_Cins_data.txt','wt');

fprintf(fid2,'%s','% The Quantum Capacitance / Insulator capacitance');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Column is corresponding to a CQ/Cins with a fixed Vgs');
fprintf(fid2,'\n');
fprintf(fid2,'%s','% Each Row is corresponding to a CQ/Cins with a fixed Vds');
fprintf(fid2,'\n');
fprintf(fid2,'\n');

for k1=1:2
    for k2=1:NV_Gate
        fprintf(fid2,'%-9.2e',CQ(k1,k2)/Cins);
        fprintf(fid2,'%s',':');
    end
    fprintf(fid2,'\n');
end

fclose(fid2);
