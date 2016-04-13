% today i tried to see how are the heat kernels arranged in scale space.
% This might extend for few days.
% i.e. for an SC matrix, how does heat diffuse on the graph. The purpose
% is to find a set of scales which cover double the nodes covered by the just the previous scale.
close all
f1 = figure('name','ROI 10');
f2 = figure('name','ROI 75');
init_distr_10 = zeros(188,1); init_distr_10(10,1) = 1;
init_distr_75 = zeros(188,1); init_distr_75(75,1) = 1;
scale = 10^-3;
for i = 1 : 2
    scale = scale * 10
    HSC = USC * diag(exp(-diag(Lambda)*scale)) * USC';
    % for ROI 10
    final_distr = HSC * init_distr_10;
    final_distr = final_distr - mean(final_distr);
    %colormap('jet')
    figure(f1);
    hold on
    plot(final_distr)
    %pause(2)
    % for ROI 75
    final_distr = HSC * init_distr_75;
    final_distr = final_distr - mean(final_distr);
    figure(f2);
    hold on
    plot(final_distr)
end
figure(f1);
grid on
figure(f2);
grid on