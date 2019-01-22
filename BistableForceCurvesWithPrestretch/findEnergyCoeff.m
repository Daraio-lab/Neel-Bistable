function [penergy, eq, pforce] = findEnergyCoeff(vertdist,orderPoly)
close all
clc

n=orderPoly;

displacementData = importdata(sprintf('CorotBeamBoundaryNodeDisplacement%.1f.txt',vertdist));
forceData = importdata(sprintf('CorotBeamBoundaryNodeForce%.1f.txt',vertdist));

expdisp = displacementData(2:length(displacementData));
expforce = -2*forceData(2:length(forceData));

p = polyfit(expdisp,expforce,n);
forcefit = polyval(p,expdisp);

r = roots(p);
eqmpoints = r(r==real(r));
eq = max(eqmpoints)-min(eqmpoints);
eqswitch = max(eqmpoints)-min(eqmpoints);
u = -0.1:0.001:eqswitch+0.2;
force = polyval(p,u);

pforce = polyfit(eqswitch-u,-force,n);

penergy = zeros(1,n+2);

for i = 1:n+1
   penergy(i) = pforce(i)/(n-i+2);    
end

figure(1)
plot(expdisp,expforce,expdisp,forcefit,u,-polyval(pforce,eqswitch-u))
legend('1','2','3')
energyfit = polyval(penergy,expdisp);

figure(2)
plot(expdisp,energyfit)

fid = fopen(sprintf('Coefficients%.1f.txt',vertdist),'w');
fprintf(fid,'%g \n', fliplr(penergy));
fclose(fid);

fid = fopen(sprintf('Eqmpoint%.1f.txt',vertdist),'w');
fprintf(fid,'%g \n', eq);
fclose(fid);

end