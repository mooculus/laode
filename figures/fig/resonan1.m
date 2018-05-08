t = linspace(0,10*pi,400);

x = cos(2*t);

plot(t,x)
axis([0,35,-1.5,1.5])


%hold on 

a = 4.5;

z = x + (cos(a*t)-x)/(4-a^2); 

%plot(t,z)


