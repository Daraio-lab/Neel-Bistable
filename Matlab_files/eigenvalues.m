function e = eigenvalues(n)
    A = full(gallery('tridiag',n,-1,2,-1));
    A(1,1)=1; A(n,n)=1;
    e = eig(A);
end