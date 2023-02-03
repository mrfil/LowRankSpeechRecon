% Compress sparse navigator data

function Sig_nav_dense = compSparse(Sig_nav_sparse,Nn)

% Sig_nav_sparse: sparse navigator data 
% Nn :# of k lines per navigator

Nco = size(Sig_nav_sparse,5);
Ns = ceil(size(Sig_nav_sparse,2)/Nn);

for mm = 1 : Nco
    for kk = 1 : Ns
        Sig_nav_dense(mm,:,kk,:,:) = Sig_nav_sparse(:,Nn*(kk-1)+1,:,:,mm); % Extract usable navigators
    end
end

end