%% Collecting NKI_Rockland dataset
%**************************************************************************
%the cell array data_names contains one subject in a column in the order 
% 1. DTI_connectivity_matrix_file
% 2. DTI_region_names_abbrev_file
% 3. DTI_region_names_full_file
% 4. DTI_region_xyz_centers_file
% 5. fcMRI_noGSR_connectivity_matrix_file
% 6. fcMRI_noGSR_region_names_abbrev_file
% 7. fcMRI_noGSR_region_names_full_file
% 8. fcMRI_noGSR_region_xyz_centers_file
% fcMRI can be *_GSR_* also
%**************************************************************************
addpath(genpath('/Users/govinda/Desktop/spring2016'))
data_names = cell(8,197);
n = 188;
all_Emp_SC = zeros(n,n,size(data_names,2));
all_Emp_FC = zeros(n,n,size(data_names,2));
data = dir(strcat('./','./NKI_Rockland'));

for sample = 0 : 196
    for j = 1 : 8
        data_names{j,sample+1} = data(8*sample+j+3).name;
    end
    all_Emp_SC(:,:,sample+1) = dlmread(strcat('./NKI_Rockland/', data_names{1,sample+1}));
    all_Emp_FC(:,:,sample+1) = dlmread(strcat('./NKI_Rockland/', data_names{5,sample+1}));
end
%{
sample : subject number
%}
% %% Storing GMM results of all subjects
% numClusters = 10; % or 8 
% GMModel_Joint_allSubjects = cell(1,197);
% F = cell(1,197);
% for subject = 1 : 197
%     SC = dlmread(strcat('./NKI_Rockland/', data_names{1,subject}));
%     FC = dlmread(strcat('./NKI_Rockland/', data_names{5,subject}));
%     WSC = SC;
%     WFC = abs(FC);
%     [ F{1,subject}, indices ] = coClusters( WSC, WFC, 13, numClusters );
%     options = statset('Display','final');
%     GMModel_Joint_allSubjects{1,subject} = fitgmdist(F{1,subject}(:,2:min(numClusters + 1,size(F{1,subject},2))),numClusters,'Options',options,'RegularizationValue',0.005);
% end
% 
% %% Finding similarities in clusters in all subjects
