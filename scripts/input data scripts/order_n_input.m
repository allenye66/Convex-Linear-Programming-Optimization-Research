m = 1e2
n = 1e5
A = 1/2 + rand(m,n)/2;
b = 1e5*(0.3+0.2*rand(1,m));
c = zeros(n, 1);

c = sum(A)'/m + randn(size(c))
K = 1;