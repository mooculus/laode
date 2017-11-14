
hold off

x1 = -1: .01 : 0;   
x2 = 0 : .01 : 1; 
y = zeros(size(x1));
z = x2.^2; 
plot(z,x2,'--.') 
hold
plot(x1,y,'-') 
plot(x2,y,'--') 
axis([-1 1 -1 1]) 
xlabel('rho')
ylabel('|X|')
