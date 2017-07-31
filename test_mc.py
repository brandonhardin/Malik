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

# make a Monte Carlo Heston engine
nsteps = 300
mc_engine = engine.MCHestonEngine(500, 50)

# make a basic market data handle
mdata = marketdata.MarketData(41.0, 0.08, 0.30, 0.0)

# price the options
opt1 = facade.OptionFacade(the_call, mc_engine, mdata)
opt2 = facade.OptionFacade(the_put, mc_engine, mdata)
print("The value of the call option is: {0:0.3f}".format(opt1.price()))
print("The value of the put option is: {0:0.3f}".format(opt2.price()))


