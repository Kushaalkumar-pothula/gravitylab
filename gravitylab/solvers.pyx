#cython: language_level=3

cimport numpy as np
import numpy as np


def acceleration(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=1] mass):
    cdef int N = pos.shape[0] # Number of bodies   

    # Memoryview for acceleration
    cdef np.float64_t [:,:] acc = np.zeros((N,3),dtype="float64")
    cdef np.float64_t [:,:] pos_view = pos
    cdef np.float64_t [:] mass_view = mass

    cdef double soft = 1e-4 # Softening length
    cdef G = 6.673e-11 # Gravitational constant
    # Pairwise separations
    cdef double dx
    cdef double dy
    cdef double dz
    # Total separation vectors
    cdef double r
    cdef double tmp
    # Mass
    cdef mj

    # Acceleration calculation loop
    for i in range(N):
        for j in range(N):
            # Remove gravitational self forces
            if i==j:
                continue
            
            # Calculate pairwise separation vectors
            dx = pos_view[j,0] - pos_view[i,0]
            dy = pos_view[j,1] - pos_view[i,1]
            dz = pos_view[j,2] - pos_view[i,2]

            # Vector magnitude of separation vector
            r = dx**2 + dy**2 + dz**2
            r = np.sqrt(r)

            # Mass
            mj = mass_view[j]

            tmp = G * mj * r**3

            # Calculate accelerations
            acc[i,0] += tmp * dx
            acc[i,1] += tmp * dy
            acc[i,2] += tmp * dz

    return np.asarray(acc)



def euler_cromer(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=2] vel, np.ndarray[np.float64_t, ndim=2] acc):
    cdef double dt = 1e-3 # Timestep
    # The Euler-Cromer integration method
    # v(t+1) = v(t) + a(t) x dt
    # x(t+1) = x(t) + v(t+1) x dt
    vel += acc * dt
    pos += vel * dt

    return pos



def leapfrog(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=2] vel, np.ndarray[np.float64_t, ndim=2] acc, np.ndarray[np.float64_t, ndim=1] mass):
    cdef double dt = 1e-3 # Timestep

    # The Leapfrog integration method
    # v(t+1/2) = v(t) + a(t) x dt/2
    # x(t+1) = x(t) + v(t+1/2) x dt
    # a(t+1) = (G * m/((dx^2 + dy^2 + dz^2)^(3/2))) * dx * x
    # v(t+1) = v(t+1/2) + a(t+1) x dt/2
    vel += acc * dt/2
    pos += vel * dt
    acc = acceleration(pos, mass)
    vel += acc * dt/2

    return pos, acc
