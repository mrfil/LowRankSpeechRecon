% Calculate the time average of signal data
% Assume the dimensions for signal matrix:(x,y,z,t,...)

function Sig_mat_avg = tAvg(Sig_mat_derand)

Sig_mat_avg = sum(Sig_mat_derand,4)./size(Sig_mat_derand,4);

end