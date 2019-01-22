% Bistable force plot
close all
clc

load('../Jordan_data/bistablepair.mat');

n = 7;
d = [18.6,18,17.5,16.7];
angle = [22, 26, 32, 34];
penergy = zeros(length(angle),n+2);
pforce = zeros(length(angle),n+1);
eq = zeros(length(angle),1);

for i = 1:length(angle)
    [polyen,eq(i),polyf] = findEnergyCoeff(angle(i),n);
    penergy(i,:) = polyen;
    pforce(i,:) = polyf;
end

for i = 1:n+1
    penergy(:,i) = penergy(:,i).*(eq.^(n+2-i));
    pforce(:,i) = pforce(:,i).*(eq.^(n+1-i));
end

u = -0.1:0.001:1.1;
figure
plot(u,polyval(penergy(1,:),u),u,polyval(penergy(2,:),u),...
    u,polyval(penergy(3,:),u),u,polyval(penergy(4,:),u))
axis([-0.1,1.1,-1,2])

figure
plot(u,polyval(pforce(1,:),u),u,polyval(pforce(2,:),u),...
    u,polyval(pforce(3,:),u),u,polyval(pforce(4,:),u))
axis([-1,2,-1,2])


for i = 1:n
    figure
    plot(d,penergy(:,i),'-o')
    xlabel('d in mm')
    ylabel(strcat('C_',num2str(n+2-i),'(d)'))
    set(gca,'FontSize',20)
    % print(strcat('variationC_',num2str(n+2-i)),'-dpdf')
end

figure
plot(d,eq,'-o')
xlabel('d in mm')
ylabel('eq(d) in mm')
set(gca,'FontSize',20)
% print('variationEq','-dpdf')