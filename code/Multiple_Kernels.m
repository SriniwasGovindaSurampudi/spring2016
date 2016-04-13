clear
%close all

load('/Users/govinda/Desktop/spring2016/Original Authors code/fC_to_sC_Mtx.mat')

numSubj = size(fCall,3);
n = 90; % num ROIs
Psi = [];
Phi = [];
m = 8; % number of kernels
lambda = 1; % lagrange multiplier for \alpha regularization
for sample = 1 : numSubj
    nzs = nonzeros(sCall(:,:,sample));
    MapC =((sCall(:,:,sample) > 0.1*std(nzs))) .* sCall(:,:,sample);
    NormMean = mean(nonzeros(MapC));
    MapC = MapC/NormMean; % Normalize struct matrix
    clear NormMean;
    
    tmp = fCall(:,:,sample);
    inds = (abs(fCall(:,:,sample)) > 0.05*max(abs(tmp(:))));
    corr_graphs = fCall(:,:,sample);
    %inds(1:91:end) = 0;
    [H(:,:,sample),corr(sample),alpha(:,sample),X(:,:,sample),Y(:,sample)] = MKL(MapC,abs(corr_graphs),inds,m);
    Psi = [Psi;X(:,:,sample)];
    Phi = [Phi;Y(:,sample)];
    c = corrcoef(H(:,:,sample).*inds,abs(corr_graphs.*inds));
    corr_outside(sample)  = c(1,2);
end
ALPHA = pinv(Psi)*Phi;
%ALPHA = ((Psi'*Psi - eye(m)*lambda)\Psi')*Phi;
for l = 1 : numSubj
    H_ALPHA(:,:,l) = reshape(X(:,:,l)*ALPHA,[n,n]);
    c = corrcoef(abs(H_ALPHA(:,:,l).*inds), abs(fCall(:,:,l).*inds));
    corr_ALPHA(l) = c(1,2);
end
%*************************************************************************%
% when 1st four subjects are used for ALPHA, and then ALPHA tested on last
% 4
figure,
hold on
plot(corr)
plot(corr_outside)
plot(corr_ALPHA)
hold off
title('correlations for each subject, MKL')