function data = getData(file)

data = zeros(length(file(:,1,1)),length(file(1,1,:)));

for i = 1:length(file(1,1,:))
    data(:,i) = file(:,1,i)-file(:,1,1);
end

end