from solvers import acceleration, leapfrog
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import animation


class Simulation():
    """
    Main simulation class for GravityLab

    Attributes
    ----------
    N    : Number of bodies
    dt   : Timestep
    t    : Start time
    tEnd : End time

    Methods
    -------
    initial_conditions : Initial conditions for simulation
    run                : Run simulation
    plot               : Plot positions

    """
    def __init__(self, N, dt, t, tEnd):
        """
        Initialize a simulation

        Parameters
        ----------
        N    : Number of bodies
        dt   : Timestep
        t    : Start time
        tEnd : End time

        """
        self.N = N
        self.dt = dt
        self.t = t
        self.tEnd = tEnd

    def initial_conditions(self, pos, vel, mass):
        """
        Initial conditions for a simulation

        Parameters
        ----------
        pos : N x 3 array of positions
        vel : N x 3 array of velocities
        mass : N x 1 array of masses

        """
        self.pos = pos
        self.vel = vel
        self.mass = mass
        self.init_pos = pos

    def run(self, verbose=False):
        """
        Run the simulation

        Parameters
        ----------
        verbose (optional) : Give more verbose output

        Returns
        -------
        pos_arr : N x 3 array of positions
        
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

    def plot(self, three_dimensional=False, start_pos=True, color='blue', alpha = 0.6):
        """
        Plot positions of bodies

        Parameters
        ----------
        three_dimensional (optional) : 3D plotting
        color (optional)             : Desired colour of markers
        alpha (optional)             : Opacity of markers

        """
        if three_dimensional == True:
            fig = plt.figure()
            ax = plt.axes(projection='3d')
            if start_pos==True:
                ax.scatter3D(self.pos[:,0], self.pos[:,1], self.pos[:,2], color=color, alpha=alpha)
                ax.scatter3D(self.init_pos[0,0], self.init_pos[0,1], self.init_pos[0,2], color='red', alpha=alpha)
            else:
                ax.scatter3D(self.pos[:,0], self.pos[:,1], self.pos[:,2], color=color, alpha=alpha)
            plt.show()
        else:
            if start_pos==True:
                plt.scatter(self.pos[:,0], self.pos[:,1], color=color, alpha=alpha)
                plt.scatter(self.init_pos[0,0], self.init_pos[0,1], color='red')
            else:
                plt.scatter(self.pos[:,0], self.pos[:,1], color=color, alpha=alpha) 
            plt.show()
    
    def init_animation(self):
        """
        Initialize animation
        """
        fig, ax = plt.subplots()
        scatterplot, = ax.scatter([], [])
        scatterplot.set_data([], [])
        self.scatterplot = scatterplot
        return self.scatterplot,

    def animate_func(self, i):
        """
        Animate positions
        """
        acc = acceleration(self.pos, self.mass)
        self.pos, acc = leapfrog(self.pos, self.vel, acc, self.mass, self.dt)
        scatterplot = self.scatterplot
        for i in range(self.N):
            scatterplot.set_data(self.pos[:,0], self.pos[:,1])

        return self.scatterplot,
    
    def animate(self):
        """
        Animate
        """
        fig = plt.figure()
        Nt = int((self.tEnd - self.t)/self.dt)
        anim = animation.FuncAnimation(fig, self.animate_func, init_func=self.init_animation,
                               frames=Nt, interval=10, blit=False)
        plt.show()
        return

        
        
