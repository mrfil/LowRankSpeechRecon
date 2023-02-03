% General coil compression
% Create Coil computing matrix based on energy (regional)

function [CompSen,CoilCompMat] = cROE(Sen,x1,y1,x2,y2,CoilRank)

% Sen: SENSE map of coils
% x1,y1,x2,y2: Coordinates of two diagnal points of ROI
% CoilRank: # of coil to retain

N_col = size(Sen,1);
N_lin = size(Sen,2);
N_sli = size(Sen,3);
N_coil = size(Sen,4);

% Sense map of ROI

Sen_roi = zeros(N_col,N_lin,N_sli,N_coil);
Sen_roi(x1+1:x2,y1+1:y2,:,:) = Sen(x1+1:x2,y1+1:y2,:,:); 
Sen_roi = reshape(Sen_roi,N_col*N_lin*N_sli,N_coil);

% SVD 

[~,~,CoilCompMat] = svd(Sen_roi,0);                            

% CompSen

Sen = reshape(Sen,N_col*N_lin*N_sli,N_coil); 
CompSen = Sen * CoilCompMat(:,1:CoilRank);    
CompSen = reshape(CompSen,N_col*N_lin*N_sli,CoilRank);

end