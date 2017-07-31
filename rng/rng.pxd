cdef extern from "<random>" namespace "std":
    cdef cppclass mt19937

    cdef cppclass normal_distribution[T]

cpdef double[:] rnorm(unsigned int nreps, double mean, double sd, unsigned int seed)
