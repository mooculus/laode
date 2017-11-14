hold off
plot([0,1],[0,0])
hold

h = 0.05;
plot([1+h,2],[0,0])
plot([1 1+h],[1/h 1/h])
axis([0,2,-5,25])
xlabel('t')
ylabel('g_h(t)')

print -deps2 deltah.eps
