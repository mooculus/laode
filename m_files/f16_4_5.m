function y = f16_4_5(t,x)
   h = 0.01;
y(1) = x(2);
y(2) = -4*x(2)-5*x(1);
if (abs(t-(1-h/2)) <= h/2)
        y(2) = y(2)+1/h;
end
if (t >= 3)
        y(2) = y(2)+2;
end
y = [y(1) y(2)]';
