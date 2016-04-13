function [ all_Emp_SC,all_Emp_FC,data_names ] = Collect_NKI_Rockland_Data( path )
%COLLECT_NKI_ROCKLAND_DATA Summary of this function goes here
% usage:
% [ all_Emp_SC,all_Emp_FC,data_names ] = Collect_NKI_Rockland_Data( path )
% Collecting NKI_Rockland dataset
% path : (input) main folder path; (default) '/Users/govinda/Desktop/spring2016'
% all_Emp_SC : (output) all subjects' SC matrices in 3d matrix
% all_Emp_FC : (output) all subjects' FC matrices in 3d matrix
% data_names : (output) cell containig names of files belonging to every
% subject
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
% sample : subject number
% path : 
%**************************************************************************
addpath(genpath(path))
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
end

