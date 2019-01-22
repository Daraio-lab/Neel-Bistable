for n = 1:200
   e = eigenvalues(n);
   x = (1:n)/n;
   hold on
   plot(x,sqrt(e),'*')
   axis([0,1,0,2])
   pause(0.001)
end