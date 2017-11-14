plot([0 1], [0 0])
hold on
plot([0 0], [-1 1])
axis([-0.5 1 -1 1])

y = -1:.1:1;
plot(y.*y,y,'--')

text(-0.06, 0.9, 'd = 0','FontSize',16)
text( 0.65, 0.9, 'D = 0','FontSize',16)
text( 0.85, 0.05, 't = 0','FontSize',16)

text(0.3,-0.3,'spiral sink',  'FontSize',16)
text(0.3, 0.3,'spiral source','FontSize',16)

text(0.05,-0.7,'nodal sink',  'FontSize',16)
text(0.05, 0.7,'nodal source','FontSize',16)

text(-0.3, 0,'saddle','FontSize',16)

axis off

print -deps2 td.eps
hold off
