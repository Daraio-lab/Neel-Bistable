d = 18.9;

data1 = importdata(sprintf('CorotBeamBoundaryNodeDisplacement%.1f.txt',d));
data2 = importdata(sprintf('CorotBeamBoundaryNodeForce%.1f.txt',d));
data3 = importdata(sprintf('CorotBeamDisplacements%.1f.txt',d));
displacement = data1(2:length(data1));
force = data2(2:length(data2));

plot(displacement,-2*force)