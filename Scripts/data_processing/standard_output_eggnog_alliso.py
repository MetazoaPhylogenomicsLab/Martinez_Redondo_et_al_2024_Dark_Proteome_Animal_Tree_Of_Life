# This script transforms the output of EggNOG-mapper having into account the isoforms to an output like the following:
# gene1  goterm1, goterm2, goterm3
# gene2  goterm1, goterm2, goterm3

# Execution: python3 standard_output_eggnog_alliso.py SPECIES.emapper.annotations.filtered.goterms.cdhit.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.standard_alliso.txt

import sys

f = open(sys.argv[1], 'r')
f_out = open(sys.argv[2], 'w')
result = dict()

for line in f:
    line = line.strip().split('\t')
    gene = line[0].split("_i")[0]
    go_terms = set(line[9].split(','))
    if gene in result:
        result[gene].update(go_terms)
    else:
        result[gene] = go_terms

for k, v in result.items():
    f_out.write(f"{k}\t{', '.join(v)}\n")
