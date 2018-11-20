#!/usr/bin/env python3

""" Constructs a Lotka-Volterra Model given user inputs, 
    and produces graphs of both species over time and both species 
    in relation to each other """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import sys
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p
import ipdb

## CONSTANTS ##

# ipdb.set_trace()
if len(sys.argv) == 5:
     r = float(sys.argv[1])
     a = float(sys.argv[2])
     z = float(sys.argv[3])
     e = float(sys.argv[4])
else:
    print("ERROR: User did not supply 4 parameters for LV model (r a z e)")
    sys.exit()

#print (str(sys.argv[1:5]))

t = sc.linspace(0, 15,  1000)

K = 35
R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0]) 

## FUNCTIONS ##

def dCR_dt(pops, t=0):
    """ """
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1-(R / K)) - a * R * C 
    dCdt = -z * C + e * a * R * C
    return sc.array([dRdt, dCdt])

##########################

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics. \n r=%.2f, a=%.2f, z=%.2f, e=%.2f K=%d' % (r, a, z, e, K))
#p.show()# To display the figure

f1.savefig('../Output/LV2_model.pdf') #Save figure

f2 = p.figure()

p.plot(pops[:,0], pops[:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics. \n r=%.2f, a=%.2f, z=%.2f, e=%.2f K=%d' % (r, a, z, e, K))
#p.show()# To display the figure

f2.savefig('../Output/LV2_model_circ.pdf')

