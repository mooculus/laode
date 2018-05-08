% start with a clean slate
clf
axis([0 10 0 10])
hold on
% initially the list of points is empty.
x = [];
y = [];
n = 0;
% loop, picking up the points.
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
but = 1;
while but == 1
	[xi,yi,but] = ginput(1);
	plot(xi,yi,'go')
	n = n+1;
	x(n,1) = xi;
	y(n,1) = yi;
end
% Interpolate with two splines and finer spacing.
t = 1:n;
ts = 1: 0.1: n;
xs = spline(t,x,ts);
ys = spline(t,y,ts);
% Plot the interpolated curve.
plot(xs,ys,'c-');
hold off
