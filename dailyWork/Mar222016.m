%% Data
%**************************************************************************%
addpath(genpath('/Users/govinda/Desktop/spring2016'))
%reading data
SC = dlmread('./NKI_Rockland/1334913_DTI_connectivity_matrix_file.txt');
FC = dlmread('./NKI_Rockland/1334913_fcMRI_noGSR_connectivity_matrix_file.txt');
coordsSC = dlmread('./NKI_Rockland/1334913_DTI_region_xyz_centers_file.txt');
coordsFC = dlmread('./NKI_Rockland/1334913_fcMRI_noGSR_region_xyz_centers_file.txt');
%**************************************************************************%
%% exp(-lambda*t) vs (t, lambda)
WSC = SC;
DSC = diag(sum(WSC));
LSC = DSC\(DSC - WSC);
[USC,Lambda] = eig(LSC);

t = [0:100];
d = sort(diag(Lambda));
ExpLambda = (exp((-1)*d(2:5)*t));
plot(t,ExpLambda)
grid on

%% Observations
%{
1. scale corresponding to \inf is 50
%}