K = 10
x_avg = 0
for i = 1:100
   [x1, y1] = fastLP(A, b, c, K)
   x_avg = x_avg + c'*x1
   disp(i)
end
x_avg/offline