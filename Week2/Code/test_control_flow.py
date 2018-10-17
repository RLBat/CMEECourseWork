#!/usr/bin/env python3

""" Some functions exemplifying the use of control statements 
    with embedded docscripts for debugging """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import sys # module to interface out program with the operating system
import doctest

## CONSTANTS ##

# None

## FUNCTIONS ##

def even_or_odd(x=0): # x = num gives a difault value if there's no input
    """Find whether a number x is even or odd.

    >>> even_or_odd(10)
    '10 is Even!'

    >>> even_or_odd(5)
    '5 is Odd!'

    whenever a float is provided, then the closest integer is used:    
    >>> even_or_odd(3.2)
    '3 is Odd!'

    in case of negative numbers, the positive is taken:    
    >>> even_or_odd(-2)
    '-2 is Even!'

    """
    if x % 2 == 0: # is x exactly divisible by 2
        return "%d is Even!" % x
    return "%d is Odd!" % x

def largest_divisor_five(x=120):
    """Find which is he largest divisor of x among 2,3,4,5."""
    largest = 0
    if x % 5 == 0: # Is x exactly divisible by 5
        largest = 5 # If so, set largest as 5
    elif x % 4 == 0:
        largest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 == 0:
        largest = 2
    else:
        return "No divisor found for %d!" % x # If no divisor <=5 found
    return "The largest divisor of %d is %d" % (x, largest)

def is_prime(x=70):
    """Find whether an interger is prime"""
    for i in range(2, x): # Starts the loop at 2
        if x % i == 0: # If x divides exactly by i
            print("%d is not a prime: %d is a divisor" % (x,i))
                #Print formatted text "%d %s %f %e" % (20, "30", 0.0003, 0.00003)
            return False
    print ("%d is a prime!" % x)
    return True

def find_all_primes (x=22):
    """Find all the primes up to x"""
    allprimes = [] # Creates an empty list
    for i in range(2, x + 1):
        if is_prime(i): # Sends i to is_prime function
            allprimes.append(i) # Appends to list if i_prime returns True
    print("There are %d primes between 2 and %d" % (len(allprimes), x))
    return allprimes

## Commented out to avoid just running the script. We only want to run tests

#def main(argv):
#    """ Main entry point of the program """
#    print(even_or_odd(22))
#    print(even_or_odd(33))
#    print(largest_divisor_five(120))
#    print(largest_divisor_five(121))
#    print(is_prime(60))
#    print(is_prime(59))
#    print(find_all_primes(100))
#    return 0 ## Gives a value for status

#####################

#if __name__ == "__main__":
#    """ Makes sure the "main" function is called from command line"""
#    status = main(sys.argv)
#    sys.exit(status) ## 0 causes the program to terminate

doctest.testmod() ## Runs the script with embedded tests
