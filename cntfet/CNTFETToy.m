function [I] = CNTFETToy( t,d,epsr,T, VI,VF,NV, Ef,alphag,alphad,Rs )
clear all;
% function [I,V,Uscf,N] = CNTFETToy( t,d,epsr,T, VI,VF,NV,  Ef,alphag,alphad )
%    Inputs:
%   ----------------
%       t - insulator thickness (m)
%       d - NT diameter (m)
%       epsr - insulator dielectric constant
%       T - Temp (K)
%
%       VI - Initial Voltage
%       VF - Final Voltage
%       NV - # of bias points
%
%       Ef - Fermi Level
%       alphag - gate control parameter
%       alphad - drain control parameter
%
%   Outputs:
%   ------------------
%       I = Current
%       V = Voltage
%       Uscf = Self Consistent Potential 
%       N = Free charge
%
% Based on FETToy Originally developed by : Anisur Rahman
%   Reference:
%   [1] A. Rahman, J. Guo, S. Datta, and M. Lundstrom,
%   "Theory of Ballistic Nanotransistors", to appear in IEEE TED, 2003.
%
% Adapted for CNTFETToy by : Jing Wang
% Latest Version Updated by : Sayed Hasan (05/24/2004)
%--------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Original Note by Anisur Rahman                                                  %% 
%%---------------------------------------------------------------------------------%% 
%% Name: FETToy                                                                    %% 
%% Written by Anisur Rahman, Purdue University, Dec 24, 2002                       %%
%% email: rahmana@purdue.edu                                                       %%
%% Routines used: input.m, plot_output.m, fermi.m, Uscf_zero.m, write_results.m    %%
%%                                                                                 %%
%% Reference:                                                                      %%
%% [1] A. Rahman, J. Guo, S. Datta, and M. Lundstrom,                              %%
%% "Theory of Ballistic Nanotransistors", to appear in IEEE TED, 2003.             %%
%%                                                                                 %%
%% Analytically calculates the ballistic I-V of a Double Gate ultra thin body      %%
%% MOSFET assuming that only the lowest unprimed subband is occupied (All          %%
%% constants are in MKS unit except energy, which is in eV)                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Physical constants
m0=0.91e-30;    hbar=1.05e-34;      q=1.62e-19;    eps0=8.85e-12;     kB=1.38e-23; 

% FETToy for CNTFETs ...
T=300; d=1.2e-9; 
Eg=2*0.142e-9*3/d
Ef=0; t=20e-9; epsr=25; 
alphag=1.137; alphad=0.04; Rs=0;
VI_d=0;VF_d=3;NV_Drain=50;
VI_g=-1.5;VF_g=2;NV_Gate=8; Vs=0;
Vth=3.03*2.49e-10/(sqrt(3)*d)


kT=kB*T/q;                         % Thermal voltage.
V_Drain=linspace(VI_d,VF_d,NV_Drain);              % Voltage (gate or drain) steps.
V_Gate=linspace(VI_g,VF_g,NV_Gate);

Cins=2*pi*epsr*eps0/log((t+d/2)/(d/2));  % Capacitance per unit length
CG=Cins;
CD=0.04*Cins;
CS=0.097*Cins;
C_SIG=CG+CD+CS                    % C_SIG=sum of capacitors (see eq. (7b) in [1]).  
U0=q/C_SIG;                         % Charging energy (eq. (8b) in [1]).

% for CNTFETs (calculate D0 and EG)
dd=d;                   % tube diameter
a_cc=1.42e-10;          % C-C bond length
t0=3.0;                 % Overlap Integral TB parameter
D0=8/(3*pi*a_cc*t0);    % DOS [1/(m*eV)], the DOS is expressed as: Dznt(E) == 4/(3*pi*t*a_cc)*(E/sqrt(E^2-Ev^2)),for up- and down- branches and +/-kx;
                        % here we should include the spin by times a factor of '2', 
                        % this is the constanct pre-factor of the DOS for a zigzag CNT, the valley degeneracy is not included so far.
EG=2*a_cc*t0/dd;        % Band Gap [eV], corresponding to the minimum bandgap of a semiconducting zigzag CNT when abs(v-2m/3)==1
N0=N_CNT(D0,EG,kT,Ef);  % Electron concentration at the top of the barrier in neutral device.
I0=(2*q*kB*T/(pi*hbar));  % Current per unit energy; the factor '2' accounts for the valley degeneracy is 2

% Start Usual calculation
N=zeros(NV_Drain,NV_Gate);         % Mobile charge density.
I=zeros(NV_Drain,NV_Gate);         % Current.
%Ef_mat=zeros(NV,NV);    % Source Fermi level.   
%Esub_max=zeros(NV,NV);  % Energy at the top of the barrier.

% CQ=zeros(NV,1);         % Qauntum Capacitance
% v_ave=zeros(NV,1);      % average velocity


for kVg=1:NV_Gate            % Bias loop begins.
    Vg=V_Gate(kVg);  
    for kV=1:NV_Drain
        Vd=V_Drain(kV);
        mu1=Ef;
        mu2=mu1-q*(Vd-Vs);                                   % Source and drain fermi levels.
        UL=-((CG/C_SIG)*Vg)-((CD/C_SIG)*Vd)-((CS/C_SIG)*Vs);                            % Laplace potential.
        Uscf=fzero(@Uscf_zero,0,optimset('tolx',1e-12),D0,EG,mu1,mu2,kT,UL,U0,N0);
        fermi_flag=1; if (mu1-Uscf)/kT<-20, fermi_flag=0; end
        dN=N_CNT(D0/2,EG,kT,mu1-Uscf)+N_CNT(D0/2,EG,kT,mu2-Uscf)-N0;   % Mobile charge induced by gate and drain 
                                                         
        N(kV,kVg)=dN;
        eta1=(mu1-Uscf)/kT; eta2=(mu2-Uscf)/kT;
        
        % Vd changes along fixed column and Vg changes along fixed row.
        I(kV,kVg)=I0*(fermi(eta1,fermi_flag,0)-fermi(eta2,fermi_flag,0));
        Esub_max(kV,kVg)=Uscf;
        %Ef_mat(kV,kVg)=mu1; 
        
        % Added by Sayed Hasan 5/26/2004
        Us(kV,kVg) = Uscf;
        
        % Quantum Capacitance and velocity calculation added by Sayed Hasan 05/28/2004
        if ((kV==2)|(kV==NV_Drain)),
            deltaU = 0.002*kT;
            if (kV==2),
                N_U2 =  N_CNT(D0/2,EG,kT,mu1-Uscf+deltaU/2)+N_CNT(D0/2,EG,kT,mu2-Uscf+deltaU/2)-N0; 
                N_U1 =  N_CNT(D0/2,EG,kT,mu1-Uscf-deltaU/2)+N_CNT(D0/2,EG,kT,mu2-Uscf-deltaU/2)-N0; 
                CQ(1, kVg) = q*(N_U2-N_U1)/deltaU;
                %q*(N_CNT(D0/2,EG,kT,mu1-Uscf+0.001*kT)-N_CNT(D0/2,EG,kT,mu1-Uscf-0.001*kT))/(0.002*kT);
            elseif (kV==NV_Drain),
                N_U2 =  N_CNT(D0/2,EG,kT,mu1-Uscf+deltaU/2)+N_CNT(D0/2,EG,kT,mu2-Uscf+deltaU/2)-N0; 
                N_U1 =  N_CNT(D0/2,EG,kT,mu1-Uscf-deltaU/2)+N_CNT(D0/2,EG,kT,mu2-Uscf-deltaU/2)-N0; 
                CQ(2, kVg) = q*(N_U2-N_U1)/deltaU;
                %CQ(2, kVg)=q*(N_CNT(D0/2,EG,kT,mu1-Uscf+0.001*kT)-N_CNT(D0/2,EG,kT,mu1-Uscf-0.001*kT))/(0.002*kT);
                v_ave(kVg)=I(kV,kVg)/q/(dN+N0);
            end
        end
    end
end                     % Bias loop ends.

figure;
hold on;
for i = 1:size(I, 2) % Loop through columns (fixed Vgs)
    plot(V_Drain, I(:, i)*1e3, 'DisplayName', sprintf('Vgs = %.2f', V_Gate(i)));
end

xlabel('Vds (V)');
ylabel('Ids (mA)');
title('CNTFET Ids vs. Vds');
legend('Location', 'best');
grid on;
hold off;

%%%%%%%%%%%%%%%  OUTPUT (Sayed Hasan: 5/25/2004)  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot_output;            % Plot results
%save_charge;            % Save q*N
%save_current;           % Save I
%save_uscf;              % Save Us
%write_results;          % Write results in results.m file
save rawdata;           % save matlab variables
