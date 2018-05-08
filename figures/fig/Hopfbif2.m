
hold off

  
x = 0 : .01 : 1; 

z = x.^2; 
plot(-z,x,'-.') 
hold
 
plot([-1 0],[0 0],'-') 
plot([ 0 1],[0 0],'--')

q = 0:.01:2*pi;
r=.02;
xx = r*cos(q);
yy = r*sin(q);
fill(xx,yy,'b')

axis([-1 1 -1 1]) 

xlabel('\rho','FontSize',16)
text(1.03,0,'\rho','FontSize',16)
text(-.04,-0.1,'\rho = 0','FontSize',16)

axis off

print -deps2 Hopfbifb.eps