clf
hold off

x = -1:.02:2;
y = sqrt(x.*x.*(1+x));
plot(x,y)
hold on
plot(x,-y)

print -deps2  fig14-7-10.eps