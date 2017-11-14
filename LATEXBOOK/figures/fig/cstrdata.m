y = linspace(-2,2);   
x = linspace(0,1);
z = zeros(1,100); 

plot(z,y) 
hold
plot(x,z)

p = y.*y/4; 

plot(p,y,':')      

ht1 = [-1.268 -0.9923; 2.245 1.457];
ht2 = [-1.458 -0.985; 2.74 1.41];
ht3 = [ -1.624 -0.9794; 3.163 1.368];
%ht4 = [-2.455 -0.9661; 5.205 1.178];
ht4 = [-1.033 -0.9998; 1.598 1.499]

htd = [0 0 0 0];

htt = [0 0 0 0];

htd(1) = det(ht1);
htd(2) = det(ht2);
htd(3) = det(ht3);
%htd(4) = det(ht4);
htd(4) = det(ht4)

htt(1) = trace(ht1);
htt(2) = trace(ht2);
htt(3) = trace(ht3);
%htt(4) = trace(ht4);
htt(4) = trace(ht4)

plot(htd,htt,'*')

lt1 = [-0.5083 -0.1879; 0.3977 -0.9313];
lt2 = [-0.5359 -0.214; 0.04769 -0.8781];
lt3 = [-0.564 -0.2427; 0.05703 -0.8169];
lt4 = [-0.5927 -0.2746; 0.06812 -0.7463];
lt5 = [-0.5138 -0.1929; 0.04125 -0.9212]
lt6 = [-0.5143 -0.1934; 0.0414 -0.9202]

ltd = [0 0 0 0 0 0];

ltt = [0 0 0 0 0 0];

ltd(1) = det(lt1);
ltd(2) = det(lt2);
ltd(3) = det(lt3);
ltd(4) = det(lt4);
ltd(5) = det(lt5)
ltd(6) = det(lt6)

ltt(1) = trace(lt1);
ltt(2) = trace(lt2);
ltt(3) = trace(lt3);
ltt(4) = trace(lt4);
ltt(5) = trace(lt5)
ltt(6) = trace(lt6)

plot(ltd,ltt,'o')

mt1 = [-0.8576 -0.9875; 1.013 1.442];
mt2 = [-0.823 -0.9684; 0.8341 1.36];
mt3 = [-0.8097 -0.9459; 0.7192 1.268];
mt4 = [-1 -1 ; 1.5 1.5]
mt5 = [-0.9699 -0.9997; 1.408 1.499]

mtd = [0 0 0 0 0];

mtt = [0 0 0 0 0];

mtd(1) = det(mt1);
mtd(2) = det(mt2);
mtd(3) = det(mt3);
mtd(4) = det(mt4)
mtd(5) = det(mt5)

mtt(1) = trace(mt1);
mtt(2) = trace(mt2);
mtt(3) = trace(mt3);
mtt(4) = trace(mt4)
mtt(5) = trace(mt5)

plot(mtd,mtt,'x')

xlabel('determinant')
ylabel('trace')

hold



