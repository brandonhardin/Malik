from . cimport payoff

cdef class Option:
    cdef double _expiry
    cdef payoff.Payoff _payoff

    cpdef payoff(self, double spot)

