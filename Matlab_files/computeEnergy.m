close all 
clear
clc

load PChar2.mat
spacing = 0.01;

polGrad = zeros(100,5000);
for i = 1:100
    polGrad(i,:) = (PChar2(i+1,:)-PChar2(i,:))/spacing;
end

energy=zeros(5000,1);

for i=1:5000
    energy(i) = trapz(polGrad(:,i).^2)*spacing;
end

figure
plot(polGrad(:,1000))
xlabel('x')
ylabel('p_{y,x}(x,1000)')

figure
plot(energy)
xlabel('t')
ylabel('\int|p_{y,x}(x,t)|^2dx')