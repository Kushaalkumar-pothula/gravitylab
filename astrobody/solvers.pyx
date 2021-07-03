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

    # Total separation vectors
    cdef double r2
    cdef double invr3

    # Acceleration calculation loop
    for i in range(N):
        for j in range(N):
            # Remove self forces
            if i==j:
                continue
            # Calculate pairwise separations
            dx = pos[j,0] - pos[i,0]
            dy = pos[j,1] - pos[i,1]
            dz = pos[j,2] - pos[i,2]

            # r^2
            r2 = dx**2 + dy**2 + dz**2 + soft**2

            # Total separation
            invr3 = r2**(-1.5)

            # Calculate accelerations in each dimension
            acc[i,0] += G * dx * invr3 * mass[j]
            acc[i,1] += G * dy * invr3 * mass[j]
            acc[i,1] += G * dz * invr3 * mass[j]

    return np.asarray(acc)






