function [ k ] = vectorize_matrix( M )
%UNTITLED11 Summary of this function goes here
%   stack all upper triangular elements of matrix in a column
% M : square matrix
[m,~] = size(M);
k = [];
for i = 1 : m
    k = [k;M(i,i:m)'];
end
end

