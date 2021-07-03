from solvers import acceleration, euler_cromer, leapfrog
import numpy as np

pos = np.random.uniform(0.0,10.0,(2,3))
vel = np.random.uniform(0.0,10.0,(2,3))
m = np.random.uniform(0.0,10.0,(2))

for _ in range(100):
    a = acceleration(pos,m)
    pos = leapfrog(pos, vel, a, m)
    print(pos)
    