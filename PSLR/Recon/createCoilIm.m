% Create coil images from Signal data through IFFT

function Im_coil = createCoilIm(Sig_mat)

% Im_coil:Coil images
% Sig_mat: Input Signal data

N_col = size(Sig_mat,1);
N_lin = size(Sig_mat,2);
N_sli = size(Sig_mat,3);
N_coil = size(Sig_mat,5);

Im_inv = zeros(N_col,N_lin,N_sli,N_coil);
Im_coil  = zeros(N_col,N_lin,N_sli,N_coil);

for i = 1 : N_coil
    Im_inv(:,:,:,i) = ifftshift(fftn(fftshift(Sig_mat(:,:,:,i)))); 
    for j = 1 : N_lin
        for k = 1 : N_col
            for g = 1 : N_sli
                Im_coil(j,k,g,i) = Im_inv(N_lin-k+1,N_col-j+1,g,i); % Apply the orientation
            end
        end
    end
end

end