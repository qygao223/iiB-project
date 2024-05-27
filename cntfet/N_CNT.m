% This function analyically calculates the charge density for CNTFETs


function [N]=N_CNT(D0,EG,kT,x)
%x=mu1(mu2)-Uscf

Elim=max(10*kT,8*kT+x)+EG/2;
zlim=sqrt(Elim^2-(EG/2)^2);
z=linspace(0,zlim,1e3);

fz=1./(1+exp(((z.^2+(EG/2)^2).^0.5-EG/2-x)/kT));
N=D0*sum(fz)*(z(2)-z(1));