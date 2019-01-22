%% Analyze displacements
% Unit system: [gm mm ms]
clc
clear all
close all

bistable = [24 30 47];
stiffness = [30 50 100 200 400 800 1000 1500 2100];

velocityp1 = zeros(length(bistable),length(stiffness));
widthp1 = zeros(length(bistable),length(stiffness));

velocityp01 = zeros(length(bistable),length(stiffness));
widthp01 = zeros(length(bistable),length(stiffness));

for i = 1:length(bistable)
    for j = 1:length(stiffness)

        data1 = importdata(sprintf('Bistable%ddegreesStiffness%dGammap1.txt',bistable(i),stiffness(j)));

        x = 0:length(data1(:,1))-1;
        timestep = 0.01;
        t = timestep*(0:length(data1(1,:))-1);

        [velocityp1(i,j), widthp1(i,j)] = EnergyWidth(data1,timestep,5000,6000);
    end
end

plottype = ['b*-' 'm^-' 'r+-'];

figure
hold on
for i = 1:length(bistable)
    plot(stiffness,velocityp1(i,:),sprintf('%c%c%c',plottype(1+3*(i-1)),plottype(2+3*(i-1)),plottype(3+3*(i-1))))
end
hold off
set(gca,'fontsize', 24);
xlabel('stiffness (N/m)')
ylabel('velocity (m/s)')
legend('angle = 24^o','angle = 30^o','angle = 47^o')

figure
hold on
for i = 1:length(bistable)
    plot(stiffness,widthp1(i,:),sprintf('%c%c%c',plottype(1+3*(i-1)),plottype(2+3*(i-1)),plottype(3+3*(i-1))))
end
hold off
set(gca,'fontsize', 24);
xlabel('stiffness (N/m)')
ylabel('width (number of elements)')
legend('angle = 24^o','angle = 30^o','angle = 47^o')


for i = 1:length(bistable)
    for j = 1:length(stiffness)

        data2 = importdata(sprintf('Bistable%ddegreesStiffness%d.txt',bistable(i),stiffness(j)));

        x = 0:length(data2(:,1))-1;
        timestep = 0.01;
        t = timestep*(0:length(data2(1,:))-1);

        [velocityp01(i,j), widthp01(i,j)] = EnergyWidth(data2,timestep,2000,3000);
    end
end

plottype = ['b*-' 'm^-' 'r+-'];

figure
hold on
for i = 1:length(bistable)
    plot(stiffness,velocityp01(i,:),sprintf('%c%c%c',plottype(1+3*(i-1)),plottype(2+3*(i-1)),plottype(3+3*(i-1))))
end
set(gca,'fontsize', 24);
hold off
xlabel('stiffness (N/m)')
ylabel('velocity (m/s)')
legend('angle = 24^o','angle = 30^o','angle = 47^o')

figure
hold on
for i = 1:length(bistable)
    plot(stiffness,widthp01(i,:),sprintf('%c%c%c',plottype(1+3*(i-1)),plottype(2+3*(i-1)),plottype(3+3*(i-1))))
end
hold off
set(gca,'fontsize', 24);
xlabel('stiffness (N/m)')
ylabel('width (number of elements)')
legend('angle = 24^o','angle = 30^o','angle = 47^o')

% figure
% step = 50;
% for n = 1:length(t)/(step)
%     plot(x,data(:,step*n))
%     ylabel('Displacements')
%     xlabel('Nodal positions')
%     axis([0,100,-0.01,12])
%     pause(0.0001)
% end

% figure
% contourf(x,t,data')
% xlabel('Nodal positions')
% ylabel('Time')
