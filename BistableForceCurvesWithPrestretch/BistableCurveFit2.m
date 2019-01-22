% displacements
clear 
close all
clc

vertdist = 14.5:0.1:19;
u = -1:0.01:7.5;
eq = zeros(length(vertdist),1);

figure
for i = 1:length(vertdist)
   [penergy,eq(i),pforce]=findEnergyCoeff2(vertdist(i),7);
   hold on
   plot(u,polyval(penergy,u))
end
hold off

figure
plot(eq)
axis([0,50,0,8])