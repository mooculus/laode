t = linspace(0,50*pi,400);

x = cos(2*t);

% plot(t,x)

a = 2.05;

z = x + (cos(a*t)-x)/(4-a^2); 

plot(t,z)

axis([0,140,-40,40])

y = x + t.*cos(2*t)/4;

%plot(t,y)

