from . cimport option
from . cimport engine
from . cimport marketdata

cdef class OptionFacade:
    """A facade class to price an option."""
    cdef option.Option _option
    cdef engine.PricingEngine _engine
    cdef marketdata.MarketData _data

    def __init__(self, option, engine, data):
        self._option = option
        self._engine = engine
        self._data = data

    cpdef price(self):
        return self._engine.calculate(self._option, self._data)
