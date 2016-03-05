function [ sc ] = drawEllipsoids( Mu, Sigma )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%This function takes as input a matrix of centers(each row one center), and
%a 3d matrix whose each 2d matrix from the 3rd dimension(:,:,i) is covariance
%matrix corresponding to its row in center. 
% Loop iterates over the clusters of the data
N = 1;
for i = 1 : size(Mu,1)
    mu = Mu(i,:);
    [u,l] = eig(Sigma(:,:,i));
    radii = N*sqrt(diag(l));
    [xc,yc,zc] = ellipsoid(0,0,0,radii(end),radii(end-1),radii(end-2));
    a = kron(u(:,end),xc); b = kron(u(:,end-1),yc); c = kron(u(:,end-2),zc);
    data = a+b+c; n = size(data,2);
    x = data(1:n,:)+mu(1); y = data(n+1:2*n,:)+mu(2); z = data(2*n+1:3*n,:)+mu(3);
    sc(i) = surf(x,y,z);
    %shading interp
    alpha(0.25)
end

end

