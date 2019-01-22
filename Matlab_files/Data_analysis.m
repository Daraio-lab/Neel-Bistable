%% plot of experimental wave velocities
clear all
close all
clc

load('../Jordan_data/rawdata.mat');

fps = 500; % 500 frames per second acquisition

data = getData(ang26p3);
node = 1:length(data(:,1));
time = (1:length(data(1,:)))/fps;

speed = getSpeed(data,fps,70,140);

figure
contourf(node,time,data')
xlabel('Mass number')
ylabel('Time (s)')

n=1;
% figure
% for i = 1:floor(length(data(1,:))/n)
%     plot(data(:,n*i))
%     axis([1,50,-1,6])
%     pause(0.05)    
% end