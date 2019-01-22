function speed = getSpeed(data,fps)

disp = 0.5*data(1,1);
[~,inx1] = min(abs(data(60,:)-disp));
[~,inx2] = min(abs(data(90,:)-disp));

t1 = inx1(1);
t2 = inx2(1);

idx = zeros(length(data(1,t1:t2)),1);

for i = t1:t2
   [idx(i-t1+1),idx(i-t1+1)] = min(abs(data(:,i)-disp));
end
time = (1/fps)*(t1:t2);
d = 10^-3; % Jordan gave this value % mean(diff(file(:,1,1)));

p = polyfit(time,d*idx',1);

fit = polyval(p,time);

% plot(time,fit,time,d*idx)
% figure
% plot(idx)

speed = p(1); % in m/s
end