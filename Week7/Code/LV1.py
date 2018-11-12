#!/usr/bin/env python3

""" Constructs a Lotka-Volterra Model given default inputs, 
    and produces graphs of both species over time and both species 
    in relation to each other """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p

## CONSTANTS ##

r = 1.
a = 0.1 
z = 1.5
e = 0.75

t = sc.linspace(0, 15,  1000)

R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0]) 

## FUNCTIONS ##

def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    return sc.array([dRdt, dCdt])


################

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
#p.show()# To display the figure

f1.savefig('../Output/LV_model.pdf') #Save figure

f2 = p.figure()

p.plot(pops[:,0], pops[:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
#p.show()# To display the figure

f2.savefig('../Output/LV_model_circ.pdf')