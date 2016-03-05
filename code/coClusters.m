function [ F, indices ] = coClusters( W1, W2, mu, numClusters )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   F : joint spectrum, 2 : end can be used for clustering
%   indices : k-means cluster indices 

%*********************************************************%
%first view
D1 = diag(sum(W1));
L1 = D1 - W1;
L1rw = D1 \ L1;
[U1, Lambda1] = eig(L1rw);
[~,ind] = sort(diag(Lambda1));
Lambda1 = Lambda1(:,ind);
U1 = U1(:,ind);

%second view
D2 = diag(sum(W2));
L2 = D2 - W2;
L2rw = D2 \ L2;

%*********************************************************%
%joint spectrum
F = mu * ((L2rw + mu * eye(size(W2))) \ U1);
%clustering
[indices] = kmeans(F(:,2:min(numClusters+1,size(W1,2))),numClusters);
%hist(indices, numClusters)
end