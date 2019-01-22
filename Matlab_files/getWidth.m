function w = getWidth(data)
    
[~,inx1] = min(abs(data(50,:)-data(1,1)/2));
[~,w1] = min(abs(data(:,inx1)-0.1*data(1,1)));
[~,w2] = min(abs(data(:,inx1)-0.9*data(1,1)));
w = abs(w2-w1);

end