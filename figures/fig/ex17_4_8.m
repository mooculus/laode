function f = ex17_4_8(t,x)
A = [0  1; -1  -(1+cos(t))];
f = A*x + [0; 0.4+exp(-t)*sin(t)];
