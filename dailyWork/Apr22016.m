subject = subjects(11);
SC = dlmread(strcat('./NKI_Rockland/', data_names{1,subject}));
FC = dlmread(strcat('./NKI_Rockland/', data_names{5,subject}));
WSC = SC;
WFC = FC;
DSC = diag(sum(WSC));
LSC = DSC - WSC; % combinatorial laplacian
[USC,Lambda] = eig(LSC);
%*************************************************************************%
empFC = 