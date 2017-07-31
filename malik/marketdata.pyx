cdef class MarketData:
    """A class to hold market data for option pricing."""
    def __init__(self, spot, rate, vol, div):
        self._spot = spot
        self._rate = rate
        self._vol = vol
        self._div = div

    property spot:
        def __get__(self):
            return self._spot

        def __set__(self, spot):
            self._spot = spot

    property rate:
        def __get__(self):
            return self._rate

        def __set__(self, rate):
            self._rate = rate

    property vol:
        def __get__(self):
            return self._vol

        def __set__(self, vol):
            self._vol = vol

    property div:
        def __get__(self):
            return self._div

        def __set__(self, div):
            self._div = div


cdef class HestonData(MarketData):
    """A class to hold market data and estimated parameters for the Heston model."""

    def __init__(self, spot, rate, vol, div, kappa, theta, sigmav, rho):
        super(HestonData, self).__init__(spot, rate, vol, div)
        self._kappa = kappa
        self._theta = theta
        self._sigmav = sigmav
        self._rho = rho

    property kappa:
        def __get__(self):
            return self._kappa

        def __set__(self, kappa):
            self._kappa = kappa

    property theta:
        def __get__(self):
            return self._theta

        def __set__(self, theta):
            self._theta = theta

    property sigmav:
        def __get__(self):
            return self._sigmav

        def __set__(self, sigmav):
            self._sigmav = sigmav

    property rho:
        def __get__(self):
            return self._rho

        def __set__(self, rho):
            self._rho = rho


