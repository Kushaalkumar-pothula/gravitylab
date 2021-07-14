from simulate import Simulation
import numpy as np
import matplotlib.pyplot as plt

N = 2
dt = 1e-4
t = 0.0
tEnd = 1.0

pos  = np.random.uniform(size=(N,3))
vel = np.random.uniform(size=(N,3))
mass = np.ones(N)

tenbody = Simulation(N,dt,t,tEnd)
tenbody.initial_conditions(pos,vel,mass)
positions = tenbody.run()
tenbody.plot(three_dimensional=True)

