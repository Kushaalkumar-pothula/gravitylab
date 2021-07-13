from solvers import acceleration, leapfrog
import numpy as np
import matplotlib.pyplot as plt


class Simulation():
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

    def run(self, verbose=False):
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
        self.pos = pos_arr

        if verbose==True:
                print(pos_arr)

        return pos_arr

    def plot(self, three_dimensional=False, color='blue'):
        """
        Plot positions
        """
        if three_dimensional == True:
            fig = plt.figure()
            ax = plt.axes(projection='3d')
            ax.scatter3D(self.pos[:,0], self.pos[:,1], self.pos[:,2], color=color)
            plt.show()
        
        plt.scatter(self.pos[:,0], self.pos[:,1], color=color)
        plt.show()
