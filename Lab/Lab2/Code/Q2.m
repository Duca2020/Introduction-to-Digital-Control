s=tf('s');
Gs = 1.12*exp(-s*0.2)/(0.8*s+1);
Gd = c2d(Gs,0.1,'zoh')
  


for k=1:9
    figure(k)
[y, t] = step(80*feedback(k*Gd,1), vec);

plot(t,y);

end