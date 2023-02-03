 function vo = mtimes(a, vi)
%	MRI "forward projection" y=A*x and backprojection x = (A')*y

% if a.is.empty
%     error empty
% end

AA = a.A;
sen = a.sen;
ncoils = size(sen,2);
nn = size(AA);
nx = nn(1);
ny = nn(2);
L = AA.L;


if ~a.is.transpose
    vo = zeros(ncoils*nx,1);
    for ii = 1:ncoils
        vo((ii-1)*nx+1:ii*nx) = AA*(repmat(sen(:,ii),[L,1]).*vi(:));
    end
else
    vo = zeros(ny,1);
    for ii = 1:ncoils
        vo = vo + (repmat(conj(sen(:,ii)),[L,1])).*(AA'*vi((ii-1)*nx+1:ii*nx));
    end
end
