function [ sen, mask ] = cSenMap(coilImages,Reg)
%% Set up Parameters
sizeDims = size(coilImages);
N = sizeDims(1);
NSlices = sizeDims(3);
NCoils = sizeDims(4);

%% Sum of Square
sos_img = sqrt(sum(abs(coilImages).^2,4));
scale_factor = max(abs(sos_img(:)));
sos_img = sos_img/scale_factor;
coil_imgs = coilImages/scale_factor;

%% Mask
mask = ones(size(sos_img))>0; 
%mask = repmat(mask,[1 1 NSlices]);
mask = (abs(sos_img) > (0.05*max(abs(sos_img(:)))));

%% Sense map
sen = zeros(N,N,NSlices,NCoils);
data_weight = zeros(size(sen(:,:,:,1)));
data_weight(:,:,:,1) = abs(sos_img);
beta = 0.1;
R = Robj4D(logical(ones(size(sen(:,:,:,1)))),'beta',beta,'potential','quad');
A = sensemult(ones(size(sen(:,:,:,1))));
%A = sensemult(sos_img.*mask);
W = Gdiag(data_weight(:));
%W=1;
init_img = zeros(size(sen(:,:,:,1)));
init_data = zeros(size(sen(:,:,:,1)));


if Reg
for coilIndex = 1:NCoils
    init_img = (coil_imgs(:,:,:,coilIndex)./sos_img.*mask);%^+0.3*double(~mask);
    init_data = (coil_imgs(:,:,:,coilIndex)./sos_img.*mask);%+0.3*double(~mask);
    init_img(isnan(init_img)) = 0;
    init_data(isnan(init_data)) = 0;
    niter = 1000;
    tmp = solve_pwls_pcg(init_img(:), A,W ,init_data(:), R, 'niter',niter);
    tmp = reshape(tmp,N,N,NSlices);
    sen(:,:,:,coilIndex) = tmp(:,:,:);
end
end

if ~Reg
    for coilIndex = 1:NCoils
    sen(:,:,:,coilIndex)=(coil_imgs(:,:,:,coilIndex)./sos_img);
    end
end
end


