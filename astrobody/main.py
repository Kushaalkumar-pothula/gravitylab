from solvers import acceleration
import numpy as np

pos = np.random.uniform(0.0,10.0,(2,3))
m = np.random.uniform(0.0,10.0,(2))

for _ in range(10):
    a = acceleration(pos,m)
    print(a)
    print(f"Type of a = {type(a)}")