# distutils: extra_compile_args = -std=c++11

import numpy as np
cimport numpy as np

cdef extern from "<random>" namespace "std":
    cdef cppclass mt19937:
        mt19937()
        mt19937(unsigned int seed)

    cdef cppclass normal_distribution[T]:
        normal_distribution()
        normal_distribution(T mean, T stddev)
        T operator()(mt19937 gen)

cpdef double[:] rnorm(unsigned int nreps, double mean, double sd, unsigned int seed):
    cdef double[:] values = np.zeros(nreps, dtype=np.float64)
    cdef mt19937 gen = mt19937(seed)
    cdef normal_distribution[double] dist = normal_distribution[double](mean, sd)
    cdef unsigned int i

    for i in range(nreps):
        values[i] = dist(gen)

    return values

