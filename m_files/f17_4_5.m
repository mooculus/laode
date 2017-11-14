function f = f17_4_5(t,x)
A = [0  1; -1  -(1+cos(t))];
f = A*x + [0; 1];