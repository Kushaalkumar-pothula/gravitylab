from solvers import acceleration, euler_cromer, leapfrog
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import animation

N = 20

pos  = np.random.randn(N,3)   # randomly selected positions and velocities
vel  = np.random.randn(N,3)
m = np.ones(N)

Nt = 100

pos_lst = []
for i in range(Nt):
    a = acceleration(pos,m)
    pos = leapfrog(pos, vel, a, m)
    pos_lst.append(pos.copy())
    
pos_arr = np.vstack(pos_lst)

fig = plt.figure(figsize=(8,6))

def init_anim():
    fig.set([],[])
    return

def animate():
    """
    Animate
    """
    a = acceleration(pos,m)
    pos = leapfrog(pos, vel, a, m)

    return


anim = animation.FuncAnimation(fig, animate, init_func=init_anim, repeat=False,
                                   frames=Nt, interval=10, blit=False)
anim.save('test.gif', writer="imagemagick")