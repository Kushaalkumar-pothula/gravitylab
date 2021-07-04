from solvers import acceleration, euler_cromer, leapfrog
import numpy as np
import matplotlib.pyplot as plt

N = 2

pos  = np.random.randn(N,3)
vel  = np.random.randn(N,3)
m = np.ones(N)

pos_lst = []
acc = acceleration(pos, m)

for _ in range(500):
    pos, acc = leapfrog(pos, vel, acc, m)
    pos_lst.append(pos.copy())
    
pos_arr = np.vstack(pos_lst)
plt.scatter(pos_arr[:,0], pos_arr[:,1])
plt.scatter(pos_arr[0,0], pos_arr[0,1], color='r')
plt.scatter(pos_arr[-1,0], pos_arr[-1,1], color='r')
plt.savefig("test.png")