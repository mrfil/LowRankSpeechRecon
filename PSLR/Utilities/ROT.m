% PS reconstruction 
% Applied to occations with regional-optimizing requirements
% Regional optimized temporal basis (ROT) from navigators 

function temp_bas = ROT(Sig_nav_dense,CoilCompMat,L)

% Sig_nav_dense: The dense navigator signal
% CoilcompMat: Coil compression matrix, usually comes from cROVir.m
% L:Model Rank
% temp_bas: Temporal basis

% Parameters

Nco = size(Sig_nav_dense,1);         % Coil #
Nc = size(Sig_nav_dense,2);          % Sample #  
Nts = size(Sig_nav_dense,3)*size(Sig_nav_dense,4)*size(Sig_nav_dense,5); % Total timeframes

% Compress navigator signal

Nav = reshape(Sig_nav_dense,[Nco,Nc*Nts]); 
C_Nav = permute(Nav,[2,1]) * CoilCompMat(:,end);
C_Nav = reshape(C_Nav,[Nc,Nts]); 

% Temporal basis from SVD

[~,~,V_Nav] = svd(C_Nav);
temp_bas = V_Nav(:,1:L);

end