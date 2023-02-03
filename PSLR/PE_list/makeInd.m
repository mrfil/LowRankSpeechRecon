% Create ky/kz index list

function k_ind = makeInd(k,Nn,N)

% k: Raw sampling list for ky or kz
% Nn: # of k lines in one navigator
% N: # of samples
% k_ind: Input of system matrix @lr_model7,size [Nn,Nts]

k_ind = zeros(Nn,(length(k))/Nn);
for ii = 1 : Nn
    for jj = 1 : (length(k))/Nn
        k_ind(ii,jj) = k(Nn*(jj-1)+ii);
    end
end
k_ind = repmat(k_ind,1,N);

end