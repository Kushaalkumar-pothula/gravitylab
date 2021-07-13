#cython: language_level=3

cimport numpy as np
import numpy as np


def separation(np.ndarray[np.float64_t, ndim=1] x1, np.ndarray[np.float64_t, ndim=1] x2):
    """
    Calculate separations

    Parameters
    ----------
    x1 : 1D array
        Position of body 1

    x2 : 1D array
        Position of body 2

    Returns
    -------
    dx : 1D array
        Separation vector

    r : float
        Magnitude of separation vector
    """
    cdef np.float64_t [:] dx # Separation vector (1D memoryview)
    cdef np.float64_t r # Separation vector magnitude

    # Calculate separation and make it an array
    dx = x2 - x1
    dx = np.asarray(dx, dtype="float64")

    # Calculate the magnitude of the separation 
    r = np.sqrt(np.dot(dx, dx))

    return r, np.asarray(dx, dtype="float64")


def acceleration(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=1] mass):
    """
    Calculate accelerations

    Parameters
    ----------
    pos  : 2D array
           N x 3 array of positions

    vel  : 2D array
           N x 3 array of positions

    mass : 1D array
           N x 1 array of masses
    
    Returns
    -------
    acc : 2D array
          N x 3 array of accelerations
    """
    cdef int N = pos.shape[0]   # Number of bodies

    # Initialize N x 3 memoryview of accelerations
    cdef np.float64_t [:,:] acc = np.zeros((N,3), dtype="float64")

    # Separation vector magnitudes
    cdef np.float64_t r
    cdef np.float64_t r1
    cdef np.float64_t r2

    # Separation vectors
    cdef np.ndarray [np.float64_t, ndim=1] dx
    cdef np.ndarray [np.float64_t, ndim=1] dx1
    cdef np.ndarray [np.float64_t, ndim=1] dx2

    # Masses of body 1 and 2
    cdef np.float64_t m1
    cdef np.float64_t m2

    # Variable for indexing
    cdef int i

    # Calculate separation
    r, dx = separation(pos[0,:], pos[1,:]) # separation between 1 and 2

    # Get masses of body 1 and 2
    m1 = mass[0]
    m2 = mass[1]
    
    # Acceleration on body 1
    acc[0,0] =  m2 / r**3 * dx[0]
    acc[0,1] =  m2 / r**3 * dx[1]
    acc[0,2] =  m2 / r**3 * dx[2]

    # Acceleration on body 2
    acc[1,0] = -m1 / r**3 * dx[0]
    acc[1,1] = -m1 / r**3 * dx[1]
    acc[1,2] = -m1 / r**3 * dx[2]

    # Acceleration on other bodies due to bodies 1 and 2
    for i in range(2,N):
        r1, dx1 = separation(pos[i,:],pos[0,:]) # Separation between other bodies and body 1
        r2, dx2 = separation(pos[i,:],pos[1,:]) # Separation between other bodies and body 2

        # Calculate accelerations
        acc[i,0] = m1 / r1**3 * dx1[0] + m2 / r2**3 * dx2[0]
        acc[i,1] = m1 / r1**3 * dx1[1] + m2 / r2**3 * dx2[1]
        acc[i,2] = m1 / r1**3 * dx1[2] + m2 / r2**3 * dx2[2]

    return np.asarray(acc)


def euler_cromer(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=2] vel, np.ndarray[np.float64_t, ndim=2] acc, double dt):
    """
    Integrate using the Euler-Cromer method

    v(t+1) = v(t) + a(t) x dt
    x(t+1) = x(t) + v(t+1) x dt

    Parameters
    ----------
    pos : 2D array
          N x 3 array of positions
    
    vel : 2D array
          N x 3 array of velocities

    acc : 2D Array
          N x 3 array of accelerations
    dt  : double
          Timestep

    Returns
    -------
    pos : 2D array
          N x 3 array of new positions
    """
    vel += acc * dt
    pos += vel * dt

    return pos



def leapfrog(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=2] vel, np.ndarray[np.float64_t, ndim=2] acc, np.ndarray[np.float64_t, ndim=1] mass, double dt):
    """
    Integrate using the Leapfrog method.

    v(t+1/2) = v(t) + a(t) x dt/2
    x(t+1) = x(t) + v(t+1/2) x dt
    a(t+1) = (G * m/((dx^2 + dy^2 + dz^2)^(3/2))) * dx * x
    v(t+1) = v(t+1/2) + a(t+1) x dt/2

    Parameters
    ----------
    pos : 2D array
          N x 3 array of positions
    
    vel : 2D array
          N x 3 array of velocities

    mass : 1D Array
           N x 1 array of masses
    dt   : double
            Timestep

    Returns
    -------
    pos : 2D array
          N x 3 array of new positions
    acc : 2D array
          N x 3 array of accelerations
    """
    # v(t+1/2) = v(t) + a(t) x dt/2
    vel += acc * dt/2

    # x(t+1) = x(t) + v(t+1/2) x dt
    pos += vel * dt
    
    # a(t+1) = (G * m/((dx^2 + dy^2 + dz^2)^(3/2))) * dx * x
    acc = acceleration(pos, mass)

    # v(t+1) = v(t+1/2) + a(t+1) x dt/2
    vel += acc * dt/2

    return pos, acc
