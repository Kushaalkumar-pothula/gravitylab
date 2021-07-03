#cython: language_level=3

cimport numpy as np
import numpy as np

def acceleration(np.ndarray[np.float64_t, ndim=2] pos, np.ndarray[np.float64_t, ndim=1] mass):
    cdef int N = pos.shape[0] # Numner of bodies   
    cdef np.float64_t [:,:] acc = np.zeros((N,3),dtype="float64") # Memoryview for acceleration

    cdef double soft = 1e-4 # Softening length
    cdef G = 6.673e-11 # Gravitational constant

    # Pairwise separations
    cdef double dx
    cdef double dy
    cdef double dz

    # Accelerations
    cdef double ax = 0.0
    cdef double ay = 0.0
    cdef double az = 0.0


    # Total separation vectors
    cdef double r

    # Mass
    cdef mj

    # Acceleration calculation loop
    for i in range(N):
        for j in range(N):
            # Remove gravitational self forces
            if i==j:
                continue
            # Calculate pairwise separation vectors
            dx = pos[j,0] - pos[i,0]
            dy = pos[j,1] - pos[i,1]
            dz = pos[j,2] - pos[i,2]

            # Mass
            mj = mass[j]

            # Separation magnitude
            r = np.sqrt(dx**2 + dy**2 + dz**2 + soft**2)

            # Calculate accelerations in each dimension
            ax += -1 * G * mj/r**3*dx
            ay += -1 * G * mj/r**3*dy
            az += -1 * G * mj/r**3*dz

            acc[i,0] = ax
            acc[i,1] = ay
            acc[i,2] = az

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

    return pos
