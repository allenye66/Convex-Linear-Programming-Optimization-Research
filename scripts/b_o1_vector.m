m = 1e2;
n = 1e6;


%n is 10^6
%m is 10 or 100




%A is constrained between -1 and 1
%a is all 1's and 0's or -1 and 0
%first half pos, second negative
%half positive and half negative values
%in future, try if random number to indicate how many positive parts and
%negative


lower = -1;
upper = 1;

c = (upper-lower).*rand(n,1) + lower;

A = (upper-lower).*rand(m,n) + lower;
%need to separate it into half positive half negative
%make two seperate vecotrs and combine them

b_lower = 500;
b_upper = 5000;

b = (b_upper-b_lower).*rand(1, m) + b_lower; 
b_range = [min(b) max(b)]
disp(b_range)
% around 1000's 
% b = [1000, 3000, 1500, 2000, 2200...]
%change b to o(1) VECTOR
%permutation negative part
%b has to be positive
%not close to zero






%run the online solution with new input
%run the offline solution with new input
%compare similarity