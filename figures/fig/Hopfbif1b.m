hold off
  
x = 0 : .01 : 0.7; 
z = 2*x.^2; 
plot(z-1,x,'-.') 
hold
 
plot([-2.0 -1.0],[0 0],'--') 
plot([-1.0    0],[0 0],'-')

q = 0:.01:2*pi;
r=.03;
xx = r*cos(q)-1;
yy = r*sin(q);
fill(xx,yy,'b')

xlabel('\rho','FontSize',16)
text(0.03,0,'\rho','FontSize',16)
text(-0.6,0.6,'limit cycles','FontSize',16)

plot(-z+2,x,'.') 
 
plot([1.0 2.0],[0 0],'--') 
plot([2.0 3.0],[0 0],'-')

q = 0:.01:2*pi;
r=.03;
xx = r*cos(q)+2;
yy = r*sin(q);
fill(xx,yy,'b')

axis([-2 3 -0.25 1.2]) 

xlabel('\rho','FontSize',16)
text(3.03,0,'\rho','FontSize',16)
text(0.8,0.6,'limit cycles','FontSize',16)

axis off

print -deps2 Hopfbif1b.eps
