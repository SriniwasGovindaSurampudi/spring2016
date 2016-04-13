clear
%close all

load('/Users/govinda/Desktop/spring2016/Original Authors code/fC_to_sC_Mtx.mat')
%*************************************************************************%
% training
%*************************************************************************%
L = size(fCall,3);
n = size(fCall,1);
p = 16;
H = cell(1,L);
Psi = zeros(n*L,n,p);
Phi = zeros(n*L,n);
alpha = zeros(p,1,n);
ALPHA = zeros(n,n,p);

for l = 1 : L % subjects
    % SC pre-processing
    nzs = nonzeros(sCall(:,:,l));
    MapC =((sCall(:,:,l) > 0.1*std(nzs))) .* sCall(:,:,l);
    NormMean = mean(nonzeros(MapC));
    MapC = MapC/NormMean; % Normalize struct matrix
    clear NormMean;
    
    % FC pre-processing
    tmp = fCall(:,:,l);
    inds = (abs(fCall(:,:,l)) > 0.05*max(abs(tmp(:))));
    %inds(1:91:end) = 0;
    
    % set of heat kernels
    [H{l}] = Kernels_version2(MapC,p);
    % forming \Phi and \Psi matrices
    Psi((l-1)*n+1:l*n,:,:) = H{l};
    Phi((l-1)*n+1:l*n,:) = abs(fCall(:,:,l).*inds); % compare with abs of FC
end

% calculate \ALPHA
for j = 1 : n
    alpha(:,j) = pinv(squeeze(Psi(:,j,:))) * Phi(:,j);
end
% reshaping alpha into diagonal matrix set
for i = 1 : p
    ALPHA(:,:,i) = diag(alpha(i,:));
end
clear alpha
%*************************************************************************%
% testing
%*************************************************************************%
pred_FC = zeros(n,n,L);
corr = zeros(1,L);
for l = 1 : L
    % SC pre-processing
    nzs = nonzeros(sCall(:,:,l));
    MapC =((sCall(:,:,l) > 0.1*std(nzs))) .* sCall(:,:,l);
    NormMean = mean(nonzeros(MapC));
    MapC = MapC/NormMean; % Normalize struct matrix
    clear NormMean;
    
    % FC pre-processing
    tmp = fCall(:,:,l);
    inds = (abs(fCall(:,:,l)) > 0.05*max(abs(tmp(:))));
    %inds(1:91:end) = 0;
    
    % set of heat kernels
    H = Kernels_version2(MapC,p);
    for i = 1 : p
        pred_FC(:,:,l) = pred_FC(:,:,l) + H(:,:,i)*ALPHA(:,:,i);
    end
    c = corrcoef(pred_FC(:,:,l).*inds,abs(fCall(:,:,l).*inds));
    corr(1,l) = c(1,2);
end