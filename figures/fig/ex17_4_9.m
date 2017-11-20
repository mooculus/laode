function f = ex17_4_9(t,x)
A = [0  1; -1  -(0.02+sin(t))];
f = A*x + [0; 1];