% Reorganize signal matrix with the random Indexlist

function Sig_mat_derand = orgSig(Sig_mat,ky,kz)

% Sig_mat: Raw signal matrix with size (kx,ky,kz,t,coil,...)
% ky: ky index list (cartesian)
% kz: kz index list (1-slice #)

% Parameter

N_col = size(Sig_mat,1);
N_lin = size(Sig_mat,2);
N_sli = size(Sig_mat,3);
N_rep = size(Sig_mat,4);
N_coil = size(Sig_mat,5);

% Apply the Indexed line to right place

Sig_mat_derand = zeros(N_col,N_lin,N_sli,N_rep,N_coil);

for m = 1 : N_coil
    for n = 1 : N_rep
        for i = 1 : N_lin
           for j =  1 : N_sli
                Sig_mat_derand(:,ky(i+(j-1)*N_lin+(n-1)*N_lin*N_sli),...
                    kz(i+(j-1)*N_lin+(n-1)*N_lin*N_sli),n,m) = Sig_mat(:,i,j,n,m);
           end
        end
    end
end

end