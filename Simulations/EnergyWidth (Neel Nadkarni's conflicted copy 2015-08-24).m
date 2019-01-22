function [vel, width] = EnergyWidth(displacements,timestep,t1,t2)

time = timestep*(0:length(displacements(1,:))-1);
A = max(max(displacements));

index1 = zeros(1,length(displacements(1,:)));
index2 = zeros(1,length(displacements(1,:)));

for k=1:length(index1)
    [~, idx1] = min(abs(displacements(:,k)-1.9));
    [~, idx2] = min(abs(displacements(:,k)-0.9*A));
    index1(k) = idx1;
    index2(k) = idx2;
end

p = polyfit(time(t1:t2),index1(t1:t2),1);
vel = p(1);
width = round(mean(index1(t1:t2)-index2(t1:t2)));

end