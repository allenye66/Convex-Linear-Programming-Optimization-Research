m = 1e2;
n = 1e5;
A = 1/2 + rand(m,n)/2;
b = 1e5*(0.3+0.2*rand(1,m));
c = rand(n,1);

cvx_begin
    variables x(n);
    maximize(c' * x);
    subject to
        A*x <= b;
        0<=x<=1;
cvx_end

%  This program solves the linearly constrained convex programming.
%
%      max   c'*x
%      s.t.  Ax <= b, 0 <= x <= 1.
%
%  Input 
%      A: (sparse) inequality constraint matrix.
%      b (>0): inequality right-hand column vector
%      K: boosting (positive) integer
%  
%  Output
%     x      : approximate (fractional) solution,
%     y>=0   : price vector
