#!/usr/bin/env/python
'''
Script created by Gemma I. Martinez-Redondo to obtain semantic similarity of GO terms between two lists of all isoforms vs longest.
Usage:
        python calculate_semsim.py -i infile1.txt -I infile2.txt [-o outfile.txt] [--f] [-g go.obo]
'''

from pygosemsim import graph
from pygosemsim import similarity
from pygosemsim import term_set
import functools, argparse, re
from pathlib import Path

#Define parsing of the command
def parser():
	args = argparse.ArgumentParser(description='Obtain semantic similarity between genes taking into account longest and all isoforms.')
	args.add_argument('-i', '--infile1', required=True, help="Name of the first input file. One column per gene-GO.pair. Input 1 and 2 must have some genes in common.")
	args.add_argument('-I', '--infile2', required=True, help="Name of the second input file. One column per gene-GO pair. Input 1 and 2 must have some genes in common.")
	args.add_argument('-o', '--outfile', required=False, help="Path to the output file. If not provided, 'input1.out' will be used as default.")
	args.add_argument('-g', '--gofile', required=False, help="Path to the Gene Ontology go.obo file. If not provided, '/mnt/netapp2/Store_csbyegim/Dark_proteome/go' will be used.")
	args.add_argument('-f', '--fuse_categories', required=False, action='store_true', help="If provided, GO categories will not be taken into account and will be assessed together.")
	args=args.parse_args()
	return args

#Obtain arguments
file1 = parser().infile1
file2 = parser().infile2
outfile = parser().outfile
gofile = parser().gofile
fusecats = parser().fuse_categories

#Use defaults if optional arguments not given
if not outfile:
	p=Path(file1)
	extensions="".join(p.suffixes)
	file_name=str(p).replace(extensions, "")
	outfile=file_name+".out"

if not gofile:
	gofile='/mnt/netapp2/Store_csbyegim/Dark_proteome/go'
else:
	p=Path(gofile)
	extensions="".join(p.suffixes)
	gofile=str(p).replace(extensions, "")

#Read GO file
G=graph.from_resource(gofile)

#Define functions
#Method for semantic similarity
sf = functools.partial(term_set.sim_func, G, similarity.wang)
#Obtain go terms per gene (output: dictionary)
def obtain_go_terms_per_gene(file):
	go_dict={}
	with open(file,"rt") as opened_file:
		line=opened_file.readline().strip()
		while line:
			isoform,goterms=line.split("\t")
			gene=isoform.split("_i")[0]
			if gene not in go_dict.keys():
				go_dict[gene]=[goterms]
			else:
				go_dict[gene].append(goterms)
			line=opened_file.readline().strip()
	return go_dict

def parse_obo(FILEPATH):
    regex = re.compile("alt_id: (GO:.*)\n")
    with open(FILEPATH, "r") as fread:
        data = [
            [y]
            + [
                y.split(": ")[1].strip()
                for y in x.strip().split("\n")
                if y and ":" in y
            ][1:3]
            for x in fread.read().replace(";", ",").split("\n\n")
            if x and ("[Term]" in x)
            for y in (
                [x.strip().split("\n")[1].split(": ")[
                    1].strip()] + regex.findall(x)
            )
        ]
    return {x[0]: x[1::] for x in data}

def obtain_category_for_goterms(golist,G):
	new_golist={}
	for goterm in golist:
		if obo.get(goterm, None) is not None:
			category = obo[goterm][1]
			if category not in new_golist.keys():
				new_golist[category]=[goterm]
			else:
				new_golist[category].append(goterm)
	return new_golist

obo=parse_obo(gofile+".obo")

go1=obtain_go_terms_per_gene(file1)
go2=obtain_go_terms_per_gene(file2)

common_genes=set(go1.keys()).intersection(set(go2.keys()))

if len(common_genes)==0:
	raise Exception("Input files do not have any genes in common")

gene_similarity={}

if fusecats:
	for gene in common_genes:
		goterms1=go1[gene]
		goterms2=go2[gene]
		diff_go_for_gene=len(set(goterms1).difference(set(goterms2)))
		if diff_go_for_gene !=0:
			gene_similarity[gene]=term_set.sim_bma(goterms1,goterms2,sf)
		else:
		      	gene_similarity[gene]=1.0
else:
	go1={gene: obtain_category_for_goterms(golist,obo) for (gene,golist) in go1.items()}
	go2={gene: obtain_category_for_goterms(golist,obo) for (gene,golist) in go2.items()}
	for gene in common_genes:
		for category in ("biological_process","molecular_function","cellular_component"):
			try:
				goterms1=go1[gene][category]
			except KeyError:
				continue
			try:
				goterms2=go2[gene][category]
			except KeyError:
				continue
			diff_go_for_gene=len(set(goterms1).difference(set(goterms2)))
			if diff_go_for_gene !=0:
				genesim=[term_set.sim_bma(goterms1,goterms2,sf),category]
			else:
				genesim=[1.0,category]
			if gene not in gene_similarity.keys():
				gene_similarity[gene]=[genesim]
			else:
				gene_similarity[gene].append(genesim)


with open(outfile,"wt") as out:
	for gene in gene_similarity.keys():
		if fusecats:
			out.write(gene+"\t"+str(gene_similarity[gene])+"\n")
		else:
			for category in range(len(gene_similarity[gene])):
				try:
					out.write(gene+"\t"+str(gene_similarity[gene][category][0])+"\t"+gene_similarity[gene][category][1]+"\n")
				except:
					continue
