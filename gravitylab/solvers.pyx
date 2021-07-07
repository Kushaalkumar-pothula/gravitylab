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
    dx = np.asarray(dx, dtype="float64")

    # Calculate the magnitude of the separation 
    r = np.sqrt(np.dot(dx, dx))

    return r, np.asarray(dx, dtype="float64")

def acceleration(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=1] mass):
    
    cdef int N = pos.shape[0]

    cdef np.float64_t [:,:] acc = np.zeros((N,3), dtype="float64")

    cdef np.float64_t r
    cdef np.float64_t r1
    cdef np.float64_t r2

    cdef np.ndarray [np.float64_t, ndim=1] dx
    cdef np.ndarray [np.float64_t, ndim=1] dx1
    cdef np.ndarray [np.float64_t, ndim=1] dx2

    cdef np.float64_t m1
    cdef np.float64_t m2

    cdef int i

    r, dx = separation(pos[0,:], pos[1,:]) # separation between 1 and 2

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

    for i in range(2,N):
        r1, dx1 = separation(pos[i,:],pos[0,:]) # test particle and body 1
        r2, dx2 = separation(pos[i,:],pos[1,:]) # test particle and body 2

        acc[i,0] = m1 / r1**3 * dx1[0] + m2 / r2**3 * dx2[0]
        acc[i,1] = m1 / r1**3 * dx1[1] + m2 / r2**3 * dx2[1]
        acc[i,2] = m1 / r1**3 * dx1[2] + m2 / r2**3 * dx2[2]

    return np.asarray(acc)


def euler_cromer(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=2] vel, np.ndarray[np.float64_t, ndim=2] acc, double dt):
    """
    Integrate using the Euler-Cromer method

    v(t+1) = v(t) + a(t) x dt
    x(t+1) = x(t) + v(t+1) x dt

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
    """
    vel += acc * dt/2
    pos += vel * dt
    acc = acceleration(pos, mass)
    vel += acc * dt/2

    return pos, acc
