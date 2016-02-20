cd /Users/govinda/Desktop/spring2016/
%% Clustering of structural connectivity matrix 
close all
clc
% initializations
addpath(genpath('/Users/govinda/Desktop/IIIT_H/II_Semester/Research/ToolBoxes/BCT/')); % added BCT toolbox
W = dlmread('./data/UCLA_Autism_TD132_CCN_DTI_connectmat.txt');
FC = dlmread('./data/UCLA_Autism_TD132_CCN_rsfMRI_connectmat.txt');
FC(isinf(FC)) = 0;

% Louvian method
statisticsLouvianCell = communityLouvainClusters(W, FC);

% Spectral methods
statisticsSpectralRWCell = spectralClustersRW(W, FC);
statisticsSpectralSymmCell = spectralClustersSymm(W, FC);

% Newman method
statisticsNewmanCell = newmanClusters(W, FC);
%% Methods comparison
mL = zeros(1,size(statisticsLouvianCell,2));
stdmL = zeros(1,size(statisticsLouvianCell,2));
for i = 1 : size(statisticsLouvianCell,2)
mL(i) = statisticsLouvianCell{3,i};
stdmL(i) = statisticsLouvianCell{4,i};
end
[mL,ind] = sort(mL); stdmL = stdmL(ind);
figure, plot(mL), title('Louvian Method'); xlabel('cluster index'); ylabel('FC meann values');
hold on
errorbar(1 : size(statisticsLouvianCell,2), mL, stdmL)

mS = zeros(1,size(statisticsSpectralRWCell,2));
stdmS = zeros(1,size(statisticsSpectralRWCell,2));
for i = 1 : size(statisticsSpectralRWCell,2)
mS(i) = statisticsSpectralRWCell{3,i};
stdmS(i) = statisticsSpectralRWCell{4,i};
end
[mS,ind] = sort(mS); stdmS = stdmS(ind);
figure, plot(sort(mS)), title('Spectral Method RW'); xlabel('cluster index'); ylabel('FC meann values');
hold on
errorbar(1 : size(statisticsSpectralRWCell,2), mS, stdmS)

mN = zeros(1,size(statisticsNewmanCell,2));
stdmN = zeros(1,size(statisticsNewmanCell,2));
for i = 1 : size(statisticsNewmanCell,2)
    mN(i) = statisticsNewmanCell{3,i};
    stdmN(i) = statisticsNewmanCell{4,i};
end
[mN,ind] = sort(mN); stdmN = stdmN(ind);
figure, plot(sort(mN)), title('Newman Method'); xlabel('cluster index'); ylabel('FC meann values');
hold on
errorbar(1 : size(statisticsNewmanCell,2), mN, stdmN)

mS2 = zeros(1,size(statisticsSpectralSymmCell,2));
stdmS2 = zeros(1,size(statisticsSpectralSymmCell,2));
for i = 1 : size(statisticsSpectralSymmCell,2)
mS2(i) = statisticsSpectralSymmCell{3,i};
stdmS2(i) = statisticsSpectralSymmCell{4,i};
end
[mS2,ind2] = sort(mS2); stdmS2 = stdmS2(ind2);
figure, plot(sort(mS2)), title('Spectral Method Symm'); xlabel('cluster index'); ylabel('FC meann values');
hold on
errorbar(1 : size(statisticsSpectralSymmCell,2), mS2, stdmS2)