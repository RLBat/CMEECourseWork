## FOR loops in python

# Prints 0-4 on newlines
for i in range(5):
    print (i)

# Prints the list item by item
my_list = [0, 2, "geroimo!", 3.0, True, False]
for k in my_list:
    print(k)

# Prints the sum of each number plus the total of all numbers prior in the list
total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)

## WHILE loops in python

# Prints 1-100 on newlines
z = 0
while z < 100:
    z = z + 1
    print(z)

# Prints the script forever
b = True
while b:
    print("GERONIMO! Infinite loop! ctrl+c to stop!")
