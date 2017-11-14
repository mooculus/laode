t=linspace(0,25,250);
x=exp(-t/2).*(0.5+1.5*t+t.*t);
plot(t,x)
hold
xlabel('t')
ylabel('x')

