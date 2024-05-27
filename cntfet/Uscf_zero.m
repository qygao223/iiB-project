% This function analyically calculates the self-consistent potential at the
% top of the barrier


%%%function Uscf_zero=Uscf_zero(Uscf,N2D,mu1,mu2,kT,UL,U0,N0)
function Uscf_zero=Uscf_zero(Uscf,D0,EG,mu1,mu2,kT,UL,U0,N0)
%Uscf_zero=(UL+U0*(0.5*N1D*(fermi((mu1-Uscf)/kT,1,-1/2)+fermi((mu2-Uscf)/kT,1,-1/2))-N0))-Uscf;
Uscf_zero=(UL+U0*(N_CNT(D0/2,EG,kT,mu1-Uscf)+N_CNT(D0/2,EG,kT,mu2-Uscf)-N0))-Uscf;

% Equation (8a)in [1] can be expressed as f(Uscf)=0. Please note, from eqs.
% (4a),(4b) and (7c).  del_N is a function of Uscf too.  The function
% f(Uscf)=0 is written here as Uscf_zero.