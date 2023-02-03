% Compress Signal matrix with Coil compression matrix

function Sig_im = compSig(Sig_mat,CoilCompMat)

% Sig_mat: Signal matrix
% CoilCompMat: Coil Compression Matrix

N_col = size(Sig_mat,1);
N_lin = size(Sig_mat,2);
N_sli = size(Sig_mat,3);
N_rep = size(Sig_mat,4);
N_coil = size(Sig_mat,5);

Sig_im = zeros(N_lin*N_col*N_sli*N_rep,N_coil);

for i = 1 : N_coil
    Sig_im(:,i) = reshape(Sig_mat(:,:,:,:,i),N_lin*N_col*N_sli*N_rep,1);
end
Sig_im = Sig_im * CoilCompMat; 

end