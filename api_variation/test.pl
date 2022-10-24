import sys

filename = sys.argv[1]
print (filename)

f = open(filename)
for line in f:
    line = line.rstrip('\n')
    print(line)
 
