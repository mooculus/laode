hold off



plot([-1,1],[1.1,1.1],'--')
hold

x1 = 0: .01 : 0.7;   
z = x1.^2; 
plot(z,x1,'.') 
r=.02;
xx = 0.49 + r*cos(q);
yy = 0.7  + r*sin(q);
fill(xx,yy,'b')

plot([-1,0],[0,0],'-') 
plot([ 0,1],[0,0],'--')
q = 0:.01:2*pi;
r=.02;
xx = r*cos(q);
yy = r*sin(q);
fill(xx,yy,'b')

axis([-1 1 -0.5 1.6]) 
axis off
xlabel('\rho','FontSize',16)

text(1.03,0,'\rho','FontSize',16)
text(-.08,-0.1,'\rho = 0','FontSize',16)
text(-0.7,-0.1,'spiral sink','FontSize',14)
text( 0.3,-0.1,'spiral source','FontSize',14)
text(0.54, 0.7, 'homoclinic bifurcation','FontSize',14)
text(-0.4, 1., 'saddle','FontSize',14)
text(0, 0.4, 'stable limit cycles','FontSize',14)
text(-0.2,0.1,'Hopf bifurcation','FontSize',14)

print -deps2 homobifdiag.eps
