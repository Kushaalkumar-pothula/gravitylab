from solvers import acceleration, leapfrog
import numpy as np
import matplotlib.pyplot as plt

N = 30 # Number of bodies
dt = 1e-3
tStart = 0.0
tEnd = 10.0
# Generate random positions and velocity
pos  = np.random.randn(N,3)
vel  = np.random.randn(N,3)

# Mass of all bodies = 1
m = np.array([10,1e2])

# Number of timesteps (tEnd/dt, chosen arbitrarily here for testing)
Nt = int(tEnd/dt)
# List for holding positions
pos_lst = []

# Calculate initial acceleration
acc = acceleration(pos, m)

# Run simulation
for _ in range(Nt):
    # Calculate positions and get new acceleration values
    pos, acc = leapfrog(pos, vel, acc, m, dt)

    # Add positions to a list
    pos_lst.append(pos.copy())

# Vertically stack all position arrays to get a matrix of all positions  
pos_arr = np.vstack(pos_lst)

fig = plt.figure()
ax = plt.axes(projection='3d')

ax.scatter3D(pos_arr[:,0], pos_arr[:,1], pos_arr[:,2], color = "skyblue")
ax.scatter3D(pos_arr[0,0], pos_arr[0,1], pos_arr[0,2], color = "green")
ax.scatter3D(pos_arr[-1,0], pos_arr[-1,1], pos_arr[-1,2], color = "red")
# Plot all positions
#plt.scatter(pos_arr[:,0], pos_arr[:,1], color='blue', alpha = 0.3)

# Plot the last two positions, to distinguish between attraction and repulsion
#plt.scatter(pos_arr[-1,0], pos_arr[-1,1], color='red')
#plt.scatter(pos_arr[0,0], pos_arr[1,1], color='green')

plt.show()