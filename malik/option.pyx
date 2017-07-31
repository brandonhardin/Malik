cdef class Option:
    def __init__(self, expiry, payoff):
        self._expiry = expiry
        self._payoff = payoff

    cpdef payoff(self, double spot):
        return self._payoff.payoff(spot)
