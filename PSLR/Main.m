% Speech Recon with IPat factor 2 at ky 
% Regional high-rank reconstruction
% Optional ROVir

%% Initialize

clc
clear

filedir = pwd;
cd '/shared/mrfil-data/jriwei2/Matlab';
addpath(genpath('PSLR/'),'mrfilmat/Siemens/','RecoIL-master/');
run 'initializePathsRecoIL.m';

%% Data directory

cd(filedir);
fname = dir('*.dat');

%% Create SENSE map through fully-sampled data

% Extract sense map data

Data_sen = mapVBVD(fname(1).name); 
Data_sen = Data_sen{2}.image; 

Sig_sen = Data2mat(Data_sen);
N_col = Data_sen.NCol;                     % # of columns
N_lin = Data_sen.NLin;                     % # of lines
N_sli = Data_sen.NPar;                     % # of slices
N_coil = Data_sen.NCha;                    % # of coils
N_rep_sen = Data_sen.NRep;                 % # of sense map measurements
Nn = 4 ;                                   % # of cartesian lines per navigator
Nts_sen = N_lin * N_sli * N_rep_sen / Nn;  % # of total navigators

% Reorganize sensemap data

[ky_sen,kz_sen] = getInd(N_lin,N_sli,N_rep_sen,Nn,1,1,1); % RandomlistIndex
Sig_im_derand = orgSig(Sig_sen,ky_sen,kz_sen); % Reorganize

% SENSE map

Sig_im_derand_avg = tAvg(Sig_im_derand);   % Average signal
Im_coil = createCoilIm(Sig_im_derand_avg); % Coil images
Sen = cSenMap(Im_coil,0);                  % Create SENSE Map

% Select ROI
% Manually select 2 diagnal points of ROI and export as cursor_1 & cursor_2

figure;im(Im_coil(:,:,ceil(end/2),16));  

save Sen Sen
save cursor_1 cursor_1
save cursor_2 cursor_2

%% Extract data with Ipat factor

Data = {};
Data_image = {};
Data_nav = {};
N = length(fname)-1;                 % # of samples, usually 6

for i = 1 : N
    Data = mapVBVD(fname(i+1).name); % Assure correct data list at file directory
    Data_image{i} = Data{2}.image; 
    Data_nav{i} = Data{2}.RTfeedback; 
end

Ipat = 2;                                % Reduction factor at ky
N_rep = Data_image{1}.NRep;              % # of measurements
Ns = N_lin / Ipat / Nn;                  % # of navigators per measure
Nts = N * N_lin /Ipat * N_sli * N_rep / Nn;  % # of timepoints
L = 50;                                  % Local model order

Sig_im_rand = Data2mat(Data_image);

% Apply random phase encoders 

[ky,kz] = getInd(N_lin,N_sli,N_rep,Nn,N,Ipat,1);

%% Coil compression

load cursor_1
load cursor_2
load Sen

x1 = cursor_1.Position(1);y1 = cursor_1.Position(2);
x2 = cursor_2.Position(1);y2 = cursor_2.Position(2);

CoilRank = 10; 
[C_Sen_ROVir,CoilCompMat_ROVir] = cROVir(Sen,x1,y1,x2,y2,CoilRank); % ROVir
[C_Sen_ROE,CoilCompMat_ROE] = cROE(Sen,x1,y1,x2,y2,CoilRank);       % ROE

% Signal compression

Sig_im = compSig(Sig_im_rand,CoilCompMat_ROE(:,1:CoilRank));

%% Construct Navigator signal

% Parameter

Nc = Data_nav{1}.NCol;  % # of time points every frame   
Nt = Data_nav{1}.NRep;  % # of measurements each sample
Nco = Data_nav{1}.NCha; % # of coils
Nz = Data_nav{1}.NPar;  % # of slices

% Compress sparse signal of navigators 

Sig_nav_sparse = Data2mat(Data_nav);
Sig_nav = compSparse(Sig_nav_sparse,Nn);

%% Construct time basis function

% ROT or MET

temp_bas = ROT(Sig_nav,CoilCompMat_ROVir,L);
%temp_bas = MET(Sig_nav,L);

%% Construct Spatial Basis

% Index

ky_ind = makeInd(ky,Nn,N);
kz_ind = makeInd(kz,Nn,N);

% General mask

Lg = 5;                        
[mask_n,mask_s] = cRankMask(N_col,N_lin,N_sli,x1,y1,x2,y2,Lg,L);

% Low rank object

A = lr_model(temp_bas,ky_ind,kz_ind,N_lin,N_sli); % Low rank model implementation
AS = sense4D(A,C_Sen_ROE);                           % Apply coils
Am = Masksep(AS,mask_n,mask_s);                    % Mask seperating

% Recon 

niter = 200;                                % Iterations
beta = 1000;                                % Regularization parameter
delta = 5e-7;                               % Huber
spat_map = zeros(N_col,N_lin,N_sli,L);      % Define Initials
R = Robj4D(squeeze(ones(N_lin,N_lin,N_sli,L) > 0),'beta',beta,'potential',...
    'huber','delta',delta); % Penalization
[xs,info] = Reg_pwls_pcg(spat_map(:),Am,1,Sig_im(:),R,'niter',niter,...
    'isave','all','stop_grad_tol',1e-4,'chat',1); % Regularized CG
UU = reshape(xs(:,end),[N_lin*N_lin*N_sli L]);    % Reshape to the standard format

%% PS 

save UU UU;
save temp_bas temp_bas;

movie = UU * temp_bas'; % Multiplation of temporal and spatial function
movie = reshape(movie,N_lin,N_col,N_sli,Nts);

%% Movie test

for mm = 1 : Nts    
    im(squeeze(movie(:,:,:,mm)));
    title(sprintf('Frame %05d',mm));
    axis off
    colormap gray
    getframe;
end
