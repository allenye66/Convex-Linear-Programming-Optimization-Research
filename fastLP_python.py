import numpy as np
from numpy import sqrt

A = [[50, 30, 30],[2, 3, 2],[1, 1, 1]]
c = [-30000, 15000, -16000]
b = [2000, 700, 30]
K = 1

m = len(A)
n = len(A[0])
print(m, n)

d = [i/n for i in b]
print(d)

step = 1/sqrt(K*n)
print(step)

x = np.zeros((n, 1))
print(x)

y = np.zeros((m, 1))
print(y)

br = K*b

for k in range(K):
	p = np.random.permutation(n)
	print(p)
	for i in range(n):
		ii = p[i-1]
		print(ii)
		A = np.array(A)
		aa = A[:,ii-1]

		xk = (np.sign(c[ii-1] - np.transpose(aa)*y)+1)/2
		print(y)
		print(xk)
		print("-------------")
		print(y+step*(xk*aa-d))
		y = np.maximum(0, y+step*(xk*aa-d))
		print(y)

		if(min(br - xk*aa)>= 0):
			br = br - xk*aa
			x[ii-1] = x[ii-1] + xk


