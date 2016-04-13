close all;
all = randperm(197);
for i = 1 : 5
    j(i) = figure('name',num2str(all(i)));
    colormap('jet')
    hold on
    grid on
    title('Joint embedding space, GMM numClusters')
    xlabel('x'); ylabel('y'); zlabel('z');
    scatter3(F{1,all(i)}(:,2),F{1,all(i)}(:,3),F{1,all(i)}(:,4),40,GMModel_Joint_allSubjects{1,all(i)}.cluster(F{1,all(i)}(:,2:min(numClusters + 1,size(F,2)))),'filled');
    [ jc ] = drawEllipsoids( GMModel_Joint_allSubjects{1,all(i)}.mu, GMModel_Joint_allSubjects{1,all(i)}.Sigma );
    hold off
end

%GMModel_Joint_allSubjects{1,all(i)}.cluster(F{1,all(i)}(:,2:min(numClusters + 1,size(F,2))))