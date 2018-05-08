clf
hold off

x = -2:.02:2;
y = abs(1-x).*abs(1+x)/2;
plot(x,y)
hold on
plot(x,-y)

print -deps2  fig14-7-11.eps