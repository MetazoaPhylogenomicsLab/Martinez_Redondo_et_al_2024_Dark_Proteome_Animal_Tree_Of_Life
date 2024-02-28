# This script transforms the standard output to an output like the following:
# gene1    goterm1
# gene1    goterm2
# gene1    goterm3
# gene2    goterm1
# gene2    goterm2
# gene2    goterm3

# Execution python3 standard_to_IC.py SPECIES.standard.txt SPECIES.IC.txt

import sys

f = open(sys.argv[1], 'r')
f_out = open(sys.argv[2], 'w')

for line in f:
    gene, go_terms = line.strip().split('\t')
    for go_term in go_terms.split(', '):
        f_out.write(f'{gene}\t{go_term}\n')
