from solvers import acceleration, euler_cromer, leapfrog
import numpy as np
import matplotlib.pyplot as plt

N = 2

r1=[-0.5,0,0] #m
r2=[0.5,0,0] #m

v1=[0.01,0.01,0] #m/s
v2=[-0.05,0,-0.1] #m/s

pos = np.vstack((r1,r2))
vel = np.vstack((v1,v2))
m = np.array([1.1*2e30, 0.907*2e30])

pos_lst = []
for _ in range(500):
    a = acceleration(pos,m)
    pos = leapfrog(pos, vel, a, m)
    pos_lst.append(pos.copy())
    
pos_arr = np.vstack(pos_lst)
plt.scatter(pos_arr[:,0], pos_arr[:,1])
plt.scatter(pos_arr[0,0], pos_arr[0,1], color='r')
plt.scatter(pos_arr[-1,0], pos_arr[-1,1], color='r')
plt.savefig("test.png")