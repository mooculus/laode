function f = f14_6_1(t,x)
sigma = 10;
beta  = 8/3;
rho   = 28;
f     = [sigma*(x(2)-x(1));  
	rho*x(1)-x(2)-x(1)*x(3);
	-beta*x(3)+x(1)*x(2)];
