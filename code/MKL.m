function [ H, corr, alpha, X, Y ] = MKL( SC,FC,inds,m )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

%num_scales = [4,8,16,32,64];
n = size(SC,1);
gamma = 0.1; % lagrange multiplier for \alpha regularization
% this code outputs correlation coefficient for multiple number of kernels
W = SC;
D = diag(sum(W));
L = (D - W);
t = logspace(log10(0.01),log10(1),m-1);
t = [0,t];
X = zeros(n*n,m);
for j = 1 : size(t,2)
    K = expm(-L*t(j));
    X(:,j) = reshape(K,[n*n,1]);
end
Y = reshape(FC,[n*n,1]);
alpha = pinv(X)*Y;
%alpha = (inv(X'*X - eye(m)*gamma)\X')*Y;
H = X*alpha; H = reshape(H,[n,n]);
err = corrcoef(H(inds),(FC(inds)));
corr = err(1,2);

end

%(inv(Psi'*Psi+eye(m)*gamma)*Psi')*Phi;
