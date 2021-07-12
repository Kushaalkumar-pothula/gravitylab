from simulate import Simulation
import numpy as np
import matplotlib.pyplot as plt

N = 30
dt = 1e-4
t = 0.0
tEnd = 1.0

pos  = np.random.uniform(size=(N,3))
xi = pos[:,0]
yi = pos[:,1]
vel = np.random.uniform(size=(N,3))
mass = np.ones(N)

tenbody = Simulation(N,dt,t,tEnd)
tenbody.initial_conditions(pos,vel,mass)
positions = tenbody.run()

x = positions[:,0]
y = positions[:,1]
plt.scatter(x,y,color='blue',alpha=0.3)
plt.scatter(xi,yi,color='red')
plt.show()

