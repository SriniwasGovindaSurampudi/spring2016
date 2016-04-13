close all
j = 70;
scale = 10^-2;
figure;
b = sort(FC(:,j));
plot(b);
figure;
pause(5)
for i = 1 : 200
    scale = scale * 2;
    HSC = USC * diag(exp(-diag(Lambda)*scale)) * USC';
    norm(HSC,'fro');
    HSC = HSC./norm(HSC,'fro');
    HSC = HSC - mean2(HSC);
    a = sort(HSC(:,j));
    plot(a)
    axis([0 190 -0.006 0.1])
    grid on
    pause(0.25)
end
% hold on
% plot(HSC(:,30))
% plot(HSC(:,40))
% plot(HSC(:,70))
% plot(HSC(:,100))