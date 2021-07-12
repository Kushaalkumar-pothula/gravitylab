# GravityLab: Astrophysical N-body simulator.
An astrophysical N-body simulator.

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
> python setup.py build_ext --inplace
```

## Usage
You can run the simulation using the `gravitylab.simulate` module. This module provides a simple yet powerful class `Simulation`. A `Simulation` instance can be instantiated with the following command (`Simulation` parameters not shown here):

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
positions = my_simulation.run()
```
The `positions` variable is a N x 3 array of positions which can be plotted.

An example for running `GravityLab` simulations can be found in `gravitylab/example.py`:
```zsh
> python gravitylab/example.py
```

## Author
This code was written by [Kushaal Kumar Pothula](https://kushaalkumarpothula.wordpress.com/). I wrote this code during my 10th grade while learning about numerical simulations during the summer.
