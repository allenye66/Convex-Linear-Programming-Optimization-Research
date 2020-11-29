m = 1e2;
n = 1e5;


%n is 10^6
%m is 10 or 100




%A is constrained between -1 and 1
%a is all 1's and 0's or -1 and 0
%first half pos, second negative
%half positive and half negative values
%in future, try if m random number to indicate how many positive parts and
%negative

%negative = -1;
%lower = 0;
%upper = 1;
%half the columns should have the same negative columns at the same places(0 and -1)
%when testing this b(0) vector, stick with K = 1 

%so at first, all 1000000 columns are positive

%negative_cols = zeros(1, n/2)


%c = (upper-lower).*rand(n,1) + lower;
%c = rand(n,1)
%A = (upper-lower).*rand(m,n) + lower;

%A1 = (lower-negative).*rand(m,n/2) + lower;
%A2 = (upper-lower).*rand(m,n/2) + lower;
%A = horzcat(A1,A2);

A1 = rand(m,n/2)*-1;
A2 = rand(m,n/2);
A = horzcat(A1,A2);

%randomly shuffle the columns
A = A(:,randperm(size(A,2)))



%need to separate it into half positive half negative
%make two seperate vecotrs and combine them

b_lower = 100;
b_upper = 200;

b = (b_upper-b_lower).*rand(1, m) + b_lower; 
b_range = [min(b) max(b)]

c = sum(A)'/m + randn(size(c))

%disp(b_range)
% around 1000's 
% b = [1000, 3000, 1500, 2000, 2200...]
%change b to o(1) VECTOR
%permutation negative part
%b has to be positive
%not close to zero






%run the online solution with new input
%run the offline solution with new input
%compare similarity
c1






