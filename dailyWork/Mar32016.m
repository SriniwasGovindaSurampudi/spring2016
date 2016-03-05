%%
%**************************************************************************%
addpath(genpath('/Users/govinda/Desktop/spring2016'))
%reading data
SC = dlmread('./NKI_Rockland/1013090_DTI_connectivity_matrix_file.txt');
FC = dlmread('./NKI_Rockland/1013090_fcMRI_noGSR_connectivity_matrix_file.txt');
coordsSC = dlmread('./NKI_Rockland/1013090_DTI_region_xyz_centers_file.txt');
coordsFC = dlmread('./NKI_Rockland/1013090_fcMRI_noGSR_region_xyz_centers_file.txt');

%**************************************************************************%
%%
close all
%inducing graph on the multiple views
sigma = 0.1;
WSC = SC;
WFC = abs(FC);
% muFC = mean2(WFC);
% WFC(WFC == 0) = inf;
% WFC = (1/(sqrt(2*pi)*sigma))*exp(-(bsxfun(@minus, WFC, muFC)).^2/(2*sigma^2));
%this is because correlation +ve or -ve the nodes are strongly correlated,
%near zero values indicate lesser correlation. Therefore, absolute of FC.
%The sign of FC values tell whether an ROI is exitatory or inhibitory.

%clustering - single view
[USC, indSC_rw, muSC] = spectralClusters(WSC, 10, 'randomWalk');
[UFC, indFC_rw, muFC] = spectralClusters(WFC, 10, 'randomWalk');
%kmeans plots
figure, scatter3(USC(:,1), USC(:,2), USC(:,3), 25, indSC_rw, 'filled');
title('SC embedding space, k10')
figure, scatter3(UFC(:,1), UFC(:,2), UFC(:,3), 25, indFC_rw, 'filled');
title('FC embedding space, k10')
%GMM plots
options = statset('Display','iter');
GMModel_SC = fitgmdist(USC,10,'Options',options,'RegularizationValue',0.005);
ind_GmmSC = GMModel_SC.cluster(USC);
figure, scatter3(USC(:,1), USC(:,2), USC(:,3), 25, ind_GmmSC, 'filled');
title('SC embedding space, GMM10')
GMModel_FC = fitgmdist(UFC,10,'Options',options,'RegularizationValue',0.005);
ind_GmmFC = GMModel_FC.cluster(UFC);
figure, scatter3(UFC(:,1), UFC(:,2), UFC(:,3), 25, ind_GmmSC, 'filled');
title('FC embedding space, GMM10')