from matplotlib import colors
from solvers import acceleration, euler_cromer, leapfrog, separation
import numpy as np
import matplotlib.pyplot as plt

N = 20 # Number of bodies

# Generate random positions and velocity
pos  = np.random.randn(N,3)
vel  = np.random.randn(N,3)

# Mass of all bodies = 1
m = np.ones(N)

# Number of timesteps (tEnd/dt, chosen arbitrarily here for testing)
Nt = 1000
# List for holding positions
pos_lst = []

# Calculate initial acceleration
acc = acceleration(pos, m)

print("Separation test:")
# Run simulation
for _ in range(Nt):
    # Calculate positions and get new acceleration values
    pos, acc = leapfrog(pos, vel, acc, m)
    r, dx = separation(pos[0,:], pos[1,:])
    print(r)

    # Add positions to a list
    pos_lst.append(pos.copy())

# Vertically stack all position arrays to get a matrix of all positions  
pos_arr = np.vstack(pos_lst)

# Plot all positions
plt.scatter(pos_arr[:,0], pos_arr[:,1], color='blue', alpha = 0.3)

# Plot the last two positions, to distinguish between attraction and repulsion
plt.scatter(pos_arr[-1,0], pos_arr[-1,1], color='red')
plt.scatter(pos_arr[0,0], pos_arr[1,1], color='green')

# Save figure
plt.savefig("test.png")