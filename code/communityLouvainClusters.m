function [ statisticsLouvianCell ] = communityLouvainClusters( W,FC )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

FC = (FC - min(FC(:)))/(max(FC(:)) - min(FC(:)));

[M,Q] = community_louvain(W,1); % clustering function
allNodes = 1 : 264;

statisticsLouvianCell = cell(4,max(M)); % 1. mean of cols, 2. std of cols, 3. overall mean, 4. overall std

for i = 1 : max(M) % collecting statistics
    clusters = M == i;
    nodes = allNodes(clusters);
    mat = FC(nodes,nodes);
    mat = (mat - min(mat(:)))/(max(mat(:)) - min(mat(:)));  % normalized matrix
    statisticsLouvianCell{1,i} = mean(mat);
    statisticsLouvianCell{2,i} = std(mat);
    statisticsLouvianCell{3,i} = mean2(mat);
    statisticsLouvianCell{4,i} = std2(mat);
end
disp('Louvian Q = '), disp(Q)
end

