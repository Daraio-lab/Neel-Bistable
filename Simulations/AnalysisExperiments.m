%% Experimental results from Jordan
clear all
close all
clc

load('C:\Users\Neel\Dropbox\Research_Neel\Harvard Katia collaboration\150304completedata.mat')

for i = 1:length(Ang30CompStartofchainLtorTest1Coords(1,1,:))
    data(:,i) = Ang30CompStartofchainLtorTest1Coords(:,1,i)-Ang30CompStartofchainLtorTest1Coords(:,1,1);
end

coord = Ang30CompStartofchainLtorTest1Massnums;

for i = 1:189/3;
%     plot(coord',data(:,10*i)-data(:,10*i-1))
    plot(Ang24TensionEndofchainLtorTest3Massnums,Ang24TensionEndofchainLtorTest3Coords(:,1,3*i)-Ang24TensionEndofchainLtorTest3Coords(:,1,1),'-o')
    axis([60,100,-8,2])
    pause(0.1)
end


plot(Ang24TensionEndofchainLtorTest3Massnums,Ang24TensionEndofchainLtorTest3Coords(:,1,50)-Ang24TensionEndofchainLtorTest3Coords(:,1,1),'-o')
