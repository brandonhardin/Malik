cdef class MarketData:
    cdef double _spot
    cdef double _rate
    cdef double _vol
    cdef double _div

cdef class HestonData(MarketData):
    cdef double _kappa
    cdef double _theta
    cdef double _sigmav
    cdef double _rho
