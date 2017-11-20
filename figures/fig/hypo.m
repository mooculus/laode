hold off

x1 = [0,1,2,3,4];
plot(x1,.1*x1,'-')

hold

x2 = [4, 5, 6, 7];

plot(x2,.1*x2,'--')

q = 0:.01:2*pi;
r = 0.03;
xx = 4 + r*cos(q);
yy = 0.4  + r*sin(q);
fill(xx,yy,'b')

x3 = 0:.01:.6;
plot(4-2.7778*x3.^2,0.4+x3,'-.')

%homoclinic
xx = 4-2.7778*0.6^2 + r*cos(q);
yy = 1  + r*sin(q);
fill(xx,yy,'b')

x4 = 2.3:.02:3;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'-')

xx = 2 + r*cos(q);
yy = 3-1.5  + r*sin(q);
fill(xx,yy,'b')

x4 = 3:.02:4;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'--')

xx = 1 + r*cos(q);
yy = 4-1.5  + r*sin(q);
fill(xx,yy,'b')

x4 = 4:.01:4.9108;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'-')

xx = 5 + r*cos(q);
yy = 4.9108-1.5  + r*sin(q);
fill(xx,yy,'b')

x4 = 4.9108:.01:5;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'--')

xx = 6 + r*cos(q);
yy = 5-1.5  + r*sin(q);
fill(xx,yy,'b')

x4 = 5:.01:5.1;
z4 = 2*x4.^3 - 21*x4.^2 + 72*x4 - 79;
plot(z4,x4-1.5,'-')

qq = -pi:.03:-0.12;
x = 5.5 + 0.5*cos(qq);
y = 4.9108-1.5 - 0.5*sin(qq);
plot(x,y,'.')



aa=.1;
text(1-aa,-0.7,'\rho_1','FontSize',16)
text(2-aa,-0.7,'\rho_2','FontSize',16)
text(3-aa,-0.7,'\rho_3','FontSize',16)
text(4-aa,-0.7,'\rho_4','FontSize',16)
text(5-aa,-0.7,'\rho_5','FontSize',16)
text(6-aa,-0.7,'\rho_6','FontSize',16)


axis([0 7 -1 4])
axis off

xlabel('\rho','FontSize',16)

print -deps2 hypo.eps
