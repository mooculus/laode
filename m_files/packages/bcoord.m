%

A = [w1' w2'];

clf

xmin = min([w1(1) w2(1)]);
xmax = max([w1(1) w2(1)]);
xm = 2*max([abs(xmin) abs(xmax)]);
 
ymin = min([w1(2) w2(2)]);
ymax = max([w1(2) w2(2)]);
ym = 2*max([abs(ymin) abs(ymax)]);
 

if det(A) == 0
	error('w1 and w2 do not form a basis')
end

plot([0 w1(1)], [0,w1(2)])
hold
plot([0 w2(1)], [0,w2(2)])

axis([-xm xm -ym ym])
grid

title('Coordinates in the {w1,w2} basis')

text(1.05*w1(1),1.05*w1(2),'w1')
text(1.05*w2(1),1.05*w2(2),'w2')

v = ginput(1)
text(1.05*v(1),1.05*v(2),'v')

plot([0 v(1)], [0,v(2)],'y')

alpha = inv(A)*v'

ww1=alpha(1)*w1;
ww2=alpha(2)*w2;

plot([0,ww1(1)],[0,ww1(2)],'c')
plot([0,ww2(1)],[0,ww2(2)],'c')
plot([ww1(1) v(1)],[ww1(2) v(2)],'c')
plot([ww2(1) v(1)],[ww2(2) v(2)],'c')

aa1=num2str(alpha(1));
aa2=num2str(alpha(2));
text(ww1(1)/2,ww1(2)/2,aa1)
text(ww2(1)/2,ww2(2)/2,aa2)

title('Coordinates in the {w1,w2} basis')
