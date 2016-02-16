clear
clc
cd /Users/govinda/Desktop/winter2015-master/Code/
W = dlmread('UCLA_Autism_TD128B_DTI_connectmat.txt');
FC = dlmread('UCLA_Autism_TD128_rsfMRI_connectmat.txt');
FC(isinf(FC)) = 0;
cd /Users/govinda/Desktop/spring2016/code

[M,Q] = community_louvain(W,2.5);
allNodes = 1 : 264;

statisticsLouvianCell = cell(4,max(M)); % 1. mean of cols, 2. std of cols, 3. overall mean, 4. overall std 
for i = 1 : max(M)
    clusters = M == i;
    nodes = allNodes(clusters);
    mat = FC(nodes,nodes);
    %mat = (mat - min(mat(:)))/(max(mat(:)) - min(mat(:)));
    statisticsLouvianCell{1,i} = mean(mat);
    statisticsLouvianCell{2,i} = std(mat);
    statisticsLouvianCell{3,i} = mean2(mat);
    statisticsLouvianCell{4,i} = std2(mat);
end