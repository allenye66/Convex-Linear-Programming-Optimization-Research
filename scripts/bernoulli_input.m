m = 1e2;
n = 1e5;
%m = 3
%n = 20

c = rand(n,1)

%probability of success
p=0.6;

%half positive matrix
A_pos=rand(m, n/2);
A_pos=(A_pos<p)

%half negative matrix
A_neg=rand(m, n/2);
A_neg=(A_neg<p)
A_neg = A_neg*-1

%combine positive and negative matrix
A = horzcat(A_pos,A_neg);


b = ones(1,m)






