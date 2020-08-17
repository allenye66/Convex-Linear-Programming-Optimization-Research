function [x,y] = fastLP(A,c,b,K);
% Set parameters
%
 [m,n] = size(A);
 d=b/n;
 step=1/sqrt(K*n);
%
% Set initial solutions
%
 x = zeros(n,1);
% y = ones(m,1)./(sum(A'))';
% y = (sum(c)/n)*y;
 y = zeros(m,1);
% Set the initial scaled remaining inventory
 br= K*b;
%
 for k=1:K;
  p=randperm(n);
%
% Start the loop
%
  for i=1:n,
   ii=p(i);
   aa=A(:,ii);
   %
   % Set the primal increment
   %
   xk = (sign(c(ii)-aa'*y)+1)/2;
   %
   % Update the dual soluton
   %
   y=max(0,y+step*(xk*aa-d)); 
   %
   % Update the remaining inventory and primal solution
   %
   if min(br-xk*aa) >= 0,
       br=br-xk*aa;
       x(ii)=x(ii)+xk;
   end
   %
  end;
 end;
  x=x/K;
%
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




