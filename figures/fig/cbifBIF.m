hold off
x = -2.5:.05:-1.0;
rho = x.^3 - 3*x;
plot(rho,x)
hold
x1 = -1.0:.05:1.0;
rho1 = x1.^3 - 3*x1;
plot(rho1,x1,'--')
x2 = 1.0:.05:2.5;
rho2 = x2.^3 - 3*x2;
plot(rho2,x2)
plot([-8.2,8.2],[0,0],':') 
plot([0,0],[-2.6,2.6],':')
text(-0.4,2.7,'x','FontSize',16)
text(8.5,0,'\rho','FontSize',16)
xlabel('\rho','FontSize',16)
ylabel('x','FontSize',16)
print -deps2 cbifBIF.eps

