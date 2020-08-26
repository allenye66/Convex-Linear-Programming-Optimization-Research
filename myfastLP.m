function [x,y] = fastLP(A,b,c,K);
% Set parameters
%m = 1e2
%n = 1e5
%A = 1/2 + rand(m,n)/2;
%b = 1e5*(0.3+0.2*rand(1,m));
%c = rand(n,1);
%K = 1;
% Set parameters
%
 [m,n] = size(A);
 d=b/n;
 step=1/sqrt(K*n);
 disp("-----------")

%
% Set initial solutions
%
 x = zeros(n,1);
% y = ones(m,1)./(sum(A'))';
% y = (sum(c)/n)*y;
 y = zeros(m,1);
 disp(y)
 disp("SIZE OF Y MATRIX:")
 disp(size(y))
% Set the initial scaled remaining inventory
 br= K*b;
 disp("BR SIZE:")
 disp(size(br))
 disp("----------------- BEGIN FIRST FOR LOOP ------------------")
%

 for k=1:K;
  disp("NEW ITERATION")
  p=randperm(n);
  disp("RANDOM PERMUTATION:")
  disp(size(p));
  disp("SIZE OF Y MATRIX")
  disp(size(y))
% Start the loop
 disp("----------------- BEGIN SECOND FOR LOOP ------------------")
  for i=1:n,
   disp("NEXT ITERATION IN THE SECOND FOR LOOP##################################")
   disp("SIZE OF Y MATRIX************************")
   disp(size(y))
   %we traverse the random permutation
   ii=p(i);

   disp("ii VARIABLE")
   disp(ii)
   
   %gets the column ii from the matrix A
   %the size is a 100 number long column
   aa=A(:,ii);

   disp("aa VARIABLE")
   disp(size(aa))

   %
   % Set the primal increment
   %
   
   %the sign function returns the same array but replaces all positive
   %integers with 1 and all negative integers with -1
   
   %c(ii) gets a single number 
   %aa' * y is a singlular column multiplied by a y, a matrix
   %the dimensions of the column are (100,1) and the dimensions of y are (100,1)
   %the column transpose size is (1,100)
   %multiplying aa' and y gets you a matrix with the size 1
   
   disp("AA TRANSPOSE TIMES Y__________________________")
   %disp(aa'*y)
   disp("C(II)")
   disp(c(ii))
   disp("c(ii)-aa'*y")
   disp(size(c(ii)-aa'*y))
    
   %aa' is a column transpose with the size of (1,100) and y is a (100,1) matrix of zeros
   %c(ii) gets a random number from the objective function
   %after subtracting c(ii)-aa'*y, we determine if the result is +/-
   %if it is positive then xk is 1, else it is 0
   disp(size(y))
   xk = (sign(c(ii)-aa'*y)+1)/2;
   
   
   
   disp("xk VARIABLE")
   disp(size(xk))
   %
   % Update the dual soluton
   %
   %aa is a single column with size (100,1)
   %xk is a single number, either 0 or 1 with size (1,1)
   %xk*aa = size(1, 100)
   %d is a 4 by 1 column
   disp('D:')
   %disp(d)
   disp(size(d))
   
   
   disp("SIZE OF XK")
   disp(size(xk))
   disp("SIZE OF AA")
   disp(size(aa))
   disp("SIZE OF xk*aa")

   disp(size(xk*aa))
   
   y=max(0,y+step*(xk*aa-d')); 
   disp("NEW SIZE OF Y MATRIX AFTER THIS STEP%%%%%%%%%%%%%%%%%%%%%")
   disp(size(y))
   %
   % Update the remaining inventory and primal solution
   %
   if min(br-xk*aa) >= 0,
       disp("IT IS GREATER")
       br=br-xk*aa;
       disp("BR SIZE:")
       disp(size(br))
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





