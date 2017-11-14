t = linspace(0.62,5.2);  
y = 1./t; 
x = (1- y.*y).*y; 
plot(t,x) 

axis([0.6 5.2 -0.55 0.55])


print -deps2 solnm.eps

