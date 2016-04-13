function [  ] = oneSubjectAnalysis( SC, FC, numClusters )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%close all
%numClusters = 10;
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

% %visualize clusters on FC indexed by clusters on joint spcetrum
% figure, colormap('jet')
% scatter3(UFC(:,1), UFC(:,2), UFC(:,3), 40, ind_GmmJoint, 'filled');
% title('FC embedding space, GMM numClusters, Joint indices')
% %histogram(ind_GmmJoint,numClusters);
% 
end

