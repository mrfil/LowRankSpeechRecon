% General navigator selecting temporal basis
% Most energy preserving coil

function temp_bas = MET(Sig_nav_dense,L)

% Sig_nav_dense: The dense navigator signal
% L:Model Rank
% temp_bas: Temporal basis

% Parameters

Nco = size(Sig_nav_dense,1);
Nc = size(Sig_nav_dense,2);
Nts = size(Sig_nav_dense,3)*size(Sig_nav_dense,4)*size(Sig_nav_dense,5);

% SVD on coils

Nav = reshape(Sig_nav_dense,[Nco,Nc*Nts]); 
[Un,~,~] = svd(Nav.',0);
C_Nav = Un(:,1);
C_Nav = reshape(C_Nav,[Nc,Nts]); 

% temporal basis

[~,~,V_Nav] = svd(C_Nav);
temp_bas = V_Nav(:,1:L);

end

