% Input parameters and key results are written to standard output.
% Last Modified by: Sayed Hasan (05/24/2004)

tSi = d;
fid1 = fopen('results.txt','w');

fprintf(fid1,'%s','The input parameters and key results are written in this file.');
fprintf(fid1,'\n');
fprintf(fid1,'\n');

fprintf(fid1,'%s','Input parameters:');
fprintf(fid1,'\n');

fprintf(fid1,'%s %-6.2e %s','Insulator thickness= ',t,'m'); %%%%%%%%%%%%%%%%%%%%%%
fprintf(fid1,'\n');

fprintf(fid1,'%s %-6.2e %s','NanoTube Diameter= ',tSi,'m'); %%%%%%%%%%%%%%%%%%%%
fprintf(fid1,'\n');

fprintf(fid1,'%s %-6.2f','Insulator relative dielectric constant= ',epsr);
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.2f %s','Temperature= ',T,'K');
fprintf(fid1,'\n');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f %s','Initial source Fermi Level= ',Ef,'eV');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f','Gate control parameter= ',alphag);
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f','Drain control parameter= ',alphad);
fprintf(fid1,'\n');

fprintf(fid1,'%s','Voltage Loop (fo both Vgs and Vds):');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f %s','Initial Bias VI_Gate= ',VI_Gate,'V');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f','Final Bias VF_Gate= ',VF_Gate,'V');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f','Voltage Step= ',(VF_Gate-VI_Gate)/(NV_Gate-1),'V');
fprintf(fid1,'\n');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f %s','Initial Drain Bias VI_Drain= ',VI_Drain,'V');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f','Final Drain Bias VF_Drain= ',VF_Drain,'V');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3f','Drain Voltage Step= ',(VF_Drain-VI_Drain)/(NV_Drain-1),'V');
fprintf(fid1,'\n');
fprintf(fid1,'\n');

fprintf(fid1,'%s','Key Results:');
fprintf(fid1,'\n');

fprintf(fid1,'%s %9.3e %s %3.2f %s %3.2f %s','Ion= ',I(NV_Drain,NV_Gate),'A/ at VG= ',V_Gate(NV_Gate), 'V and VD=',V_Drain(NV_Drain),'V');
fprintf(fid1,'\n');

fprintf(fid1,'%s %9.3e %s %3.2f %s %3.2f %s','Ioff= ',I(NV_Drain,1),'A/ at VG= ', V_Gate(1)', 'V and VD=',V_Drain(NV_Drain),'V');
fprintf(fid1,'\n');
fprintf(fid1,'\n');

fprintf(fid1,'%s %4.2f %s','S= ',S,'mV/dec'); %%%%%%%%%%%%%%%%%
fprintf(fid1,'\n');

fprintf(fid1,'%s %4.2f %s','DIBL= ',DIBL,'mV/V'); %%%%%%%%%%%%%%%%%%
fprintf(fid1,'\n');
fprintf(fid1,'\n');

fprintf(fid1,'%s %9.3e %s','Transconductance at highest gate and drain bias, gm= ',gm,'S/m');
fprintf(fid1,'\n');

fprintf(fid1,'%s %9.3e %s','Output conductance at highest gate and drain bias, gd= ',gd,'S/m');
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.2f','Voltage gain at highest gate and drain bias, Av= ',Av);
fprintf(fid1,'\n');

fprintf(fid1,'%s %5.3e %s','Carrier injection velocity at highest gate and drain bias, v_inj= ',vinj,'m/s');
fprintf(fid1,'\n');
fprintf(fid1,'\n');

fprintf(fid1,'%s','Plots:');
fprintf(fid1,'\n');
fprintf(fid1,'%s %3.2f %s %3.2f %s','Id-Vgs plots are at Vd= ', V_Drain(2), ' and Vd= ', V_Drain(NV_Drain), ' volts respectively.');
fprintf(fid1,'\n');

fprintf(fid1,'%s ','Id-Vds plots are at Vg= ');
for m=1:NV_Gate,
    fprintf(fid1,'%3.2f ', V_Gate(m));
end
fprintf(fid1, ' volts respectively.');

fclose(fid1);