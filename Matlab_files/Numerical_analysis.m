% clear all
close all
clc

stiffness = 60:50:2110;
angle = [22,26,32,47];
vel = zeros(length(stiffness),length(angle));
width = zeros(length(stiffness),length(angle));
d = [13.2,13.2,13.2,8.2];

for j = 1:length(angle)
    for i = 1:length(stiffness)
        data = importdata(sprintf('../newResultsAugust/%ddegrees/BistableCompressive%ddegreesStiffness%dGamma0.04757.txt',... 
            angle(j),angle(j),stiffness(i)));
        vel(i,j) = getSpeed(data,10000)*d(j);
        width(i,j) = getWidth(data);
    end
end

save velocity.mat vel
save width.mat width

figure
plot(stiffness,vel,'o-','LineWidth',2)
set(gca,'FontSize',20)
xlabel('stiffness (N/m)','FontSize',20)
ylabel('velocity (m/s)','FontSize',20)
legend('angle 22.2^o','angle 26.3^o','angle 32.3^o','angle 47.1^o')

figure
plot(stiffness,width,'o-','LineWidth',2)
set(gca,'FontSize',20)
xlabel('stiffness (N/m)','FontSize',20)
ylabel('width (particles)','FontSize',20)
legend('angle 22.2^o','angle 26.3^o','angle 32.3^o','angle 47.1^o')