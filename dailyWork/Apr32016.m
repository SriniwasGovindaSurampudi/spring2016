%% data in
% NKI_Rockland
path = '/Users/govinda/Desktop/spring2016';
[ all_NKI_Emp_SC,all_NKI_Emp_FC,data_names ] = Collect_NKI_Rockland_Data( path );
%% our data, author's code NKI
L = 11; n = 188;
sCall = zeros(n,n,L);
fCall = zeros(n,n,L);
samples = randperm(size(data_names,2)); % to get random samples for MKL.
% the diagonal entries are not forced to 1
for smpl = 1: L
    sCall(:,:,smpl) = all_NKI_Emp_SC(:,:,samples(smpl));
    fCall(:,:,smpl) = all_NKI_Emp_FC(:,:,samples(smpl));
end
Hhat_NKI_NoChange = copyAuthorsCode(sCall,fCall);
title('NKI nochange')
% the diagonal entries are forced to 1
for i = 1 : 197
    NKI_FC = all_NKI_Emp_FC(:,:,i);
    NKI_FC(1:189:end) = 1;
    all_NKI_Emp_FC(:,:,i) = NKI_FC;
end
Hhat_NKI_Diag_One = copyAuthorsCode(all_NKI_Emp_SC(:,:,10:20),all_NKI_Emp_FC(:,:,10:20));
title('NKI diag=1')
%% our data, our code NKI
%% our data, authors code, UCLA
load('/Users/govinda/Desktop/spring2016/mat_files/TD 5 samples/TD_5_samples.mat')
all_UCLA_Emp_FC = all_Emp_FC;
all_UCLA_Emp_SC = all_Emp_SC;

%% author's data, our code
load('/Users/govinda/Desktop/spring2016/mat_files/TD 5 samples/TD_5_samples.mat')
for i = 1:5
    maxi_ad_oc(i) = struct_to_func(sCall(:,:,1),fCall(:,:,1),diag(sum(squeeze(sCall(:,:,1)))));
end