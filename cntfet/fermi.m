% This function evaluates the Fermi-Dirac integral of order fermi-order.
% The Fermi-Dirac integral is in the form defined by Blakemore in
% "Semiconductor Stastics".
% x is the argument of the Fermi-Dirac integral in units of kT.
% fermi-flag=1 for degeneracy and 0 for the non-degenerate approximation.
% fermi_order is 1/2 or 0.

% The empirical expressions of
%   J. S. Blakemore, "Approximations for the Fermi-Dirac integrals,
%   specially the function, F_1/2(eta), used to describe electron density
%   in a semiconductor," Solid-State Electron., Vol. 25, pp. 1067-1076,
%   1982 are used.

function [y]=fermi(x,fermi_flag,fermi_order)

if fermi_order==1/2
    
    if fermi_flag==1
        exp_fac=exp(-0.17*(x+1.0).^2);
        nu=x.^4+50.0+33.6*x.*(1.0-0.68*exp_fac);
        zeta=3.0*sqrt(pi)./(4.0*nu.^0.375);
        y=exp(x)./(1.0+zeta.*exp(x));
    elseif fermi_flag==0
        y=exp(x);
    end
    
elseif fermi_order==0

    if fermi_flag==1
        y=log(1+exp(x));
    elseif fermi_flag==0
        y=exp(x);
    end
    
elseif (fermi_order==-1/2)
    
    if fermi_flag==1
        exp_fac=exp(-0.17*(x+1.0).^2);
        nu=x.^4+50.0+33.6*x.*(1.0-0.68*exp_fac);
        zeta=3.0*sqrt(pi)./(4.0*nu.^0.375);
        nu_prime=4*x.^3+33.6-22.848*exp_fac.*(1-0.34*(x+x.^2));
        zeta_prime=-(9*sqrt(pi)/32)*nu.^(-11/8).*nu_prime;
        y=(exp(-x)-zeta_prime)./(exp(-x)+zeta).^2;
    elseif fermi_flag==0
        y=exp(x);
    end
    
elseif (fermi_order==-3/2) % new definition
    
    if fermi_flag==1
        t=0.001:0.005:50;
        j=-1/2;
        delta=5e-4;
        y=x*0;
        for k=1:length(x)
            temp1=x(k)-delta;
            temp2=x(k)+delta;
            y1=0;
            y2=0;
            for i0=1:length(t)
                y1=y1+t(i0)^j/(1+exp(t(i0)-temp1))*(t(2)-t(1));
                y2=y2+t(i0)^j/(1+exp(t(i0)-temp2))*(t(2)-t(1));
            end
            y(k)=(y2-y1)/2/delta/gamma(j+1);
        end
    elseif fermi_flag==0
        y=exp(x);
    end

end