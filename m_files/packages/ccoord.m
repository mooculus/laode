%


AAW = [w1' w2'];

AAZ = [z1' z2'];

xmin = min([w1(1) w2(1) z1(1) z2(1)]);
xmax = max([w1(1) w2(1) z1(1) z2(1)]);
xm = 1.5*max([abs(xmin) abs(xmax)]);

ymin = min([w1(2) w2(2) z1(2) z2(2)]);
ymax = max([w1(2) w2(2) z1(2) z2(2)]);
ym = 1.5*max([abs(ymin) abs(ymax)]);


if det(AAW) == 0
	error('w1 and w2 do not form a basis')
end

if det(AAZ) == 0
	error('z1 and z2 do not form a basis')
end

c1 = inv(AAW)*z1';
c2 = inv(AAW)*z2';

CWZ = [c1 c2]


w1c = w1(1) + w1(2)*i;
w2c = w2(1) + w2(2)*i;

z1c = z1(1) + z1(2)*i;
z2c = z2(1) + z2(2)*i;

figure(1)

clf

plot([0 w1(1)], [0,w1(2)])
hold
plot([0 w2(1)], [0,w2(2)])


axis([-xm xm -ym ym])

title('Coordinates in the {w1,w2} basis')

EX = 1.05
text(EX*w1(1),EX*w1(2),'w1')
text(EX*w2(1),EX*w2(2),'w2')

figure(2)

clf

plot([0 z1(1)], [0,z1(2)])
hold
plot([0 z2(1)], [0,z2(2)])


axis([-xm xm -ym ym])

title('Coordinates in the {z1,z2} basis')

text(EX*z1(1),EX*z1(2),'z1')
text(EX*z2(1),EX*z2(2),'z2')

figure(1)

v = ginput(1)

text(EX*v(1),EX*v(2),'v')

plot([0 v(1)], [0 v(2)])

alphaW = inv(AAW)*v'

ww1=alphaW(1)*w1;
ww2=alphaW(2)*w2;

plot([0,ww1(1)],[0,ww1(2)],'c')
plot([0,ww2(1)],[0,ww2(2)],'c')
plot([ww1(1) v(1)],[ww1(2) v(2)],'c')
plot([ww2(1) v(1)],[ww2(2) v(2)],'c')

aaW1=num2str(alphaW(1));
aaW2=num2str(alphaW(2));
text(ww1(1)/2,ww1(2)/2,aaW1)
text(ww2(1)/2,ww2(2)/2,aaW2)

title('Coordinates in the {w1,w2} basis')

figure(2)

text(EX*v(1),EX*v(2),'v')

plot([0 v(1)], [0 v(2)])

alphaZ = inv(AAZ)*v'

zz1=alphaZ(1)*z1;
zz2=alphaZ(2)*z2;

plot([0,zz1(1)],[0,zz1(2)],'c')
plot([0,zz2(1)],[0,zz2(2)],'c')
plot([zz1(1) v(1)],[zz1(2) v(2)],'c')
plot([zz2(1) v(1)],[zz2(2) v(2)],'c')

aaZ1=num2str(alphaZ(1));
aaZ2=num2str(alphaZ(2));
text(zz1(1)/2,zz1(2)/2,aaZ1)
text(zz2(1)/2,zz2(2)/2,aaZ2)

title('Coordinates in the {z1,z2} basis')


