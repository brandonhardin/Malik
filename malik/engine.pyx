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
	cdef double expiry = option.expiry
	cdef double strike = option.strike
	cdef double spot = data.spot
	cdef double rate = data.rate
	cdef double vol = data.vol
	cdef double div = data.div
	cdef double kappa = data.kappa
	cdef double theta = data.theta
	cdef double sigma = data.sigmav
	cdef double rho = data.rho
	cdef double path = np.zeros(nsteps)
	cdef double var = np.zeros(nsteps)
	cdef doubl CallT = np.zeros(nreps)
	cdef double[:] zp = np.random.normal(size=(nreps,nsteps))
	cdef double[:] z1 = np.random.normal(size=(nreps,nsteps))
	cdef double[:] z2 = np.random.normal(size=(nreps,nsteps))
	cdef double dt = option.expiry / nsteps
	cdef double int i
	cdef double int j

                for i in range(nreps):
                    var[0] = theta
                    path[0] = spot

                    for j in range(1, nsteps):

                        z2[i, j] = rho * z1[i, j] + np.sqrt(1.0 - rho * rho) * zp[i, j]

                        var[j] = var[j - 1] + kappa * (theta - var[j - 1]) * dt + sigmav * np.sqrt(var[j - 1] * dt) * z1[i, j]


                        if var[j] <= 0.0:
                            var[j] = np.maximum(var[j], 0.0)

                        
                        path[j] = path[j - 1] * np.exp((rate - div - 0.5 * var[j]) * dt + np.sqrt(var[j] * dt) * z2[i, j])

                callT[i] = callTPayoff(path[-1], strike)

		result = callT.mean() * np.exp(-rate * expiry)

    
