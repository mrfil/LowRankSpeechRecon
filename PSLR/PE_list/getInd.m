% Get the random index list from PE_list folder

function [ky,kz] = getInd(N_lin,N_sli,N_rep,Nn,N,Ipaty,Ipatz)

% N_lin: # of ky per meas
% N_sli: # of slices 
% N_rep: # of meas
% Nn: # of k lines per navigator
% N: # of same speech samples

% Options: 
% Ipaty: Reduction factor in ky
% Ipatz: Reduction factor in kz
% 'Orig': Original random phase encoding
% 'Shift' : Shifted phase encoding (R2&R4)
% 'PD' : PoissonDisk Sampling


% Different with Ipat factor in ky or kz

addpath(genpath('/shared/mrfil-data/jriwei2/Matlab/PSLR/PE_list'));

if Ipaty == 1
    listname = sprintf('bps_randspeech_3D_z%d.txt',N_sli);
    if N_lin ~= 128
        listname = sprintf('bps_randspeech_3D_z%d_%d.txt',N_sli,N_lin);
    end
elseif Ipaty == 2
    listname = sprintf('bps_randspeech_R2_3D_z%d_PD.txt',N_sli);
end

Nts = N*N_lin*N_sli*N_rep/Nn;
RandPE = load(listname); 
RandPE = repmat(RandPE,50,1);
kyz = RandPE(1 : N_lin/Ipaty*N_sli/Ipatz*N_rep);
ky = zeros(1,Nts/N);kz = zeros(1,Nts/N);
for i = 1 : N_rep*N_sli*N_lin/Ipaty/Ipatz
    kz(i) = floor((kyz(i)-1)./N_lin)+1;
    ky(i) = mod(kyz(i)-1,N_lin)+1;    
end
end