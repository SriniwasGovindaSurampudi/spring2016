%**************************************************************************%
%reading data
SC = dlmread('./NKI_Rockland/1013090_DTI_connectivity_matrix_file.txt');
FC = dlmread('./NKI_Rockland/1013090_fcMRI_noGSR_connectivity_matrix_file.txt');
coordsSC = dlmread('./NKI_Rockland/1013090_DTI_region_xyz_centers_file.txt');
coordsFC = dlmread('./NKI_Rockland/1013090_fcMRI_noGSR_region_xyz_centers_file.txt');
%**************************************************************************%
%analysis - single view
[USC, indSC_rw] = spectralClusters(SC, 10, 'randomWalk');
[UFC, indFC_rw] = spectralClusters(FC, 10, 'randomWalk');
figure, scatter3(coordsSC(:,1), coordsSC(:,2), coordsSC(:,3), 25, indSC_rw, 'filled');
title('SC original space, k10')
figure, scatter3(USC(:,2), USC(:,3), USC(:,4), 25, indSC_rw, 'filled');
title('SC embedding space, k10')
figure, scatter3(coordsFC(:,1), coordsFC(:,2), coordsFC(:,3), 25, indFC_rw, 'filled');
title('FC original space, k10')
figure, scatter3(UFC(:,2), UFC(:,3), UFC(:,4), 25, indFC_rw, 'filled');
title('FC embedding space, k10')
%analysis - multi view
[F, ind_Co] = coClusters(SC, FC, 13, 10);
figure, scatter3(F(:,2), F(:,3), F(:,4), 25, ind_Co, 'filled');
title('Joint original space, k10')
figure, scatter3(coordsFC(:,1), coordsFC(:,2), coordsFC(:,3), 25, ind_Co, 'filled');
title('Joint embedding space, k10')
figure,
histogram(indSC_rw, 10)
histogram(indFC_rw, 10)
histogram(ind_Co, 10)
figure, scatter3(USC(:,2), USC(:,3), USC(:,4), 25, indSC_rw, 'filled');
figure, 
histogram(indSC_rw,10)
hold on
histogram(indFC_rw, 10)
histogram(ind_Co, 10)
figure,
histogram(indSC_rw,10)
figure, 
histogram(indFC_rw, 10)
figure,
histogram(ind_Co, 10)
figure, scatter3(F(:,2),F(:,3),F(:,4), 25, 'filled');

figure, scatter3(USC(:,2), USC(:,3), USC(:,4), 25, 'filled');
X = [USC(:,2),USC(:,3), USC(:,4)];
options = statset('Display','iter');
GMModel_SC = fitgmdist(X,2,'Options',options);
%h = ezcontour(@(x,y,z)pdf(GMModel_SC,[x y z]),[-0.2 0.2],[-0.2, 0.2], [-0.2 0.2]);
help pdf
GMModel_SC.mu
GMModel_SC.Sigma
GMModel_SC = fitgmdist(X,10,'Options',options);
GMModel_SC.mu
ind_GmmSC = GMModel_SC.cluster(X);
figure, scatter3(X(:,1),X(:,2),X(:,3),25,ind_GmmSC,'filled');