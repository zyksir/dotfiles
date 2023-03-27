#!/usr/bin/env python

'''
1. run "python -m cProfile -s tottime cpuProfiler.py 1000 '^(import|\s*def)[^,]*$' *.py"
2. find we spend most time in "io.open" and "re.compile"
3. get optimization solution: only open file and compile pattern once!
'''

import sys, re

def grep(pattern, file):
    with open(file, 'r') as f:
        print(file)
        for i, line in enumerate(f.readlines()):
            pattern = re.compile(pattern)
            match = pattern.search(line)
            if match is not None:
                print("{}: {}".format(i, line), end="")

if __name__ == '__main__':
    times = int(sys.argv[1])
    pattern = sys.argv[2]
    for i in range(times):
        for file in sys.argv[3:]:
            grep(pattern, file)