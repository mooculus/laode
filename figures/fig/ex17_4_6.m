function f = ex17_4_6(t,x)
A = [0  1; -1  -(1+cos(5*t))];
f = A*x + [0; 1];