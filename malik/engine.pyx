from libc.math cimport exp as cexp
from libc.math cimport sqrt as csqrt
import numpy as np
cimport numpy as np
from scipy.stats import binom

cdef class PricingEngine:
    """A base class for option pricing engines."""
    cdef double calculate(self, option.Option option, marketdata.MarketData data):
        pass

cdef class BinomialEngine(PricingEngine):
    """An interface class for binomial pricing models."""
    def __init__(self, nsteps):
        self._nsteps = nsteps

    cdef double calculate(self, option.Option option , marketdata.MarketData data):
        pass

cdef class EuropeanBinomialEngine(BinomialEngine):
    """A concrete class for the European binomial option pricing model."""

    cdef double calculate(self, option.Option option, marketdata.MarketData data):
        cdef double expiry = option.expiry
        cdef double strike = option.strike
        cdef double spot = data.spot
        cdef double rate = data.rate
        cdef double vol = data.vol
        cdef double div = data.div
        cdef double dt = expiry / self._nsteps
        cdef double u = cexp(((rate - div) * dt) + vol * csqrt(dt))
        cdef double d = cexp(((rate - div) * dt) - vol * csqrt(dt))
        cdef double pu = (cexp((rate - div) * dt) - d) / (u - d)
        cdef double pd = 1.0 - pu
        cdef double disc = cexp(-rate * expiry)
        cdef double spot_t = 0.0
        cdef double payoff_t = 0.0
        cdef unsigned int nodes = self._nsteps + 1

        for i in range(nodes):
            spot_t = spot * (u ** (self._nsteps - i) * (d ** i))
            payoff_t += option.payoff(spot_t) * binom.pmf(self._nsteps - i, self._nsteps, pu)

        return disc * payoff_t


cdef class MonteCarloEngine(PricingEngine):
    """An interface class for Monte Carlo pricing models."""
    def __init__(self, nreps, nsteps):
        self._nreps = nreps
        self._nsteps = nsteps

    cdef double calculate(self, option.Option option , marketdata.MarketData data):
        pass

cdef class NaiveMonteCarloEngine(MonteCarloEngine):
    """A concrete class to implement the naive Monte Carlo pricing model."""

    cdef double calculate(self, option.Option option , marketdata.MarketData data):
        #z = rng.rnorm(self._nreps, 0.0, 1.0, 12354)
        z = np.random.normal(10)

        return 3.14

cdef class MCHestonEngine(MonteCarloEngine):
    """A concrete class to implement the Heston Monte Carlo pricing model."""

    cdef double calculate(self, option.Option option, marketdata.MarketData data):
        return 42
        
