from malik import option
from malik import payoff
from malik import engine
from malik import marketdata
from malik import facade
import numpy as np

# make a call option
the_call_payoff = payoff.VanillaCallPayoff(40.0)
the_call = option.Option(1.0, the_call_payoff)

# make a put option
the_put_payoff = payoff.VanillaPutPayoff(40.0)
the_put = option.Option(1.0, the_put_payoff)

# make a European binomial engine
nsteps = 300
binom_engine = engine.EuropeanBinomialEngine(nsteps)

# make a basic market data handle
mdata = marketdata.MarketData(41.0, 0.08, 0.30, 0.0)

# price the options
opt1 = facade.OptionFacade(the_call, binom_engine, mdata)
opt2 = facade.OptionFacade(the_put, binom_engine, mdata)
print("The value of the call option is: {0:0.3f}".format(opt1.price()))
print("The value of the put option is: {0:0.3f}".format(opt2.price()))


