close all
clear all
clc

d = 14.5:0.1:19.0;
barrier = zeros(1,length(d));
energyDiff = zeros(1,length(d));
coefficients = zeros(9,length(d));
x=-1:0.001:7.5;
Vxd = zeros(length(x),length(d));
    
for i = 1:length(d)
    coefficients(:,i) = importdata(sprintf('Coeff%.1f.txt',d(i)));
    eqpoint = importdata(sprintf('Eqmpt%.1f.txt',d(i)));
    e = polyval(fliplr(coefficients(:,i)'),x);
    Vxd(:,i) = e;
    plot(x,e);
    axis([-1,9,0,1])
    energyDiff(i) = -polyval(fliplr(coefficients(:,i)'),eqpoint);
    barrier(i) = max(e)-e(length(x));
    pause(0.1)
end

figure
plot(d,barrier,'LineWidth',2)
set(gca,'FontSize',18)
xlabel('d in mm')
ylabel('energy barrier in mJ')

figure
plot(d,energyDiff,'LineWidth',2)
set(gca,'FontSize',18)
xlabel('d in mm')
ylabel('energy difference in mJ')

save('potentialLandscape.mat','x','d','Vxd')