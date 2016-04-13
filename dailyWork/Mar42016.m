%% Data
%**************************************************************************%
addpath(genpath('/Users/govinda/Desktop/spring2016'))
%reading data
SC = dlmread('./NKI_Rockland/1334913_DTI_connectivity_matrix_file.txt');
FC = dlmread('./NKI_Rockland/1334913_fcMRI_noGSR_connectivity_matrix_file.txt');
coordsSC = dlmread('./NKI_Rockland/1334913_DTI_region_xyz_centers_file.txt');
coordsFC = dlmread('./NKI_Rockland/1334913_fcMRI_noGSR_region_xyz_centers_file.txt');

%**************************************************************************%
%% Embeddings and GMM fitting
close all
numClusters = 10;
%inducing graph on the multiple views
WSC = SC;
WFC = abs(FC);
%this is because correlation +ve or -ve the nodes are strongly correlated,
%near zero values indicate lesser correlation. Therefore, absolute of FC.
%The sign of FC values tell whether an ROI is exitatory or inhibitory.

%SC clusters on GMM and ellipsoids visualization
[USC, indSC_rw, muSC] = spectralClusters(WSC, numClusters, 'symmetric');
options = statset('Display','final');
GMModel_SC = fitgmdist(USC,numClusters,'Options',options,'RegularizationValue',0.005);
ind_GmmSC = GMModel_SC.cluster(USC);
%spectral clusters returns 2 to numClusters+1 columns
figure, colormap('jet')
scatter3(USC(:,1), USC(:,2), USC(:,3), 40, ind_GmmSC, 'filled');
title('SC embedding space, GMM numClusters')
hold on
[ sc ] = drawEllipsoids( GMModel_SC.mu, GMModel_SC.Sigma );
hold off

%FC clusters of GMM and ellipsoids visualization
[UFC, indFC_rw, muFC] = spectralClusters(WFC, numClusters, 'symmetric');
options = statset('Display','final');
GMModel_FC = fitgmdist(UFC,numClusters,'Options',options,'RegularizationValue',0.005);
ind_GmmFC = GMModel_FC.cluster(UFC);
%spectral clusters returns 2 to numClusters+1 columns
figure, colormap('jet')
scatter3(UFC(:,1), UFC(:,2), UFC(:,3), 40, ind_GmmFC, 'filled');
title('FC embedding space, GMM numClusters')
hold on
[ fc ] = drawEllipsoids( GMModel_FC.mu, GMModel_FC.Sigma );
hold off

%Co-clustering
[ F, indices ] = coClusters( WSC, WFC, 13, numClusters );
options = statset('Display','final');
GMModel_Joint = fitgmdist(F(:,2:min(numClusters + 1,size(F,2))),numClusters,'Options',options,'RegularizationValue',0.005);
ind_GmmJoint = GMModel_Joint.cluster(F(:,2:min(numClusters + 1,size(F,2))));

figure, colormap('jet')
scatter3(F(:,2), F(:,3), F(:,4), 40, ind_GmmJoint, 'filled');
title('Joint embedding space, GMM numClusters')
hold on
[ jc ] = drawEllipsoids( GMModel_Joint.mu, GMModel_Joint.Sigma );
hold off

%visualize clusters on FC indexed by clusters on joint spcetrum
figure, colormap('jet')
scatter3(UFC(:,1), UFC(:,2), UFC(:,3), 40, ind_GmmJoint, 'filled');
title('FC embedding space, GMM numClusters, Joint indices')
%histogram(ind_GmmJoint,numClusters);

%% Best Joint embeding
% PDF = zeros(1,50);
% for iters = 1 : 50
%     for i = 2 : 50
%         [ F, indices ] = coClusters( WSC, WFC, i, numClusters );
%         options = statset('Display','');
%         GMModel_Joint = fitgmdist(F(:,2:min(numClusters + 1,size(F,2))),numClusters,'Options',options,'RegularizationValue',0.005);
%         ind_GmmJoint = GMModel_Joint.cluster(F(:,2:min(numClusters + 1,size(F,2))));
%         [count] = histcounts(ind_GmmJoint);
%         COUNT(i-1) = max(count)/min(count)-1;
%     end
%     [minval, minindex]=min(COUNT);
%     PDF(minindex + 1) = PDF(minindex + 1)+1;
% end
