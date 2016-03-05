
%% Example1: Basic use of co-clustering
% Description of first code block
clear; 
clc;
close all;

% load the toy data
load example_data; % containing A, a 49x50 toy matrix

% Setting for spectral coclustering
k = 5;  % the number of clusters
display = 1;

names = [];
[row_clust_idx, col_clust_idx,y_index,x_index]=SpectralCoClustering(A,k,display,names);
title('co-clustering on binary data matrix');
ylabel('class label for each data instance');
xlabel('feature');

disp(['The desired number of clusters: ',num2str(k)]);
disp(['The output number of clusters for row (data instance): ',num2str(length(unique(row_clust_idx(:))))]);
disp(['The output number of clusters for col (feature): ',num2str(length(unique(col_clust_idx(:))))]);
%% Example 2: Using the wrapper to plot the co-clustering
% Description of second code block
[row_clust_ids, col_clust_ids,y_index,x_index]=PlotCoClustering(A,k);
title('co-clustering on binary data matrix');
ylabel('class label for each data instance');
xlabel('feature');


%% Example 3: The code also works on non-binary (noisy) data
% Add some noise to the data matrix
B = A+0.1*randn(size(A,1),size(A,2));
figure; 
subplot(1,2,1); imagesc(A); daspect([1 1 1]); title('original binary data matrix');
subplot(1,2,2); imagesc(B); daspect([1 1 1]); title('original noisy data matrix');

[row_clust_idx, col_clust_idx,y_index,x_index]=SpectralCoClustering(B,k,display,names);
title('co-clustering on noisy data matrix');
ylabel('class label for each data instance');
xlabel('feature');

[row_clust_ids, col_clust_ids,y_index,x_index]=PlotCoClustering(B,k);
title('co-clustering on noisy data matrix');
ylabel('class label for each data instance');
xlabel('feature');

%% Example 4: How to use the output indices??
% the question is what does each variable mean?
% row_clust_idx, col_clust_idx, row_clust_ids, col_clust_ids, y_index,x_index

% ===============================================
% What are "y_index" and "x_index"?
% In summary, 
%
%                      (x_index and y_index)
%   original space ----------------------------> co-clustering matrix space
%                       A ---> A_xy (or A_yx)
%           col_clust_ids ---> col_clust_ids(x_index)
%           row_clust_ids ---> row_clust_ids(y_index)
% 
% col_clust_ids is the class label for each feature (col) in the original
% order of A.
% ===============================================
A_y = A(y_index, :);
A_yx = A_y(:,x_index);
% A_yx  is the co-clustering result obtained from A
% In fact, A_yx is the resulting plot output from the code
% PlotCoClustering and SpectralCoClustering
% It's worth mentioning that A_xy = A_yx, that is, the order of applying
% x-->y or y-->x does not matter
A_x = A(:,x_index);
A_xy = A_x(y_index,:);

% Plot to see the result
figure; 
subplot(2,2,1); imagesc(A_y); daspect([1 1 1]); title('A_y');
subplot(2,2,2); imagesc(A_yx); daspect([1 1 1]); title('A_{yx}');
subplot(2,2,3); imagesc(A_x); daspect([1 1 1]); title('A_x');
subplot(2,2,4); imagesc(A_xy); daspect([1 1 1]); title('A_{xy}');

figure; 
subplot(2,2,2); imagesc(col_clust_ids(x_index)');
subplot(2,2,3); imagesc(row_clust_ids(y_index));
subplot(2,2,4); imagesc(A_yx);

%% Example 5: A good way to visualize the data
label_row = row_clust_ids(y_index);
label_row = relabel(label_row);
label_col = col_clust_ids(x_index)';
label_col = relabel(label_col);
coclust_matrix = label_row*label_col;
figure; imagesc(coclust_matrix.*A_yx);

% Make a nicer visualization
A_x = B(:,x_index);
A_xy = A_x(y_index,:);
A_color = repmat(A_xy,[1 1 3]);
A_color(:,:,1) = repmat(label_col,[size(A_xy,1),1])/max(label_col(:));
A_color(:,:,3) = repmat(label_row,[1,size(A_xy,2)])/max(label_row(:));
figure; imshow(A_color);
title('visualization of the co-clustering');
xlabel('feature clusters');
ylabel('data instance clusters');