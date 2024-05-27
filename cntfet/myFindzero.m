% This function find zeros

function Uscf=myFindzero(D0,EG,mu1,mu2,kT,UL,U0,N0,Uscf)

options = optimset('tolx',1e-12)
fprintf(stderr, 'UL=%f\n', UL)
Uscf = fzero(@Uscf_zero1, Uscf, options);

    function Uscf = Uscf_zero1(Uscf)
fprintf(stderr, 'UL=%f', UL)
    Uscf = (UL+U0*(N_CNT(D0/2,EG,kT,mu1-Uscf)+N_CNT(D0/2,EG,kT,mu2-Uscf)-N0))-Uscf;
    end
end 
