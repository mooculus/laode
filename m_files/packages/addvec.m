function addvec(x,y)
%
%ADDVEC  Illustrate the sum x + y of 2-dimensional vectors.
%
%       addvec(x,y) displays a plot of x + y
%       following Figure 1.2 in G. Strang, 
%       "Introduction to Linear Algebra."

%       Written by T. A. Bryan on 2 June 1993
%	Adapted by M. Golubitsky on 21 March 1995


x=x(:);     y=y(:);      % Ensure that both are vectors of length two
if (length(x)~=2) | (length(y)~=2)
  error('Both x and y must be vectors of length two')
end

xxyy = x + y;

hold off

clf

xxyyscale1 = max([abs(x)]);
xxyyscale2 = max([abs(y)]);
xxyyscale3 = max([abs(xxyy)]);
xxyyscale = 1.1*max([xxyyscale1 xxyyscale2 xxyyscale3]);

plot([0 x(1)],[0, x(2)],'-',...
    [0 y(1)],[0, y(2)],'-',...
    [0 xxyy(1)],[0, xxyy(2)],'-')
hold on

butt = uicontrol('style','push','units','normal',...
                'pos',[0.91 0.44 0.08 0.06],...
                'string','Quit','call','close(1)');
axis([-xxyyscale xxyyscale -xxyyscale xxyyscale])
grid on

xysc=1.05;
text(xysc*x(1),xysc*x(2),'x')
text(xysc*y(1),xysc*y(2),'y')
text(xysc*xxyy(1),xysc*xxyy(2),'x+y')


plot([y(1) xxyy(1)],[y(2) xxyy(2)],':')
plot([x(1) xxyy(1)],[x(2) xxyy(2)],':')

hold off

