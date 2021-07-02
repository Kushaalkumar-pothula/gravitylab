import numpy as np
cimport numpy as np

DTYPE = np.float64

def acceleration(DTYPE[:,:] pos, DTYPE[:] mass):
    cdef int N = pos.shape[0]
    cdef DTYPE [:,:] acc = np.zeros((N,3),dtype=DTYPE)

    cdef double soft = 1e-4
    cdef G = 6.673e-11

    cdef double dx
    cdef double dy
    cdef double dz
    cdef double r2
    cdef double invr3

    for i in range(N):
        for j in range(N):
            if i==j:
                continue
            dx = pos[j,0] - pos[i,0]
            dy = pos[j,1] - pos[i,1]
            dz = pos[j,2] - pos[i,2]

            r2 = dx**2 + dy**2 + dz**2 + soft**2
            invr3 = r2**(-1.5)

            acc[i,0] += G * dx * invr3 * mass[j]
            acc[i,1] += G * dy * invr3 * mass[j]
            acc[i,1] += G * dz * invr3 * mass[j]

    return acc






