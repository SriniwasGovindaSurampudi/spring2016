function [ statisticsSpectralCell ] = spectralClustersSymm( W,FC )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

D = diag(sum(W));
L = D - W;
Lsym = D^(-1/2) * L * D^(-1/2);
[Vec,Val] = eig(Lsym);

[~,ind] = sort(diag(Val));
Val = Val(:,ind);
Vec = Vec(:,ind);

plot(sum(Val))
grid on
numClusters = input('provide the number of clusters'); % using eigengap to determine number of clusters

absVec = sqrt(sum(Vec.^2,2));
Vec = bsxfun(@rdivide, Vec, absVec);
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

end

