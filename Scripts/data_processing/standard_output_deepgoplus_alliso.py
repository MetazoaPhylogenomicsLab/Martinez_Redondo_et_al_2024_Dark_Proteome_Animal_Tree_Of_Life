# This script transforms the output of DeepGOPlus having into account the isoforms to an output like the following:
# gene1  goterm1, goterm2, goterm3
# gene2  goterm1, goterm2, goterm3

# Execution: python3 standard_output_deepgoplus_alliso.py SPECIES_deepgoplus.txt SPECIES_deepgoplus.standard.alliso.txt

f = open(sys.argv[1], 'r')
f_out = open(sys.argv[2], 'w')
result = dict()

for line in f:
    line = line.strip().split('\t')
    gene = line[0]
    gene = gene.split("_i")[0]
    go_terms = set()
    for term in line[1:]:
        go_term = term.split('|')[0]
        go_terms.add(go_term)
    if gene in result:
        result[gene].update(go_terms)
    else:
        result[gene] = go_terms

for k, v in result.items():
    f_out.write(f"{k}\t{', '.join(v)}\n")
