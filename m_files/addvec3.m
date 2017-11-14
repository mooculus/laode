function addvec3(x,y)
%
%ADDVEC3  Illustrate the sum x + y of 3-dimensional vectors.
%
%       addvec3(x,y) displays a plot of x + y
%       and is adapted from addvec.m

%       Written by M. Golubitsky on 21 March 1995

x=x(:);     y=y(:);      % Ensure that both are vectors of length three
if (length(x)~=3) | (length(y)~=3)
  error('Both x and y must be vectors of length three')
end

xxyy = x + y;

hold off

clf

xxyyscale1 = max([abs(x)]);
xxyyscale2 = max([abs(y)]);
xxyyscale3 = max([abs(xxyy)]);
xxyyscale = 1.1*max([xxyyscale1 xxyyscale2 xxyyscale3]);


fill3([0 x(1) xxyy(1) y(1)],[0, x(2) xxyy(2) y(2)],[0 x(3) xxyy(3) y(3)],'c')

hold on


plot3([0 x(1)],[0, x(2)],[0 x(3)],'b-',...
    [0 y(1)],[0, y(2)],[0 y(3)],'b-',...
    [0 xxyy(1)],[0, xxyy(2)],[0 xxyy(3)],'b-')
axis([-xxyyscale xxyyscale -xxyyscale xxyyscale])

xys=1.09;
text(xys*x(1),xys*x(2),xys*x(3),'x')
text(xys*y(1),xys*y(2),xys*y(3),'y')
text(xys*xxyy(1),xys*xxyy(2),xys*xxyy(3),'x+y')
text(0,0,0,'0')

plot3([y(1) xxyy(1)],[y(2) xxyy(2)],[y(3) xxyy(3)],':')
plot3([x(1) xxyy(1)],[x(2) xxyy(2)],[x(3) xxyy(3)],':')

butt = uicontrol('style','push','units','normal',...
                'pos',[0.91 0.44 0.08 0.06],...
                'string','Quit','call','close(1)');

rotate3d on;

hold off

