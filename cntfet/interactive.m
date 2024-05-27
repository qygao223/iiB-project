% CNTFETToy (Toy model to simulate I-V characteristics of nanoscale carbon nanotube(CNT) FETs)
%
%
% Input
% -----
% Device Specification:  
%          Gate Insulator Thickness, t (m)
%          Gate Insulator Dielectric Constant, epsr
%          Tube Diameter, d (m)
%          Temperature, T (K)
%
% Terminal Voltage:  Number of Bias Points, NV
%                    Voltage Range, VI,VF (V)
%
% Analytical Model:  Source Fermi Level, Ef (eV)
%                    Gate Control Parameter, alphag
%                    Drain Control Parameter, alphad
%
% Output
% ------
% 1.  Text files: 
%       A. current_data.txt
%       B. results.txt
%
% 2.  Following plots:
%       A. Id vs. Vgs At 2nd and Last Drain bias (Smilog) : Filename:  Id_vs_Vgs_log.ps
%       B. Id vs. Vgs At 2nd and Last Drain bias (Linear) : Filename:  Id_vs_Vgs_lin.ps
%       C. Id vs. Vds At Different Vgs (Linear)           : Filename:  Id_vs_Vds.ps
%       D. Mobile at top of the barrier vs. Vds @ Different Vgs : Filename:  N_vs_Vds.ps 
%       E. Quantum Capacitance vs. Vgs at Maximum Vds     : Filename:  CQ_vs_Vgs.ps
%       F. Average Velocity vs. Vgs at Maximum Vds        : Filename:  Velocity_vs_Vgs.ps
%
% 3.  Matlab Rawdata: Rawdata.mat
%
% Interface Script Written by : Sayed Hasan (05/24/2004)
%--------------------------------------------------------------------------

clc;
clear all;
close all;


% -----------------
% Input Parameters
% -----------------

fprintf('Carbon NanoTube MOSFET Simulation ...\n');
% Device Specification:  
%==========================================
		fprintf('Device Specifications:\n');
        fprintf('======================\n');
        % Gate Insulator Thickness, t (m)
		t = [];
		while isempty(t)
			fprintf('   Gate Insulator Thickness (m):       ');
			t = input('t = ');
			if isempty(t)
				t = 1.5e-9; % Default value
				fprintf('\b\b 1.5e-9 (Using Default ...)\n');
            end
        end
        
        % Gate Insulator Dielectric Constant, epsr
        epsr = [];
        while isempty(epsr)
            fprintf('   Gate Insulator Dielectric Const.:   ');
            epsr = input('epsr = ');
            if isempty(epsr)
                epsr = 3.9; % Default value
                fprintf('\b\b 3.9 (Using Default ...)\n');
            end
        end
        
        % NT Diameter, d (m)
        d = [];
        while isempty(d)
            fprintf('   NanoTube Diameter (m):              ');
            d = input('d = ');
            if isempty(d)
                d = 1.0e-9; % Default value
                fprintf('\b\b 1.0e-9 (Using Default ...)\n');
            end
        end
        
        % Temperature, T (K)
        T = [];
        while isempty(T)
            fprintf('   Temperature (K):                    ');
            T = input('T = ');
            if isempty(T)
                T = 300; % Default value
                fprintf('\b\b 300 (Using Default ...)\n');
            end
            fprintf('\n');
        end

% Terminal Gate Voltage: 
%==========================================================================
		fprintf('Terminal Voltage:\n');
        fprintf('=================\n');
        
        %% 1) Number of Gate Bias Points, NV_Gate
        NV_Gate = [];
        while isempty(NV_Gate)
            fprintf('   Number of Gate Bias Points:  ');
            NV_Gate = input('NV_Gate = ');
            if isempty(NV_Gate)
                NV_Gate = 21; % Default value
                fprintf('\b\b 21 (Using Default ...)\n');
            end
            fprintf('\n');
        end
        
        %% 2) Gate Voltage Range, VI_Gate,VF_Gate (V)
        VI_Gate = [];
        VF_Gate = [];
        while isempty(VI_Gate) | isempty(VF_Gate)
            fprintf('   Voltage Range (V):\n');
            fprintf('\t\t\t'); 
            VI_Gate = input('(Initial)  VI_Gate = ');
            if isempty(VI_Gate)
                VI_Gate = 0; % Default value
                fprintf('\b\b 0 (Using Default ...)\n');
            end
            fprintf('\t\t\t'); 
            VF_Gate = input('(Final)  VF_Gate = ');
            if isempty(VF_Gate)
                VF_Gate = 1.0; % Default value
                fprintf('\b\b 1.0 (Using Default ...)\n');
            end
            fprintf('\n');
        end

% Terminal Drain Voltage: 
%==========================================================================
		fprintf('Terminal Voltage:\n');
        fprintf('=================\n');
        
        %% 1) Number of Drain Bias Points, NV_Drain
        NV_Drain = [];
        while isempty(NV_Drain)
            fprintf('   Number of Drain Bias Points:  ');
            NV_Drain = input('NV_Drain = ');
            if isempty(NV_Drain)
                NV_Drain = 21; % Default value
                fprintf('\b\b 21 (Using Default ...)\n');
            end
            fprintf('\n');
        end
        
        %% 2) Drain Voltage Range, VI_Drain,VF_Drain (V)
        VI_Drain = [];
        VF_Drain = [];
        while isempty(VI_Drain) | isempty(VF_Drain)
            fprintf('   Voltage Range (V):\n');
            fprintf('\t\t\t'); 
            VI_Drain = input('(Initial)  VI_Drain = ');
            if isempty(VI_Drain)
                VI_Drain = 0.0; % Default value
                fprintf('\b\b 0.0 (Using Default ...)\n');
            end
            fprintf('\t\t\t'); 
            VF_Drain = input('(Final)  VF_Drain = ');
            if isempty(VF_Drain)
                VF_Drain = 1.0; % Default value
                fprintf('\b\b 1.0 (Using Default ...)\n');
            end
            fprintf('\n');
        end
        
% Analytical Model:  
%==========================================
		fprintf('Analytical Model:\n');
        fprintf('=================\n');
        % Source Fermi Level, Ef (eV)
        Ef = [];
        while isempty(Ef)
            fprintf('   Source Fermi Level (eV):    ');
            Ef = input('Ef = ');
            if isempty(Ef)
                Ef = -0.32; % Default value
                fprintf('\b\b -0.32 (Using Default ...)\n');
            end
        end
        
		% Get Control Parameter, alphag    
        alphag = [];
        while isempty(alphag)
            fprintf('   Gate Control Parameter:     ');
            alphag = input('alphag = ');
            if isempty(alphag)
                alphag = 0.88; % Default value
                fprintf('\b\b 0.88 (Using Default ...)\n');
            end
        end
        
        % Drain Control Parameter, alphad
        alphad = [];
        while isempty(alphad)
            fprintf('   Drain Control Parameter:    ');
            alphad = input('alphad = ');
            if isempty(alphad)
                alphad = 0.035; % Default value
                fprintf('\b\b 0.035 (Using Default ...)\n');
            end
            fprintf('\n');
        end
        
        %% Series Resistance, Rs (ohm)
        Rs = [];
        while isempty(Rs)
            fprintf('   Series Resistance:    ');
            Rs = input('Rs = ');
            if isempty(Rs)
                Rs = 0; % Default value
                fprintf('\b\b 0 (Using Default ...)\n');
            end
            fprintf('\n');
        end

        
% Call Main Program
% ================================
I = CNTFETToy( t,d,epsr,T, NV_Gate,VI_Gate,VF_Gate,NV_Drain,VI_Drain,VF_Drain, Ef,alphag,alphad,Rs );