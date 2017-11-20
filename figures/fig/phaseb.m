hold off



plot([-3,3],[0,0])
hold

r=.02;
q = 0:.01:2*pi;
xx = -2 + r*cos(q);
yy =  r*sin(q);
plot(xx,yy)
fill(xx,yy,'b')

xx = -0.7 + r*cos(q);
yy =  r*sin(q);
plot(xx,yy)
fill(xx,yy,'b')

xx = 0.5 + r*cos(q);
yy =  r*sin(q);
plot(xx,yy)
fill(xx,yy,'b')

xx = 2 + r*cos(q);
yy = r*sin(q);
fill(xx,yy,'b')

a = -2.5;
plot([a-0.1,a],[0.05, 0])
plot([a-0.1,a],[-0.05, 0])

a = -0.2;
plot([a-0.1,a],[0.05, 0])
plot([a-0.1,a],[-0.05, 0])

a = 2.5;
plot([a-0.1,a],[0.05, 0])
plot([a-0.1,a],[-0.05, 0])

a = -1.4;
plot([a+0.1,a],[0.05, 0])
plot([a+0.1,a],[-0.05, 0])

a = 1.0;
plot([a+0.1,a],[0.05, 0])
plot([a+0.1,a],[-0.05, 0])

axis([-3 3 -1 1]) 
axis off
xlabel('x')

text(-2.15,-0.1,'-2')
text(-0.9,-0.1,'-0.7')
text(0.4,-0.1,'0.5')
text(1.95,-0.1,'2')


print -deps2 phaseb.eps
