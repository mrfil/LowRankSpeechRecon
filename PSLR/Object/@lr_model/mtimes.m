 function vo = mtimes(a, vi)
% This does the multiplication by a vector for both forward and transpose
% operations

if a.is.empty
	error empty
end

  time_basis = a.time_basis;
  ky_ind = a.ky_ind;
  kz_ind = a.kz_ind;
  N_tpt = a.N_tpt;   
  N = a.N;
  Nz = a.Nz;
  L = a.L;
  Nn = size(ky_ind,1);


       
   if ~a.is.transpose
       % obj_pred = zeros(N*N*Nz, N_tpt);
       spat_map = reshape(vi,[N N Nz L]);
       kspace_map = ifftshift(fft(fft(fft(fftshift(spat_map),[],3),[],2),[],1));
       
           for ii = 1:N_tpt
               for kk = 1:Nn
                   tmp_data(:,kk) =  squeeze(kspace_map(ky_ind(kk,ii),:,kz_ind(kk,ii),:))*(time_basis(ii,:)');
               end
               data_pred(:,ii) = tmp_data(:);
           end
       vo = data_pred(:);   
    
   else
       dat_in = reshape(vi,[N Nn N_tpt]);  
       spat_map = zeros([N*N*Nz L]);
       
       for jj = 1:L
           tmp_data = zeros(N, N, Nz);
            for ii = 1:N_tpt
               for kk = 1:Nn
                   tmp_data(ky_ind(kk,ii),:,kz_ind(kk,ii)) = tmp_data(ky_ind(kk,ii),:,kz_ind(kk,ii)) + ((time_basis(ii,jj))*(dat_in(:,kk,ii))).';
               end
            end
 	        tmp_map = N*N*Nz*ifftshift(ifft(ifft(ifft(fftshift(tmp_data),[],3),[],2),[],1));
            spat_map(:,jj) = tmp_map(:);    
       end
       vo = spat_map(:);     
   end
