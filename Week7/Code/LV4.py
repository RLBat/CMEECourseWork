#!/usr/bin/env python3

""" Constructs a Lotka-Volterra Model given user inputs, 
    and produces graphs of both species over (discrete) time and both species 
    in relation to each other with random fluctuations in growth rate """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import sys
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p
import numpy as np

## CONSTANTS ##

if len(sys.argv) == 5:
     r = float(sys.argv[1])
     a = float(sys.argv[2])
     z = float(sys.argv[3])
     e = float(sys.argv[4])
else:
    print("ERROR: User did not supply 4 parameters for LV model (r a z e)")
    sys.exit()

t = list(range(0, 20))

K = 35
R0 = 10
C0 = 5 
RC0 = sc.array([[R0, C0]])

## FUNCTIONS ##

def R_t(pops, t=0):
    """ Defines the models for both species' growth in relation to one another 
        in discrete time """
    R = pops[0][0]
    C = pops[0][1]
    Pops = sc.array([[R,C]])
    for i in range(1,len(t)):
        epsilon=np.random.normal()
        R = R*(1+(r*epsilon)*(1-(R/K))-a*C)
        C = C*(1-z+e*a*R)
        Pops = np.append(Pops, [[R,C]], axis=0)
    return Pops

##########################

# Uses odeint to integrate the continuous differential equations
pops = R_t(RC0, t)

f1 = p.figure() # Creates an empty figure
# Defines parameters and labels for the plot of both pops over time
p.plot(t, pops[:][:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:][:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics. \n r=%.2f, a=%.2f, z=%.2f, e=%.2f K=%d' % (r, a, z, e, K))
#p.show()# To display the figure

f1.savefig('../Output/LV4_model.pdf') #Save figure to pfd


f2 = p.figure() #Creates an empty figure
# Defines parameters and labels for the circle plot (each pop against each other)
p.plot(pops[:][:,0], pops[:][:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics. \n r=%.2f, a=%.2f, z=%.2f, e=%.2f K=%d' % (r, a, z, e, K))
#p.show()# To display the figure

f2.savefig('../Output/LV4_model_circ.pdf') #Save figre to pdf

