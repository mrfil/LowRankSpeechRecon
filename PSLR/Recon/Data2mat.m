% Extract data to signal matrix
% Data comes from mapVBVD.m in Siemens folder (twix.obj)
% Save multiple data to one 1*N cell

function Sig_mat = Data2mat(Data)

N = size(Data,2);
  
% Multiple data, read from cell

Ncoil = Data{1}.NCha;
Nrep = Data{1}.NRep;   
for i = 1 : Ncoil
    for j = 1 : Nrep
        for k = 1 : N
            Sig_mat(:,:,:,(k-1)*Nrep + j,i) = squeeze(double(Data{k}(:,i,:,:,1,1,1,1,j))); 
        end
    end
end
end

