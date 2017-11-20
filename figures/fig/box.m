function f = box(x,y,n)

plot([x x+2 x+2 x x], [y y y+1 y+1 y],'-')

text(x+0.8,y+0.5, num2str(n))