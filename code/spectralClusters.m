function [ Ured, idx, centers ] = spectralClusters( W, numClusters, type )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   This function gives back spectral clusters 
%   of different types.
%   usage; [Ured, idx, centers] = spectralClusters(W, numClusters, type)
%   type:   'unnormalized', 'randomWalk', 'symmetric'
%   Ured : eigenfunctions used for clustering
%   idx  : indices of k-means clustering

D = diag(sum(W));
L = D - W;

switch (type)
    case 'unnormalized'
        [U, ~] = eig(L);
        Ured = U(:,2:min(numClusters + 1,size(W,2)));
        [idx, centers] = kmeans(Ured, numClusters);
    case 'randomWalk'
        [U, Lambda] = eig(D\L);
        s = sum(Lambda);
        [~,idx] = sort(s);
        Lambda = Lambda(:,idx);
        U = U(:,idx);
        Ured = U(:,2:min(numClusters + 1,size(W,2)));
        [idx, centers] = kmeans(Ured, numClusters);
    case 'symmetric'
        [U,Lambda] = eig(D^(-0.5)*L*D^(-0.5));
        s = sum(Lambda);
        [~,idx] = sort(s);
        Lambda = Lambda(:,idx);
        U = U(:,idx);
        absU = sqrt(sum(U.^2,2));
        U = bsxfun(@rdivide, U, absU);
        Ured = U(:, 2:min(numClusters + 1, size(W,2)));
        [idx, centers] = kmeans(Ured, numClusters);
end
end

