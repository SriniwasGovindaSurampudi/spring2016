function Hhat = implementationExample

% Hhat: Estimated functional connectivity matrices of eight subjects, struct.
%
% Saved in *.mat file funcStructParameters:
% Mtx: Struct of resulting functional connectivity estimates
% Cor: Struct of Pearson correlation between estimated and true functional connectivities. 
% Pval: Corresponding p-value probabilities
%
% The script retrieves function/structure data from the mat file
% fC_to_sC_Mtx.mat containing FC matrices and fCall (90x90x8) and SC matrices
% (90x90x8).

% Load function and structure matrices (eight pairs) fCall and sCall
load('fC_to_sC_Mtx');

% Number of subjects
numSubj = size(fCall,3);

% Mean functional and structural conn matrices
%meanfC = mean(fCall,3);
%meansC = mean(sCall,3);

for jj=1:numSubj
% Obtain structural map,
    % Sparsify and nomalize MapC
    disp(['Threshold and normalize structural matrix for subject ' num2str(jj)])
    nzs = nonzeros(sCall(:,:,jj));
    % Set elements less than $0.1*\sigma$ to zero
    L = (sCall(:,:,jj) > 0.1*std(nzs)); 
    MapC = L .* sCall(:,:,jj);
    % Mean of nonzeros after thresholding
    
    NormMean = mean(nonzeros(MapC));
    MapC = MapC/NormMean; % Normalize struct matrix
    clear NormMean;
    
    % Obtain functional map
    disp(['Threshold functional connectivity matrix for subject ' num2str(jj)])
    % Threshold functional matrices minimally
    tmp = fCall(:,:,jj);
    inds = (abs(fCall(:,:,jj)) > 0.05*max(abs(tmp(:))));
    
%% Laplacian linear model
    % Resulting matrix H is saved in the current folder as LaplaceMtx.mat
    
    disp(['Linear model, subject ' num2str(jj)])
    % Run normalized Laplacian matrix model
    corr_graphs = fCall(:,:,jj);
    [Mtx.H{jj},ErrH{jj},~,tvec] = LinearModel(MapC,abs(corr_graphs),inds);
    inds(1:91:end) = 0;
    [corCoef,Pval.pval{jj}] = corrcoef(Mtx.H{jj}(inds),abs(corr_graphs(inds)));%corrcoef(Mtx.H{jj} .* inds,corr_graphs .* inds);
    Cor.corCoef(jj) = corCoef(1,2);
end

Hhat = Mtx.H;

% Create figure:
figure; 
hold on;
for ii=1:numSubj
plot(tvec,ErrH{ii});
end
hold off;
title('Pearson correlation curves for all subjects');
xlabel('\beta t');
ylabel('Pearson correlation');

save funcStructParameters Cor Mtx Pval 

%% Function to estimate graph diffusion
function [H,corCoef,pval,tvec] = LinearModel(MapC,corr_graphs,inds)

% Estimate the (normalized symmetric) Laplacian matrix
% MapC: Structural connectivity matrix
% corr_graphs: Data-generated functional connectivity matrix
%
% H: functional connectivity estimate
% corCoef: corresponding Pearson correlation with true functional connectivity
% pval: corresponding p-value matrix at each iteration 

nt = 100;
beta = 1;

tvec = linspace(0,10, nt);
degC = diag(sum(MapC,2)); % Connectivity strength matrix

% Unnormalized Laplacian, aka "generator matrix":
A = degC - MapC;
% Normalized Laplacian matrix:
iDelta = diag(sqrt(1./(diag(degC + eps))));

A = iDelta * A * iDelta;

for ii=1:nt
    Hhat = expm(-beta*A*tvec(ii));
    [Err,pval{ii}] = corrcoef(Hhat(inds),corr_graphs(inds));
    corCoef(ii) = Err(1,2);
end

erR = find(corCoef == max(corCoef));
H = expm(-beta*A*tvec(erR));




