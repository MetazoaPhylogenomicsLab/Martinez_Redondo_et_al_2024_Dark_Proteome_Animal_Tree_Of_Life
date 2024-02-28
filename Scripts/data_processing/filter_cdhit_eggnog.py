# This script creates files that contain the genes that cdhit has removed from the original data and removes them from eggnog output

# Execution: filter_cdhit_eggnog.py SPECIES.pep SPECIES_cdhit100.pep SPECIES_genes_cdhit_removed.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.txt SPECIES.emapper.annotations.filtered.goterms.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.txt

import sys

records_1 = SeqIO.parse(sys.argv[1], "fasta")
records_2 = SeqIO.parse(sys.argv[2]"fasta")
fout = open(sys.argv[3], 'w')
st_1 = set()
st_2 = set()

for record_1 in records_1:
    st_1.add(record_1.id)

for record_2 in records_2:
    st_2.add(record_2.id)

for i in st_1:
    if i not in st_2:
        fout.write(i + '\n')


f = open(sys.argv[3], 'r')
genes = set()

for gene in f:
    if gene.strip() not in genes:
        genes.add(gene.strip())

f2 = open(sys.argv[4], 'r')
fout2 = open(sys.argv[5], 'w') 

for line2 in f2:
    if line2.split()[0] not in genes:
        fout2.write(line2)
