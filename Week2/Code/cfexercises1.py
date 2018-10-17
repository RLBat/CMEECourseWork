#!/usr/bin/env python3

""" Exercises detailing the usage of control statements and control flow """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

# Prints hello 15 times
for i in range(3, 17):
    print ('hello')

# Prints hello for each number exactly divisible by 3 between 0 and 12 (4 times)
for j in range(12):
    if j % 3 == 0:
        print ('hello')

# Prints hello for each number that gives a remainder of three when dividing \
# by 4 or the same when dividiby by 5. Prints 5 times. 
for j in range(15):
    if j % 5 == 3:
        print ('hello')
    elif j % 4 == 3:
        print ('hello')

# If z is less than 15, hello prints then 3 is added to z. Prints 4 times.
z = 0
while z != 15:
    print ('hello')
    z = z + 3

# Runs from initial value of z (12) until 100.
z = 12
while z < 100:
    if z == 31: # When z = 31
        for k in range(7):
            print ('hello') # Prints "hello" for each value of k (7 times)
    elif z == 18:
        print ('hello') # Prints hello when z = 18
    z = z +1 # Adds 1 to z
