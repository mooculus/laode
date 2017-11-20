hold off
x = 0:.05:2;
rho = x.*x;
plot(rho,x)
hold
x1=-2:.05:1;
rho1 = x1.*x1;
plot(rho1,x1,'--')
plot([-3,4.1],[0,0],':') 
plot([0,0],[-2.1,2.1],':')
xlabel('\rho','FontSize',16)
ylabel('x','FontSize',16)
text(4.2,0,'\rho','FontSize',16)
text(-0.05,2.3,'x','FontSize',16')
print -deps2 sbifBIF.eps

