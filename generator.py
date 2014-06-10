import sys
import random

def main():
  f = open(sys.argv[1], 'w')
  l = int(sys.argv[2])
  d = int(sys.argv[3])

  for i in xrange(l):
    out = '%8d'%i
    for j in xrange(d):
      out += ' %.6f'%(random.random() * 4 - 2)
    f.write(out + '\n');
    
if __name__ == '__main__':
  if len(sys.argv) != 4:
    print 'Usage: python generator.py <output> length dimension'
  else:
    main()
