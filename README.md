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
```

## Usage
You can run the simulation using the `gravitylab.simulate` module. This module provides a powerful (yet simple to use) class `Simulation`. An instance of the `Simulation` class can be instantiated with the following command (parameters not shown here):

```python
from gravitylab.simulate import Simulation
my_simulation = Simulation()
```
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

An example for running `GravityLab` simulations can be found in `gravitylab/example.py`:
```zsh
> python gravitylab/example.py
```

## Author
This code was written by [Kushaal Kumar Pothula](https://kushaalkumarpothula.wordpress.com/). I wrote this code during my 10th grade while learning about numerical simulations during the summer.
