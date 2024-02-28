#!/usr/bin/env/python

'''
Script created by Gemma I. Martinez-Redondo to obtain the input gene-GO file for topGO from GOPredSim output.
Usage:
        python from_gopredsim_to_topgo_format.py -i gopredsim_file.txt -o topgo_file.txt -g genelist_file.txt
'''

#Import required modules
import argparse
from pathlib import Path

#Define parsing of the command
def parser():
	args = argparse.ArgumentParser(description='Obtain topGO input file from GOPredSim output.')
	args.add_argument('-i', '--infile', required=True, help="Name of the input file.")
	args.add_argument('-o', '--outfile', required=False, help="Name of the output topGO input file. If not provided, 'inputfilename_topGO.out' will be used as default.")
	args.add_argument('-g', '--genelist', required=False, help="Name of the output total list of genes annotated. If not provided, 'inputfilename_genelist.out' will be used.")
	args=args.parse_args()
	return args

#Obtain output file name
infile = parser().infile
outfile = parser().outfile
genelist = parser().genelist

if not outfile:
	p=Path(infile)
	extensions="".join(p.suffixes)
	file_name=str(p).replace(extensions, "")
	outfile=file_name+"_topGO.out"

if not genelist:
        p=Path(infile)
        extensions="".join(p.suffixes)
        file_name=str(p).replace(extensions, "")
        genelist=file_name+"_genelist.out"

#Read input
gene_go={}
with open(infile,"rt") as input:
	line=input.readline().strip()
	while line:
		gene,go,ri=line.split("\t")
		if gene not in gene_go.keys():
			gene_go[gene]=[go]
		else:
			gene_go[gene].append(go)
		line=input.readline().strip()

with open(outfile,"wt") as out:
	with open(genelist,"wt") as outlist:
		for gene in gene_go:
			out.write(gene+"\t"+",".join(gene_go[gene])+"\n")
			outlist.write(gene+"\n")
