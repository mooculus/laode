function f = ex17_4_7(t,x)
A = [0  1; -1  -(1+sin(t))];
f = A*x + [0; sin(2*t)];
