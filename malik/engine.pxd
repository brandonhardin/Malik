from . cimport option
from . cimport marketdata

cdef class PricingEngine:
    cdef double calculate(self, option.Option option, marketdata.MarketData data)

cdef class BinomialEngine(PricingEngine):
    cdef unsigned long _nsteps

    cdef double calculate(self, option.Option option, marketdata.MarketData data)

cdef class EuropeanBinomialEngine(BinomialEngine):
    cdef double calculate(self, option.Option option, marketdata.MarketData data)
