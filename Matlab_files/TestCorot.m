% corotational beam deformation
close all
clc

angle = [22.2,26.3,32.3];
order = 5;
numericalForceFit = zeros(length(angle),order+1);

load('../Jordan_data/bistablepair.mat');

for j = 1:length(angle)

data = importdata(sprintf('CoRotBeamSimulationFiles/CorotBeamDisplacements%.1f.txt',angle(j)));
parameters = importdata(sprintf('CoRotBeamSimulationFiles/CorotBeamParameters%.1f.txt',angle(j))); 
L0 = 7;
theta0 = pi/2-parameters(3)*pi/180;
numberOfNodes = parameters(1);
xDisp = zeros(numberOfNodes,1);
yDisp = zeros(numberOfNodes,1);
thetaDisp = zeros(numberOfNodes,1);

expdisp = eval(sprintf('disp%.0fDeg',angle(j)));
expforce = eval(sprintf('force%.0fDeg',angle(j)));

for i = 0:numberOfNodes-1
    xDisp(i+1) = data(3*i+2);
    yDisp(i+1) = data(3*i+3);
    thetaDisp(i+1) = data(3*i+4);
end

xInit = (0:numberOfNodes-1)'*L0*cos(theta0)/numberOfNodes;
yInit = -(0:numberOfNodes-1)'*L0*sin(theta0)/numberOfNodes;
thetaInit = zeros(numberOfNodes,1);

xFin = (xInit+xDisp);
yFin = (yInit+yDisp);
thetaFin = thetaInit + thetaDisp;

figure
plot(xInit,yInit,xFin,yFin)
set(gca,'FontSize',20)
xlabel('X-coordinate in mm')
ylabel('Y-coordinate in mm')
legend('initial position','final position')

nodalDisplacement = importdata(sprintf('CoRotBeamSimulationFiles/CorotBeamBoundaryNodeDisplacement%.1f.txt',angle(j)));
nodalForce = importdata(sprintf('CoRotBeamSimulationFiles/CorotBeamBoundaryNodeForce%.1f.txt',angle(j)));

n = floor(length(nodalForce));

numericalForceFit(j,:) = polyfit(nodalDisplacement(2:n),-2*nodalForce(2:n),order);
figure
plot(nodalDisplacement(2:n),-6*nodalForce(2:n),expdisp,expforce)%nodalDisplacement(2:n),...
    %3*polyval(numericalForceFit(j,:),nodalDisplacement(2:n)),expdisp,expforce)

set(gca,'FontSize',20)
xlabel('Displacement in mm')
ylabel('Force in N')
legend('simulated force curve','experimental force curve') %'7th order polynomial fit'
end

% for k = 1:8
%     figure
%     plot(angle,numericalForceFit(:,k))
% end