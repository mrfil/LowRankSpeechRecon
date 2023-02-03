% Create mask for ROI and nROI in ranks
% Locally high-rank 

function [mask_n,mask_s] = cRankMask(Initialsize,x1,y1,x2,y2,Ln,L)

% mask_n: Mask with nROI
% mask_s: Mask with ROI
% Initialsize: [N_col,N_lin,N_sli]
% % x1,y1,x2,y2: Coordinates of two diagnal points of ROI
% Ln:rank of nROI
% L: rank of ROI

N_col = Initialsize(1);
N_lin = Initialsize(2);
N_sli = Initialsize(3);

% nROI mask

mask = ones(N_col,N_lin,N_sli,L);    
mask(x1+1:x2,y1+1:y2,:,Ln+1:L) = 0;            
mask_n = mask;
mask_n(:,:,:,Ln+1:L) = 0; 
mask_n = mask_n > 0;           

% ROI mask

mask_s = ~mask;              
mask_s = mask_s > 0;

end