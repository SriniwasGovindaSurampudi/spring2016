function [ statisticsSpectralCell ] = spectralClustersRW( W,FC )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

D = diag(sum(W));
L = D - W;
Lrw = D\L;
[Vec,Val] = eig(Lrw);

[~,ind] = sort(diag(Val));
Val = Val(:,ind);
Vec = Vec(:,ind);

plot(sum(Val))
grid on
numClusters = input('provide the number of clusters'); % using eigengap to determine number of clusters

[indices] = kmeans(Vec(:,2:numClusters+1),numClusters);

ClusterNodes = cell(1,numClusters);
statisticsSpectralCell = cell(4,numClusters);
allNodes = 1 : 264;

for i = 1 : numClusters % collecting statistics
    nodes = allNodes(indices == i);
    ClusterNodes{1,i} = nodes;
    mat = FC(nodes,nodes);
    statisticsSpectralCell{1,i} = mean(mat);
    statisticsSpectralCell{2,i} = std(mat);
    statisticsSpectralCell{3,i} = mean2(mat);
    statisticsSpectralCell{4,i} = std2(mat);
end
% ROIcoordsSC = dlmread('./data/UCLA_Autism_TD132_CCN_DTI_region_xyz_centers.txt');
% Nclstrs = figure('name', 'newman clusters');
% figure(Nclstrs);
% colormap(jet);
% scatter3(ROIcoordsSC(:,1),ROIcoordsSC(:,2),ROIcoordsSC(:,3),30,M,'filled');
end

