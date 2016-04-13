cd /Users/govinda/Desktop/spring2016/
%% Clustering of structural connectivity matrix 
close all
clc
% % initializations
% addpath(genpath('./BCT/')); % added BCT toolbox
% % W = dlmread('./data/UCLA_Autism_TD132_CCN_DTI_connectmat.txt');
% % FC = dlmread('./data/UCLA_Autism_TD132_CCN_rsfMRI_connectmat.txt');
% % FC(isinf(FC)) = 0;

SC = dlmread('./NKI_Rockland/1013090_DTI_connectivity_matrix_file.txt');
FC = dlmread('./NKI_Rockland/1013090_fcMRI_noGSR_connectivity_matrix_file.txt');
coordsSC = dlmread('./NKI_Rockland/1013090_DTI_region_xyz_centers_file.txt');
coordsFC = dlmread('./NKI_Rockland/1013090_fcMRI_noGSR_region_xyz_centers_file.txt');
% % Louvian method
% statisticsLouvianCell = communityLouvainClusters(W, FC);

% % Spectral methods
% statisticsSpectralRWCell = spectralClustersRW(W, FC);
% statisticsSpectralSymmCell = spectralClustersSymm(W, FC);
% 
% % % Newman method
% % statisticsNewmanCell = newmanClusters(W, FC);
% %% Methods comparison
% % mL = zeros(1,size(statisticsLouvianCell,2));
% % stdmL = zeros(1,size(statisticsLouvianCell,2));
% % for i = 1 : size(statisticsLouvianCell,2)
% % mL(i) = statisticsLouvianCell{3,i};
% % stdmL(i) = statisticsLouvianCell{4,i};
% % end
% % [mL,ind] = sort(mL); stdmL = stdmL(ind);
% % figure, plot(mL), title('Louvian Method'); xlabel('cluster index'); ylabel('FC meann values');
% % hold on
% % errorbar(1 : size(statisticsLouvianCell,2), mL, stdmL)
% 
% mS = zeros(1,size(statisticsSpectralRWCell,2));
% stdmS = zeros(1,size(statisticsSpectralRWCell,2));
% for i = 1 : size(statisticsSpectralRWCell,2)
% mS(i) = statisticsSpectralRWCell{3,i};
% stdmS(i) = statisticsSpectralRWCell{4,i};
% end
% [mS,ind] = sort(mS); stdmS = stdmS(ind);
% figure, plot(sort(mS)), title('Spectral Method RW'); xlabel('cluster index'); ylabel('FC meann values');
% hold on
% errorbar(1 : size(statisticsSpectralRWCell,2), mS, stdmS)
% 
% % mN = zeros(1,size(statisticsNewmanCell,2));
% % stdmN = zeros(1,size(statisticsNewmanCell,2));
% % for i = 1 : size(statisticsNewmanCell,2)
% %     mN(i) = statisticsNewmanCell{3,i};
% %     stdmN(i) = statisticsNewmanCell{4,i};
% % end
% % [mN,ind] = sort(mN); stdmN = stdmN(ind);
% % figure, plot(sort(mN)), title('Newman Method'); xlabel('cluster index'); ylabel('FC meann values');
% % hold on
% % errorbar(1 : size(statisticsNewmanCell,2), mN, stdmN)
% 
% mS2 = zeros(1,size(statisticsSpectralSymmCell,2));
% stdmS2 = zeros(1,size(statisticsSpectralSymmCell,2));
% for i = 1 : size(statisticsSpectralSymmCell,2)
% mS2(i) = statisticsSpectralSymmCell{3,i};
% stdmS2(i) = statisticsSpectralSymmCell{4,i};
% end
% [mS2,ind2] = sort(mS2); stdmS2 = stdmS2(ind2);
% figure, plot(sort(mS2)), title('Spectral Method Symm'); xlabel('cluster index'); ylabel('FC meann values');
% hold on
% errorbar(1 : size(statisticsSpectralSymmCell,2), mS2, stdmS2)