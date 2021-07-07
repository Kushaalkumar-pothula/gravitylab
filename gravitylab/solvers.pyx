#cython: language_level=3

cimport numpy as np
import numpy as np


def separation(np.ndarray[np.float64_t, ndim=1] x1, np.ndarray[np.float64_t, ndim=1] x2):
    """
    Calculate separations
    """
    cdef np.float64_t [:] dx # Separation vector (1D memoryview)
    cdef np.float64_t r # Separation vector magnitude

    # Calculate separation and make it an array
    dx = x2 - x1
    dx = np.asarray(dx)

    # Calculate the magnitude of the separation 
    r = np.sqrt(np.dot(dx, dx))

    return r, np.asarray(dx)

def acceleration(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=1] mass):
    cdef int N = pos.shape[0]
    cdef np.float64_t [:,:] acc = np.zeros((N,3))

    cdef np.float64_t r
    cdef np.ndarray [np.float64_t, ndim=1] dx

    cdef np.float64_t m1
    cdef np.float64_t m2

    cdef np.float64_t r1
    cdef np.float64_t r2

    cdef np.ndarray [np.float64_t, ndim=1] dx1
    cdef np.ndarray [np.float64_t, ndim=1] dx2

    cdef int i

    r, dx = separation(pos[0,:], pos[1,:]) # separation between 1 and 2

    m1 = mass[0]
    m2 = mass[1]
    
    acc[0,:] =  m2 / r**3 * dx[:]    # acceleration on body 1
    acc[1,:] = -m1 / r**3 * dx[:]    # acceleration on body 2

    for i in range(2,N):
        # acceleration on test particles ONLY due to bodies 1 and 2
        # i.e. they do not feel each other
        r1, dx1 = separation(pos[i,:],pos[0,:]) # test particle and body 1
        r2, dx2 = separation(pos[i,:],pos[1,:]) # test particle and body 2

        acc[i,:] = m1 / r1**3 * dx1[:] + m2 / r2**3 * dx2[:]
    return np.asarray(acc)


def euler_cromer(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=2] vel, np.ndarray[np.float64_t, ndim=2] acc):
    """
    Integrate using the Euler-Cromer method

    v(t+1) = v(t) + a(t) x dt
    x(t+1) = x(t) + v(t+1) x dt

    """
    cdef double dt = 1e-3 # Timestep
    

    vel += acc * dt
    pos += vel * dt

    return pos



def leapfrog(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=2] vel, np.ndarray[np.float64_t, ndim=2] acc, np.ndarray[np.float64_t, ndim=1] mass):
    """
    Integrate using the Leapfrog method.

    v(t+1/2) = v(t) + a(t) x dt/2
    x(t+1) = x(t) + v(t+1/2) x dt
    a(t+1) = (G * m/((dx^2 + dy^2 + dz^2)^(3/2))) * dx * x
    v(t+1) = v(t+1/2) + a(t+1) x dt/2
    """
    cdef double dt = 1e-3 # Timestep

    vel += acc * dt/2
    pos += vel * dt
    acc = acceleration(pos, mass)
    vel += acc * dt/2

    return pos, acc
