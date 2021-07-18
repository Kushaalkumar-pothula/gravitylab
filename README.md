# GravityLab: Astrophysical N-body simulator.
![GitHub](https://img.shields.io/github/license/Kushaalkumar-pothula/gravitylab)
![PyPI](https://img.shields.io/pypi/v/GravityLab)

A fast astrophysical N-body simulator.

GravityLab is written in Python and Cython, with performance-critical parts implemented in Cython and the main simulation module written in Python. This makes GravityLab flexible and very fast. The core physics solvers are written in Cython and are optimized to make GravityLab fast. The ODEs governing motions of the bodies are solved using the Leapfrog integration scheme. The Python module is flexible and powerful, while keeping it simple for users to use it.

## Installation

### Dependencies
The following are required to run GravityLab:
- Cython
- NumPy
- Matplotlib

### Install
To install this code, run the following commands in your terminal:
```zsh
> git clone https://github.com/Kushaalkumar-pothula/gravitylab.git
> cd gravitylab
> python setup.py build_ext --inplace
> python setup.py install
```

## Usage
You can launch a Python prompt or IPython shell from the `gravitylab/` directory, which allows you to import the modules directly. You should also all the `gravitylab` to PYTHONPATH to be able to access it from anywhere throughout the system. To run gravitylab in a Python prompt or IPython shell, you can do:
```zsh
> cd gravitylab
> python
```
or if you use IPython (recommended):
```zsh
> cd gravitylab
> ipython
```
You can run the simulation using the `gravitylab.simulate` module. This module provides a powerful (yet simple to use) class `Simulation`. An instance of the `Simulation` class can be instantiated with the following command (parameters not shown here):

```python
from gravitylab.simulate import Simulation
my_simulation = Simulation()
```

Or if you are inside the `gravitylab` directory:
```python
from simulate import Simulation
my_simulation = Simulation()
```
### Set up simulations

Add initial conditions to a simulation instance:

```python
my_simulation.initial_conditions()
```

And then run a simulation using the `.run()` method:
```python
my_simulation.run()
```
You can also get the calculated positions returned by the above command:
```python
positions = my_simulation.run()
```
Next, you can create a plot of the evolution positions throughout the simulation:
```python
my_simulation.plot()
```
The `.plot()` method takes a many parameters, including 3D plotting.

An preset example (two equally massive bodies with random positions ans velocities) for running `GravityLab` simulations can be found in `gravitylab/example.py`:
```zsh
> python gravitylab/example.py
```

## Viewing help
<details>
  <summary>If you are using the IPython shell</summary>
  
  ```python
In [2]: Simulation?
Init signature: Simulation(N, dt, t, tEnd)
Docstring:
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
Init docstring:
Initialize a simulation

Parameters
----------
N    : Number of bodies
dt   : Timestep
t    : Start time
tEnd : End time
```
</details>

<details>
  <summary>If you are using the Python prompt</summary>
  
  ```python
  >>> help(Simulation)
  Help on class Simulation in module simulate:

class Simulation(builtins.object)
 |  Simulation(N, dt, t, tEnd)
 |
 |  Main simulation class for GravityLab
 |
 |  Attributes
 |  ----------
 |  N    : Number of bodies
 |  dt   : Timestep
 |  t    : Start time
 |  tEnd : End time
 |
 |  Methods
 |  -------
 |  initial_conditions : Initial conditions for simulation
 |  run                : Run simulation
 |  plot               : Plot positions
 |
 |  Methods defined here:
 |
 |  __init__(self, N, dt, t, tEnd)
 |      Initialize a simulation
 |
 |      Parameters
 |      ----------
 |      N    : Number of bodies
 |      dt   : Timestep
 |      t    : Start time
 |      tEnd : End time
 |
 |  animate(self)
 |      Animate
 |
 |  animate_func(self, i)
 |      Animate positions
 |
 |  init_animation(self)
 |      Initialize animation
 |
 |  initial_conditions(self, pos, vel, mass)
 |      Initial conditions for a simulation
 |
 |      Parameters
 |      ----------
 |      pos : N x 3 array of positions
 |      vel : N x 3 array of velocities
 |      mass : N x 1 array of masses
 |
 |  plot(self, three_dimensional=False, start_pos=True, color='blue', alpha=0.6)
 |      Plot positions of bodies
 |
 |      Parameters
 |      ----------
 |      three_dimensional (optional) : 3D plotting
 |      color (optional)             : Desired colour of markers
 |      alpha (optional)             : Opacity of markers
 |
 |  run(self, verbose=False)
 |      Run the simulation
 |
 |      Parameters
 |      ----------
 |      verbose (optional) : Give more verbose output
 |
 |      Returns
 |      -------
 |      pos_arr : N x 3 array of positions
 |
 |  ----------------------------------------------------------------------
  
  ```
</details>

The same step is applicable for methods of `Simulation()`.

## Author
This code was written by [Kushaal Kumar Pothula](https://kushaalkumarpothula.wordpress.com/). I wrote this code during my 10th grade while learning about numerical simulations during the summer as a learning project.
