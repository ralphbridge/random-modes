clear all
clc

%%%%%%%%%%%%%%% Inverse transform method %%%%%%%%%%%%%%%%%%%

Nmod=10000; %Number of modes
Rin=11; % Internal radius
Rout=19; % External radius

u=(Rout^3-Rin^3)*rand(Nmod,1)+Rin^3;
v=rand(Nmod,1);
w=rand(Nmod,1);

theta=zeros(Nmod,1);
phi=zeros(Nmod,1);
r=u.^(1/3);

for i=1:Nmod % This generates random numbers uniformly over the surface of a sphere of radius 1
    theta(i)=acos(1-2*v(i));
    phi(i)=2*pi*w(i);
    x(i)=r(i)*sin(theta(i))*cos(phi(i));
    y(i)=r(i)*sin(theta(i))*sin(phi(i));
    z(i)=r(i)*cos(theta(i));
end

plot3(x,y,z,'.')
grid on
axis equal
xlabel('$x$','interpreter','latex','fontsize',20)
ylabel('$y$','interpreter','latex','fontsize',20)
zlabel('$z$','interpreter','latex','fontsize',20)
title('Sampling numbers inside the spherical shell of radii $R_{out}$ and $R_{in}$ using the inverse transform method','interpreter','latex','fontsize',10)

j=1;
for i=1:Nmod
    if(abs(x(i))<Rout/10)
        yproy(j)=y(i);
        zproy(j)=z(i);
        j=j+1;
    end
end

figure
plot(yproy,zproy,'.')
grid on
axis equal
xlabel('$y$','interpreter','latex','fontsize',20)
ylabel('$z$','interpreter','latex','fontsize',20)
title('Cross section of the shell of radii $R_{out}$ and $R_{in}$ using the inverse transform method','interpreter','latex','fontsize',10)
A=[r,theta,phi];