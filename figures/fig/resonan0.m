
t = linspace(0,20*pi,400);

x = cos(t);

% plot(t,x)


y = exp(-0.07*t).*(x - 0.07*sin(t));

 plot(t,y)


