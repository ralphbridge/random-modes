clear all
clc
%Prueba comentario
format long
fileID = fopen('k-vectors-1M.txt','r');
formatSpec = '%e, %e, %e, %e;';
sizeA = [4 Inf];
A = fscanf(fileID,formatSpec,sizeA);
A=A';
fclose(fileID);

k=A(:,1);
theta=A(:,2);
phi=A(:,3);
nbins = 100;

% histogram(theta,nbins)
x=k.*sin(theta).*cos(phi);
y=k.*sin(theta).*sin(phi);
z=k.*cos(theta);
% stem3(x,y,z,'.','LineStyle','none','MarkerSize',1,'color','r')
% xlabel('$k_x$','Interpreter','latex','FontSize',15)
% ylabel('$k_y$','Interpreter','latex','FontSize',15)
% zlabel('$k_z$','Interpreter','latex','FontSize',15)
% pbaspect([1 1 1])
figure
j=1;
for i=1:length(k)
    if(abs(x(i))<max(k)/20)
        yproy(j)=y(i);
        zproy(j)=z(i);
        j=j+1;
    end
end
set(gcf,'renderer','Painters')
xlabel('$k_y$','Interpreter','latex','FontSize',15)
ylabel('$k_z$','Interpreter','latex','FontSize',15)
pbaspect([1 2 1])
grid on
figure
h=hist(theta,nbins);
h=h/max(h);
ang=linspace(min(theta),max(theta),nbins);
bar(ang,h);
grid on
hold on
plot(linspace(0,pi,1000),sin(linspace(0,pi,1000)),'LineWidth',1)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold off
% cuantos=25000;
% Delta_r=(max(k)-min(k))/30;
% Delta_theta=pi/30;
% Delta_phi=pi/20;
% muestra_r=min(k)+rand(cuantos,1)*(max(k)-Delta_r-min(k));
% muestra_theta=rand(cuantos,1)*(pi-Delta_theta);
% muestra_phi=rand(cuantos,1)*(2*pi-Delta_phi);
% 
% hits=zeros(cuantos,1);
% volume=zeros(cuantos,1);
% 
% for contador=1:cuantos
%     r_test=muestra_r(contador); % Must be between k_max and k_min
%     theta_test=muestra_theta(contador); % Must be between 0 an pi
%     phi_test=muestra_phi(contador); % Must be between 0 an 2*pi
%     
%     j=1;
%     for i=1:length(k)
%         if((k(i)>=r_test)&&(k(i)<=r_test+Delta_r))
%             if((k(i)*theta(i)>=r_test*theta_test)&&(k(i)*theta(i)<=r_test*(theta_test+Delta_theta)))
%                 %if(((k(i)*sin(theta(i))*phi(i))>=(r_test*sin(theta_test)*phi_test))&&((k(i)*sint(theta(i))*phi(i))<=(r_test*sin(theta_test)*(phi_test+Delta_phi))))
%                 if((k(i)*sin(theta(i))*phi(i)>=r_test*sin(theta_test)*phi_test)&&(k(i)*sin(theta(i))*phi(i)<=r_test*sin(theta_test)*(phi_test+Delta_phi)))
%                     sample(j,1)=A(i,1);
%                     sample(j,2)=A(i,2);
%                     sample(j,3)=A(i,3);
%                     j=j+1;
%                 end
%             end
%         end
%     end
%     if j==1
%         hits(contador)=0;
%     else
%         hits(contador)=size(sample,1);
%     end
%     volume(contador)=(r_test^2)*sin(theta_test)*Delta_r*Delta_theta*Delta_phi;
%     clear sample
% end
% figure
% stem(1:cuantos,hits./volume,'LineStyle','none')
% figure
% nbins=10000;
% h=hist(hits./volume,nbins);
% %h=h/max(h);
% ang=linspace(min(hits),max(hits),nbins);
% bar(ang,h);
% grid on