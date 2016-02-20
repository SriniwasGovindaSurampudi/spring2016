function [ statisticsNewmanCell ] = newmanClusters(W, FC)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

FC = (FC - min(FC(:)))/(max(FC(:)) - min(FC(:)));

[M, Q] = modularity_und(W,1); % clustering function
allNodes = 1 : 264;

statisticsNewmanCell = cell(4,max(M)); % 1. mean of cols, 2. std of cols, 3. overall mean, 4. overall std

for i = 1 : max(M) % collecting statistics
    clusters = M == i;
    nodes = allNodes(clusters);
    mat = FC(nodes,nodes);
    %mat = (mat - min(mat(:)))/(max(mat(:)) - min(mat(:))); % normalized matrix
    statisticsNewmanCell{1,i} = mean(mat);
    statisticsNewmanCell{2,i} = std(mat);
    statisticsNewmanCell{3,i} = mean2(mat);
    statisticsNewmanCell{4,i} = std2(mat);
end
disp('Newman Q = '), disp(Q)

% graph of clusters
ROIcoordsSC = dlmread('./data/UCLA_Autism_TD132_CCN_DTI_region_xyz_centers.txt');
Nclstrs = figure('name', 'newman clusters');
figure(Nclstrs);
colormap(jet);
scatter3(ROIcoordsSC(:,1),ROIcoordsSC(:,2),ROIcoordsSC(:,3),30,M,'filled');
end

