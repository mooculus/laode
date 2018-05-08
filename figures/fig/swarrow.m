function f = swarrow(x1,y1,x2,y2)

ang = pi/6;
 sw = -pi/4;

r =0.2;
offset = 0.15;
plot([x1-offset x2+1+offset], [y1-offset y2+1+offset],'-')
plot([x2+1+offset  x2+1+offset+r*cos(sw+ang)], [y2+1+offset y2+1+offset-r*sin(sw+ang)],'-')
plot([x2+1+offset  x2+1+offset+r*cos(sw-ang)], [y2+1+offset y2+1+offset-r*sin(sw-ang)],'-')
