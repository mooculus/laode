hold off

%Hopf bifurcation branch
x3 = 0:.01:0.4;
plot(1.58 + x3.^2, 2.9 + x3,'.')

hold on



%hopf bifurcation circle
q = 0:.01:2*pi;
r = 0.03;
xx = 1.58 + r*cos(q);
yy = 2.9  + r*sin(q);
fill(xx,yy,'b')
text(1.6,2.8,'Hopf','FontSize',12)


%homoclinic bifurcation circle
xx = 1.75 + r*cos(q);
yy = 3.3  + r*sin(q);
fill(xx,yy,'b')
text(1.8,3.3,'homoclinic','FontSize',12)

%low temperature diagram
x4 = 2.4:.02:3;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'-')

%saddle node bifurcation
xx = 2 + r*cos(q);
yy = 3-1.5  + r*sin(q);
fill(xx,yy,'b')
text(2.1,1.5,'saddle-node','FontSize',12)


%middle temperature branch 
x4 = 3:.02:4.4;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'--')

%saddle node bifurcation
xx = 1 + r*cos(q);
yy = 2.5  + r*sin(q);
fill(xx,yy,'b')
text(1.1,2.5,'saddle-node','FontSize',12)

%High temperature equilibrim
x4 = 4.4:.01:4.6;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'-')



aa=.1;
text(0.7-aa,0.3,'0.495','FontSize',12)
text(1.2-aa,0.3,'0.52','FontSize',12)
text(1.6-aa,0.3,'0.545','FontSize',12)
text(1.9-aa,0.3,'0.57','FontSize',12)
text(2.3-aa,0.3,'0.75','FontSize',12)
text(2.55,0.5,'\rho','FontSize',12)

plot([0 2.5], [0.5 0.5],':','LineWidth',2)

N=20;
y = linspace(0.5,4,N);
plot(0.7*ones(N),y,':','LineWidth',2)
plot(1.22*ones(N),y,':','LineWidth',2)
plot(1.67*ones(N),y,':','LineWidth',2)
plot(1.9*ones(N),y,':','LineWidth',2)
plot(2.3*ones(N),y,':','LineWidth',2)

axis([0.4 3 -0.1 3.5])
axis off

xlabel('\rho','FontSize',16)

print -deps2 cstrbif.eps