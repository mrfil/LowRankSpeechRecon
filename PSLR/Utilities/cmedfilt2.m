% Performing complex median filtering through magnitude map
% Replacing odd values with neighbouring values with median magnitude

function tmp = cmedfilt2(ima,m,n)

Nx = size(ima,1);
Ny = size(ima,2);
tmp = ima;

for ii = 1 : m : Nx-m+1
    for jj = 1 : n : Ny-n+1
        [~,ind] = sort(col(abs(ima(ii:ii+m-1,jj:jj+n-1))));
        indx = mod(ind-1,n)+1;
        indy = floor((ind-1)./m)+1;
        for mm = [1,m*n]
            tmp(ii+indx(mm)-1,jj+indy(mm)-1) = ima(ii+indx(floor(m*n/2))-1,jj+indy(floor(m*n/2))-1);
        end
    end
end
end
            
           
            
    
    
