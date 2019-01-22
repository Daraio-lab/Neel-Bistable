% Test
clear all
close all
clc

file = importdata('Bistable24degreesStiffness2200Gammap1.txt');

contourf(file)

[velocity, width] = EnergyWidth(file,0.01,3600,4000);

figure
plot(file(:,3000),'*-')