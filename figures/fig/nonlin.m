x=linspace(-1,2,100);
y = 4*x;          
y1=x+3;           
y2=4*x.*x;  
plot(x,y,'-')
hold
plot(x,y1,':')       
plot(x,y2,'--')
text(1.4,5.8,'y=4x')
text(0,3.2,'y=x+3')
text(1.5,9.5,'y=4x^2')
xlabel('x')
ylabel('y')

