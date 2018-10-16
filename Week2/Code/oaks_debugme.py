import csv
import sys
import doctest
import ipdb

#Define function
def is_an_oak(name):
    """ Tests to see if the function can correctly identify oaks

    >>> is_an_oak("Quercus, robur")
    True

    >>> is_an_oak("Fraxinus, excelsior")
    False

    >>> is_an_oak("Quercus robur")
    False

    >>> is_an_oak("Quercs, robur")
    False

    >>> is_an_oak("Quercusoba, rubinous")
    False

    >>> is_an_oak("robor, Quercus")
    False

    >>> is_an_oak("QUERCUS, ROBOR")
    True

    >>> is_an_oak("quercus, robor")
    True

    >>> is_an_oak("Quercus")
    True

    >>> is_an_oak(365)
    False

    >>> is_an_oak(True)
    False

    >>> is_an_oak("Pseudoquercus, confiscuous")
    False

    >>> is_an_oak(" Quercus, robor")
    True

    """
    name = str(name).lower()
    name = name.lstrip()
    name = name.split(",")[0]
    if len(name)!=7:
        return False
    return name.startswith("quercus")

def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Output/JustOaksData.csv','w')
    taxa = csv.reader(f)
    header = next(taxa)
    csvwrite = csv.writer(g)
    oaks = set()
    csvwrite.writerow(header)
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])
    return 0

#doctest.testmod()
if (__name__ == "__main__"):
    status = main(sys.argv)