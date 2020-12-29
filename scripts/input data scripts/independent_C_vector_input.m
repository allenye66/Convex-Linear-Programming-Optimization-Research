

m = 1e2;
n = 1e5;


% USING A LOW B VALUE RANGE


b_lower = 10;
b_upper = 20;

b = (b_upper-b_lower).*rand(1, m) + b_lower; 
b_range = [min(b) max(b)]

%Just choose c is generated from a uniform distribution on [0,1]
%if the corresponding a-vector is positive and on [-1,0] otherwise



A1 = rand(m,n/2)*-1;
A2 = rand(m,n/2);
A = horzcat(A1,A2);

A = A(:,randperm(size(A,2)))

sum_A = sum(sum(A))


if(sum_A) > 0
   c = rand(n, 1)
else
    c = -1*rand(n, 1)
    
end



disp(sum_A)


