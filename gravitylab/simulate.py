from solvers import acceleration, leapfrog
import numpy as np
import matplotlib.pyplot as plt


class simulation():
    """
    Main simulation class
    """
    def __init__(self, N, dt, t, tEnd):
        """
        Initialize a simulation
        """
        self.N = N
        self.dt = dt
        self.t = t
        self.tEnd = tEnd

    def initial_conditions(self, pos, vel, mass):
        """
        Initial conditions
        """
        self.pos = pos
        self.vel = vel
        self.mass = mass

    def run(self):
        """
        Run simulation
        """
        Nt = int((self.tEnd - self.t)/self.dt)
        pos_lst = []

        acc = acceleration(self.pos, self.mass)

        for _ in range(Nt):
            self.pos, acc = leapfrog(self.pos, self.vel, acc, self.mass, self.dt)
            pos_lst.append(self.pos.copy())

        pos_arr = np.vstack(pos_lst)

        return pos_arr

    def plot(self, positions, three_dimensional=True, color = "blue", save=False):
        """
        Plot simulation output
        """
        fig = plt.figure()

        if three_dimensional == True:
            ax = plt.axes(projection='3d')
            ax.scatter3D(positions[:,0], positions[:,1], positions[:,2], color = color)
        else:
            plt.scatter(positions[:,0], positions[:,1], positions[:,2], color = color)
        
        if save == True:
            plt.savefig("gravitylab_output.png")
        
        plt.show()