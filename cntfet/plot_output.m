% Plotting Results
% Original: Anisur Rahman
% Modified By:
%       Jing Wang
%       Sayed Hasan (05/26/2004)
%-------------------------------------------------------------------------
lwpl=2;                       % Plot line width
lwbor=1;                      % Border line width
fsize=18;                     % Font size

string_matrix=[];
for m=1:NV_Gate,
    string_matrix = strvcat(string_matrix, ['Vgs = ', num2str(V_Gate(m),3)]);
end

% Plotting Id-Vg (linear)
figure(1);
if (NV_Drain > 1),
    h1=plot(V_Gate,I(2,:)*1e6,'*',V_Gate,I(NV_Drain,:)*1e6,'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
    set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
    legend(['V_{Ds}=',num2str(V_Drain(2),3)],['V_{Ds}=',num2str(V_Drain(end),3)], 'Location',"northwest");
else
    h1=plot(V_Gate,I*1e6, 'k');
end
set(h1,'linewidth',[lwpl]);
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('I_{DS} [uA]');
set(h1,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
print -dpsc Id_vs_Vgs_lin;

% Plotting Id-Vg (Semilog)
figure(2);
if (NV_Drain > 1),
    h1=semilogy(V_Gate,I(2,:)*1e6,'*',V_Gate,I(NV_Drain,:)*1e6,'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
    set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
    legend(['V_{Ds}=',num2str(V_Drain(2),3)],['V_{Ds}=',num2str(V_Drain(end),3)],'Location','SouthEast');
else
    h1=semilogy(V_Gate,I*1e6, 'k');
end
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('I_{DS} [uA]');
set(h1,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
print -dpsc Id_vs_Vgs_log;



% Plotting Id-Vd
figure(3);
h1 = plot(V_Drain, I*1e6);
legend(string_matrix);%-1
%set(gca,'Fontsize',[fsize],'linewidth',[lwbor],'plotboxaspectratio',[2,1,1]);
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
set(h1,'linewidth',[lwpl]);
xlabel('V_D [Volt]');
ylabel('I_{DS} [uA]');
set(gca,'xlim',[V_Drain(1) V_Drain(NV_Drain)]);
print -dpsc Id_vs_Vds;

figure(4)
h2 = plot(V_Gate, N(2,:)/100,'*', V_Gate, N(NV_Drain,:)/100,'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('mobile charge/q [#/cm]');
set(h2,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
legend(['V_{Ds}=',num2str(V_Drain(2),3)],['V_{Ds}=',num2str(V_Drain(end),3)]); %2
print -dpsc N_vs_Vgs_lin;

figure(5)
h2 = semilogy(V_Gate, abs(N(2,:))/100, '*',V_Gate, abs(N(NV_Drain,:))/100,'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('mobile charge/q [#/cm]');
set(h2,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
legend(['V_{Ds}=',num2str(V_Drain(2),3)],['V_{Ds}=',num2str(V_Drain(end),3)]);%4
print -dpsc N_vs_Vgs_log;

figure(6);
h2=plot(V_Drain,N/100);
legend(string_matrix);%-1
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_D [Volt]');
ylabel('mobile charge/q [#/cm]');
set(h2,'linewidth',[lwpl]);
set(gca,'xlim',[V_Drain(1) V_Drain(NV_Drain)]);
print -dpsc N_vs_Vds;

figure(7);
h2=plot(V_Gate,CQ(1,:)/100,'b*', V_Gate,CQ(2,:)/100, 'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
%set(gca,'Fontsize',[fsize],'linewidth',[lwbor],'plotboxaspectratio',[2,1,1]);
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('quantum capacitance [F/cm]');
set(h2,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
legend(['V_{Ds}=',num2str(V_Drain(2),3)],['V_{Ds}=',num2str(V_Drain(end),3)],'Location','NorthWest');
print -dpsc CQ_vs_Vgs;

figure(8);
h2=plot(V_Gate,v_ave*100);
%set(gca,'Fontsize',[fsize],'linewidth',[lwbor],'plotboxaspectratio',[2,1,1]);
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('average velocity [cm/s]');
set(h2,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
print -dpsc Velocity_vs_Vgs;

figure(9);
A1=I(2,:); % Id value at low drain voltage
A2=I(NV_Drain,:); % Id value at high drain voltage
y1=gradient(log(A1),V_Gate);
y2=gradient(log(A2),V_Gate);
%%

gm_id_data1=y1;
gm_id_data2=y2;
%h2=plot(V,gm_id_data (1,:),'o', V,gm_id_data (2,:), 'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
h2=plot(V_Gate,gm_id_data2, 'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('gm/Id [1/V]');
set(h2,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
%legend(['V_{Ds}=',num2str(V(2),3)],['V_{Ds}=',num2str(V(end),3)], 4, 'Location','NorthEast');
print -dpsc gm_vs_Vgs;


%%% added by Yang Liu 11/23/2005

figure(10);
h2=plot(V_Gate,CQ(1,:)./Cins,'r*', V_Gate,CQ(2,:)./Cins, 'g-diamond','MarkerEdgeColor','g','MarkerFaceColor','g');
set(gca,'Fontsize',[fsize],'linewidth',[lwbor]);
xlabel('V_G [Volt]');
ylabel('CQ/Cins');
set(h2,'linewidth',[lwpl]);
set(gca,'xlim',[V_Gate(1) V_Gate(NV_Gate)]);
legend(['V_{Ds}=',num2str(V_Drain(2),3)],['V_{Ds}=',num2str(V_Drain(end),3)], 'Location','NorthWest');
print -dpsc gm_vs_Vgs;
