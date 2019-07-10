clear all
clc

fileID = fopen('k-vectors.txt','r');
formatSpec = '%e,%e,%e';
sizeA = [3 Inf];
A = fscanf(fileID,formatSpec,sizeA);
A=A';
fclose(fileID);

k=A(:,1);
theta=A(:,2);
phi=A(:,3);

x=zeros(size(k));
y=zeros(size(k));
z=zeros(size(k));

for i=1:length(k)
    x(i)=k(i)*sin(theta(i))*cos(phi(i));
    y(i)=k(i)*sin(theta(i))*sin(phi(i));
    z(i)=k(i)*cos(theta(i));
end

figure
plot3(x,y,z,'.')
grid on
axis equal
xlabel('$x$','interpreter','latex','fontsize',20)
ylabel('$y$','interpreter','latex','fontsize',20)
zlabel('$z$','interpreter','latex','fontsize',20)
title('Sampling numbers inside the spherical shell of radii $k_{max}$ and $k_{min}$ using the inverse transform method','interpreter','latex','fontsize',10)

j=1;
kmax=max(k);
for i=1:length(k)
    if(abs(x(i))<kmax/10)
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

pbaspect([1 1 1])

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
samples=25000;
Delta_r=(max(k)-min(k))/20;
Delta_theta=pi/20;
Delta_phi=pi/14;
muestra_r=min(k)+rand(samples,1)*(max(k)-Delta_r-min(k));
muestra_theta=rand(samples,1)*(pi-Delta_theta);
muestra_phi=rand(samples,1)*(2*pi-Delta_phi);

hits=zeros(samples,1);
volume=zeros(samples,1);

for contador=1:samples
    r_test=muestra_r(contador); % Must be between k_max and k_min
    theta_test=muestra_theta(contador); % Must be between 0 an pi
    phi_test=muestra_phi(contador); % Must be between 0 an 2*pi
    
    j=1;
    for i=1:length(k)
        if((k(i)>=r_test)&&(k(i)<=r_test+Delta_r))
            if((k(i)*theta(i)>=r_test*theta_test)&&(k(i)*theta(i)<=r_test*(theta_test+Delta_theta)))
                %if(((k(i)*sin(theta(i))*phi(i))>=(r_test*sin(theta_test)*phi_test))&&((k(i)*sint(theta(i))*phi(i))<=(r_test*sin(theta_test)*(phi_test+Delta_phi))))
                if((k(i)*sin(theta(i))*phi(i)>=r_test*sin(theta_test)*phi_test)&&(k(i)*sin(theta(i))*phi(i)<=r_test*sin(theta_test)*(phi_test+Delta_phi)))
                    sample(j,1)=A(i,1);
                    sample(j,2)=A(i,2);
                    sample(j,3)=A(i,3);
                    j=j+1;
                end
            end
        end
    end
    if j==1
        hits(contador)=0;
    else
        hits(contador)=size(sample,1);
    end
    volume(contador)=(r_test^2)*sin(theta_test)*Delta_r*Delta_theta*Delta_phi;
    clear sample
end
figure
stem(1:samples,hits./volume,'LineStyle','none')
figure
nbins=10000;
h=hist(hits./volume,nbins);
%h=h/max(h);
ang=linspace(min(hits),max(hits),nbins);
bar(ang,h);
grid on