function [ H ] = Kernels_version2( SC, p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n = size(SC,1);
H = zeros(n,n,p);
gamma = 0.1; % lagrange multiplier for \alpha regularization
% this code outputs correlation coefficient for multiple number of kernels
W = SC;
D = diag(sum(W));
L = (D - W);
t = logspace(log10(0.01),log10(1),p-1);
t = [0,t];
for i = 1 : p
    H(:,:,i) = expm(-L*t(i));
end
end

