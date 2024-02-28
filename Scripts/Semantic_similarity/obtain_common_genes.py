#!/usr/bin/env/python
import sys

outfile=sys.argv[1]
file_list=sys.argv[2:]

gene_lists=[set(line.strip() for line in open(file)) for file in file_list]

common_genes = gene_lists[0].intersection(*gene_lists[1:]) #Same as common_genes = gene_lists[0].intersection(gene_lists[1],gene_lists[2],gene_lists[3]) when file_list is length 4
#set1.intersection(set2, set3, set4, set5)

with open(outfile,"wt") as out:
        for gene in common_genes:
                out.write(gene+"\n")
