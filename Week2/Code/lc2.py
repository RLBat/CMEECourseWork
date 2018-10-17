#!/usr/bin/env python3

""" Creates lists of both months in 1910 where rainfall was less than 50mm and
    month, rainfall tuples where rainfall exceeded 100mm. This is done via
    both loops and list comprehensions """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

# None

## Constants ##

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )


## Functions##

def is_rainfall_low(month):
    """ Finds which months had less than 50mm of rainfall """
    if month[1] < 50:
        return month

def is_rainfall_high(month):
    """ Finds which months had more than 100mm of rainfall """
    if month[1] > 100:
        return month

##############


# Creates a list of the month and amount of rainfall for months where rainfall
# exceeded 100mm using loops

High_rainfall = [] # Creates an empty list
for month in rainfall:
    if is_rainfall_high(month): # Sends to is_rainfall_high
        High_rainfall.append(month) # Appends the month and rainfall to list where True
print (High_rainfall) # Prints the new list

# Creates a list of all months in 1910 where rainfall was below 50mm using loops

Low_rainfall = []
for month in rainfall:
    if is_rainfall_low(month):
        Low_rainfall.append(month[0]) # Appends only the month not rainfall
print (Low_rainfall)

# Creates a list of the month and amount of rainfall for months where rainfall
# exceeded 100mm using list comprehension

# Sends the month to is_rainfall_high for each month in the tuple, and creates a 
# list of the returned months
High_rainfall_lc = [month for month in rainfall if is_rainfall_high(month)]
print (High_rainfall)

# Creates a list of all months in 1910 where rainfall was below 50mm 
# using list comprehension

# Same as above, but sends to is_rainfall_low and returns only the month name
Low_rainfall_lc = [month[0] for month in rainfall if is_rainfall_low(month)]
print (Low_rainfall_lc)
