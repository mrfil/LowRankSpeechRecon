% Create virtual coil matrix through ROVir method base on the ROI
% https://onlinelibrary.wiley.com/doi/full/10.1002/mrm.28706

function [CompSen,CoilCompMat] = cROVir(Sen,x1,y1,x2,y2,CoilRank)

% Sen: SENSE map of coils
% x1,y1,x2,y2: Coordinates of two diagnal points of ROI
% CoilRank: # of coil to retain

N_col = size(Sen,1);
N_lin = size(Sen,2);
N_sli = size(Sen,3);
N_coil = size(Sen,4);

% Sen ROI (A'A)

Sen_roi = zeros(N_col,N_lin,N_sli,N_coil);
Sen_roi(x1+1:x2,y1+1:y2,:,:) = Sen(x1+1:x2,y1+1:y2,:,:); 
Sen_roi = reshape(Sen_roi,N_col*N_lin*N_sli,N_coil);
Sen_A = Sen_roi'*Sen_roi; 

% Sen nROI (B'B)

Sen_nroi = Sen;
Sen_nroi(x1+1:x2,y1+1:y2,:,:) = zeros(x2-x1,y2-y1,N_sli,N_coil); 
Sen_nroi = reshape(Sen_nroi,N_col*N_lin*N_sli,N_coil);
Sen_B = Sen_nroi'*Sen_nroi;

% EVD

[~,~,CoilCompMat] = eig(Sen_A,Sen_B);

% CompSen

Sen = reshape(Sen,N_col*N_lin*N_sli,N_coil); 
CompSen = Sen * CoilCompMat(:,N_coil-CoilRank+1:N_coil);    
CompSen = reshape(CompSen,N_col*N_lin*N_sli,CoilRank);

end