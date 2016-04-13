subjects = randperm(197);

subject = subjects(11);
SC = dlmread(strcat('./NKI_Rockland/', data_names{1,subject}));
FC = dlmread(strcat('./NKI_Rockland/', data_names{5,subject}));
WSC = SC;
WFC = FC;
DSC = diag(sum(WSC));
LSC = DSC - WSC;
[USC,Lambda] = eig(LSC);
%% one subject matrices
scale = [1,2,4,8,16,32,64,128,256,512];
El = zeros(1,10);
for num = 1 : 10
    t = logspace(0,log10(50),scale(num));
    X = zeros(size(LSC,1)*size(LSC,2),size(t,2));
    for i = 1 : size(t,2)
        K = USC * diag(exp(-t(i)*diag(Lambda))) * USC';
        X(:,i) = reshape(K,[size(LSC,1)*size(LSC,2),1]);
    end
    Y = reshape(abs(WFC),[size(LSC,1)*size(LSC,2),1]);
    alpha = pinv(X)*Y;
    El(1,num) = norm(X*alpha - Y,'fro');
end
plot(El);title('E for one sample')
% %% random alphas
% % computing $X^{l},Y^{l}$ at optimum number of scales(= 16).
% t = logspace(0,log10(50),16);
% X = zeros(size(LSC,1)*size(LSC,2),size(t,2));
% for i = 1 : size(t,2)
%     K = USC * diag(exp(-t(i)*diag(Lambda))) * USC';
%     X(:,i) = reshape(K,[size(LSC,1)*size(LSC,2),1]);
% end
% Y = reshape(WFC,[size(LSC,1)*size(LSC,2),1]);
% alpha = pinv(X)*Y;
% % adding noise into alpha to see the global minimum effect
% alphaSet = zeros(16,50);
% alphaSet(:,1) = alpha;
% for i = 2 : 50
%     alphaSet(:,i) = alpha + randn(16,1);
% end
% % collecting $E^{l}(alpha)$
% El = zeros(1,50);
% for i = 1 : 50
%     El(1,i) = norm(X*alphaSet(:,i) - Y,'fro');
% end
% [s,idx] = sort(El)
% plot(s)
% xlim([1,50])
% grid on
% %% taking some samples,i.e. SC,FC pairs, 11 pairs
% 
% close all;
% %subjects = randperm(197);
% m = 10;
% n2 = 188*188;
% L = 11;
% %subjects = [1:L];%randperm(197);
% gamma=1;
% 
% t = logspace(-5,log10(2),m);
% X = zeros(n2,size(t,2));
% Psi = []; Phi = [];
% for l = 1 : L % l == sample
%     % one sample's LSC
%     subject = subjects(l);
%     SC = dlmread(strcat('./NKI_Rockland/', data_names{1,subject}));
%     FC = dlmread(strcat('./NKI_Rockland/', data_names{5,subject}));
%     WSC = SC;
%     WFC = FC;
%     DSC = diag(sum(WSC));
%     LSC = DSC - WSC;
%     [USC,Lambda] = eig(LSC);
%     % $X^{l},Y^{l}$
%  %   hold on;
%     % make X^{l} and Y^{l}
%     for i = 1 : size(t,2)
%         K = USC * diag(exp(-t(i)*diag(Lambda))) * USC';
%         X(:,i) = reshape(K,[size(LSC,1)*size(LSC,2),1]);
%   %      plot(exp(-t(i)*diag(Lambda)));
%     end
%     Y = reshape((WFC),[size(LSC,1)*size(LSC,2),1]);
%     % concatenate to make Psi and Phi matrices
%     Psi = [Psi;X]; Phi = [Phi;Y];
% end
% ALPHA = pinv(Psi)*Phi;
% %ALPHA = (inv(Psi'*Psi+eye(m)*gamma)*Psi')*Phi;
% %ALPHA = inv(Psi'*Psi+eye(m)*gamma)*(Psi'*Phi-1);
% 
% % adding noise to ALPHA to see global minimum effect
% ALPHA_SET = zeros(m,50);
% ALPHA_SET(:,1) = ALPHA;
% for i = 2 : 50
%     ALPHA_SET(:,i) = ALPHA + randn(m,1);
% end
% %% calculating error(s)
% E = zeros(1,50);Var = zeros(1,50);
% for i = 1 : 50
%     E(1,i) = norm(Psi*ALPHA_SET(:,i)-Phi)/(n2*L);%sum((Psi*ALPHA_SET(:,i)-Phi).^2)/(n2*L);
%     Var(1,i) = std(((Psi*ALPHA_SET(:,i)-Phi).^2/(n2*L)));
% end
% [S,idx] = sort(E)
% Var = Var(1,idx)
% plot(E)
% grid on
% % images
% figure,imagesc(reshape(P(1:188^2),[188,188]))
% figure,imagesc(reshape(Phi(1:188^2),[188,188]))
%%
% % for some subject noise effect on ALPHA
% E = zeros(1,50); Up = zeros(1,50); Low = zeros(1,50);
% for i = 1 : 50
%     P = Psi * ALPHA_SET(:,i);
%     for l = 0 : L-1
%         El(l+1) = (sum((P(l*n2+1:(l+1)*n2,:) - Phi(l*n2+1:(l+1)*n2,:)).^2));
%     end
%     E(1,i) = (sum(El))/L;
%     Up(1,i) = max(El);
%     Low(1,i) = min(El);
% end
% [S,idx] = sort(E)
% [Up] = Up(1,idx);
% Low = Low(1,idx);
% xlim([1,50])
% grid on
% plot(S/n2);
% %errorbar(1:50,E,Low,Up);
%% observations
%{
1. 16 number of scales are sufficient as $E^{l}$ is almost constant after
those many scales.


%}