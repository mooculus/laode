hold off



plot([-2,2],[0,0])
hold

r=.02;
q = 0:.01:2*pi;
xx = -1 + r*cos(q);
yy =  r*sin(q);
plot(xx,yy)
fill(xx,yy,'b')


xx = 1 + r*cos(q);
yy = r*sin(q);
fill(xx,yy,'b')

a = -1.5;
plot([a-0.1,a],[0.05, 0])
plot([a-0.1,a],[-0.05, 0])
a = 1.5;
plot([a-0.1,a],[0.05, 0])
plot([a-0.1,a],[-0.05, 0])
a = 0;
plot([a+0.1,a],[0.05, 0])
plot([a+0.1,a],[-0.05, 0])

axis([-2 2 -1 1]) 
axis off
xlabel('x')

text(-1.1,-0.1,'-1')
text(1.0,-0.1,'1')

print -deps2 phasea.eps
