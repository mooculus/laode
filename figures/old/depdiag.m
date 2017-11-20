os = 0.15;
hold off

box(5,17,1);

hold on

box(3,15,2);

swarrow(5,17,3,15) %connects 1 to 2

box(7,15,3);

searrow(5,17,7,15) %connects 1 to 3

box(5,13,4);

searrow(3,15,5,13)  %connects 2 to 4
swarrow(7,15,5,13)  %connects 3 to 4

box(5,11,5);

text(5.8,12.4,'\downarrow') %connects 4 to 5

box(3,9,6);

swarrow(5,11,3,9) %connects 5 to 6

box(3,7,7);

text(3.8,8.4,'\downarrow') %connects 6 to 7

box(3,5,11);

text(3.8,6.4,'\downarrow') %connects 7 to 11

box(0,5,12);

text(2.3,5.5,'\leftarrow')  %connects 11 to 12

box(3,3,14);

text(3.8,4.4,'\downarrow')  %connects 11 to 14

box(10,15,18);

text(9.3,15.5,'\rightarrow') %connects 3 to 18

box(7,9,8);

searrow(5,11,7,9) %connects 5 to 8

box(7,7,9);

text(7.8,8.4,'\downarrow') %connects 8 to 9
selongarrow(3,9,6-os,7) %connects 6 to 9

box(7,5,13);

swlongarrow(7,5,4+os,3) 	%connects 13 to 14
text(7.8,6.4,'\downarrow') %connects 9 to 13

box(7,3,15);

text(7.8,4.4,'\downarrow') %connects 13 to 15

box(10,3,16);

text(9.3,3.5,'\rightarrow') %connects 15 to 16

box(7,1,17);

text(7.8,2.4,'\downarrow') %connects 15 to 17

box(10,7,10);

text(9.3,7.5,'\rightarrow') %connects 9 to 10

axis([0 18 0 18])

axis off

print -deps2 depdiag.eps
