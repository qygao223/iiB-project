% Save Current Data   added by Aman Singal and Akira Matsudaira 07/17/2005

function [Iout]=treatRs(VGSin,VDSin,IDin, RSD)

% This function transforms intrinsic I-V for a MOSFET to extrinsic I-V and
% vice versa
% intrinsic-> without series resistance; extrinsic-> with series resistance
%
% INPUTS:
% VGSin : A column vector containing gate biases
% VDSin : A column vector containing drain biases
% IDin  : A matrix of size length(VGSin) x length(VDSin)
% RSD   : Total series resistance, of which half is assigned to source and 
%         rest to drain
% simflag : A string with two possible values-
%               'ext2int'-> The inputs are terminal quantities where series
%               resistances are included and we seek the intrinsic
%               charactristics as Iout
%               Alternatively,
%               'int2ext'--> The inputs are intrinsic quantities and we
%               seek the extrinsic charastristics (with series resistance)
%               as Iout
%
% OUTPUT:
% Iout: A matrix of size length(VGSin) x length(VDSin) with intrinsic or
% extrinsic drain current (depending on simflag). Like IDin, VG changes
% along rows and VD changes along columns.
%
sizeID=size(IDin);   % NV_Gate x NV_Drain
sizeVGS=size(VGSin); % NV_Gate x 1
sizeVDS=size(VDSin); % NV_Drain x 1
%
if sizeVGS(1)~=sizeID(1)|sizeVDS(1)~=sizeID(2)
    error('IDin does not have correct size')
end
if sizeVGS(2)~=1|sizeVDS(2)~=1
    error('Both VGSin and VDSin must be column vectors')
end

VGStmp=VGSin*ones(1,sizeID(2));  % NV_Gate x NV_Drain matrix
VDStmp=ones(sizeID(1),1)*VDSin'; % NV_Gate x NV_Drain matrix
RS=0.5*RSD;
RD=0.5*RSD;

        VGSmat=VGStmp+IDin*RS;
        VDSmat=VDStmp+IDin*(RS+RD);
 
        IDin;
        Iout = griddata(VGSmat,VDSmat,IDin,VGStmp,VDStmp,'v4');
        Iout = Iout';




