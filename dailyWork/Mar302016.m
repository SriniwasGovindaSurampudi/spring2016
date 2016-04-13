%% Data
%**************************************************************************%
addpath(genpath('/Users/govinda/Desktop/spring2016'))
%reading data
SC = dlmread('./NKI_Rockland/1334913_DTI_connectivity_matrix_file.txt');
FC = dlmread('./NKI_Rockland/1334913_fcMRI_noGSR_connectivity_matrix_file.txt');
coordsSC = dlmread('./NKI_Rockland/1334913_DTI_region_xyz_centers_file.txt');
coordsFC = dlmread('./NKI_Rockland/1334913_fcMRI_noGSR_region_xyz_centers_file.txt');
%**************************************************************************%
%% Find best scale as of original paper
close all
WSC = SC;
WFC = abs(FC);
DSC = diag(sum(WSC));
LSC = DSC - WSC;
[USC,Lambda] = eig(LSC);
DLambda = diag(Lambda);
ind = 1;
s = [0.00001 : 0.00001 : 0.0005];
for scale = s
    % heat kernel %
    H = USC * diag(exp(-DLambda*scale)) * USC';
    HSC{ind} = (H - min(H(:)))./(max(H(:) - min(H(:))));
    % error %
    error(ind) = sqrt(sum(sum((HSC{ind} - WFC).^2)))/size(WSC,1)^2; 
    ind = ind+1;
end
plot(error)
[v,i] = min(error);
figure, imagesc(HSC{i})
figure, imagesc(WFC)
%% multiple scales
% choose new_scale = best_scale* 0.5 %
H_new = USC * diag(exp(-DLambda*s(round(i/2)))) * USC'+  HSC{i};
H_new = (H_new - min(H_new(:)))./(max(H_new(:) - min(H_new(:))));
error_new = sqrt(sum(sum((H_new - WFC).^2)))/size(WSC,1)^2;
r = (error_new - error(i))%/error(i)
