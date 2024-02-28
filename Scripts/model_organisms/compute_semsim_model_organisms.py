#!/usr/bin/env/python
from pygosemsim import graph
G=graph.from_resource("/lustre/home/ibe/gimartinez/GOPredSim_model_organisms/compare_similarity/go")
from pygosemsim import similarity
from pygosemsim import term_set
import functools
import sys
sf = functools.partial(term_set.sim_func, G, similarity.wang)

file_all_isoforms=sys.argv[1]
file_longiso=sys.argv[2]
outfile=sys.argv[3]

go_all_isoforms={}
with open(file_all_isoforms,"rt") as allisofile:
        line=allisofile.readline().strip()
        while line:
                gene,goterms=line.split("\t")
                if gene not in go_all_isoforms.keys():
                        go_all_isoforms[gene]=[goterms]
                else:
                        go_all_isoforms[gene].append(goterms)
                line=allisofile.readline().strip()

go_longiso={}
with open(file_longiso,"rt") as longisofile:
        line=longisofile.readline().strip()
        while line:
                gene,goterms=line.split("\t")
                if gene not in go_longiso.keys():
                        go_longiso[gene]=[goterms]
                else:
                        go_longiso[gene].append(goterms)
                line=longisofile.readline().strip()

common_genes=set(go_all_isoforms.keys()).intersection(set(go_longiso.keys()))

#num_common_go=0
#num_different_go=0
gene_similarity={}

for gene in common_genes:
        goterms_alliso=go_all_isoforms[gene]
        goterms_longiso=go_longiso[gene]
        #num_common_go=num_common_go+len(set(goterms_alliso).intersection(set(goterms_longiso)))
        diff_go_for_gene=len(set(goterms_alliso).difference(set(goterms_longiso)))
        #num_different_go=num_different_go+diff_go_for_gene
        if diff_go_for_gene !=0:
                gene_similarity[gene]=term_set.sim_bma(goterms_alliso,goterms_longiso,sf)
        else:
                gene_similarity[gene]=1.0


with open(outfile,"wt") as out:
        for gene in gene_similarity.keys():
                out.write(gene+"\t"+str(gene_similarity[gene])+"\n")
