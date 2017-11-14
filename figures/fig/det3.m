

figure

hold off

axis([0.5 5.5 0.5 3.5])

text(1,3,'a_{11}','FontSize',16)

hold on

text(2,3,'a_{12}','FontSize',16)
text(3,3,'a_{13}','FontSize',16)
text(1,2,'a_{21}','FontSize',16)
text(2,2,'a_{22}','FontSize',16)
text(3,2,'a_{23}','FontSize',16)
text(1,1,'a_{31}','FontSize',16)
text(2,1,'a_{32}','FontSize',16)
text(3,1,'a_{33}','FontSize',16)
text(4,1,'\bf{a_{31}}','FontSize',16)
text(4,2,'\bf{a_{21}}','FontSize',16)
text(4,3,'\bf{a_{11}}','FontSize',16)
text(5,1,'\bf{a_{32}}','FontSize',16)
text(5,2,'\bf{a_{22}}','FontSize',16)
text(5,3,'\bf{a_{12}}','FontSize',16)

plot([1 3],[3 1],'-')
plot([2 4],[3 1],'-')
plot([3 5],[3 1],'-')

plot([3 1],[3 1],'--')
plot([4 2],[3 1],'--')
plot([5 3],[3 1],'--')

axis off

print -deps2 det3.eps
