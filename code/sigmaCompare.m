function [ diff ] = sigmaCompare( Sigma1, Sigma2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% assumes size of Sigma1 and Sigma2 as same
[e1,l1] = eig(Sigma1); [e2,l2] = eig(Sigma2);
diff = sqrt(sum(sum((e1.*l1 - e2.*l2).^2)));
end

