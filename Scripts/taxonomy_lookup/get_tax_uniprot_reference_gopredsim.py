#!/usr/bin/env/python
'''
Script created by Gemma I. Martinez-Redondo to obtain Uniprot ID and organism taxon that was used to transfer GO terms in GOPredSiM.
Usage:
        python get_tax_uniprot_reference_gopredsim.py -i gopredsim.out -l gopredsim_lookup.txt -u uniprot_taxa_metadata.dat [ -o outfile.txt]
'''

import functools, argparse, re
from pathlib import Path

#Define parsing of the command
def parser():
	args = argparse.ArgumentParser(description='Obtain Uniprot ID and organism taxon used to trasnfer GO terms in GOPredSim.')
	args.add_argument('-i', '--infile', required=True, help="Output of GOPredSim combining all 3 ontologies.")
	args.add_argument('-l', '--lookup', required=True, help="Lookup table used by GOPredSim to transfer GO terms. It contains Uniprot IDs in the first column and a comma-separated list of GO terms in the second column.")
	args.add_argument('-u', '--uniprot_taxa', required=True, help="File containing the taxonomical group of each Uniprot ID (tab-separated, first column Uniprot ID).")
	args.add_argument('-o', '--outfile', required=False, help="Path to the output file. If not provided, 'input1.out' will be used as default.")
	args=args.parse_args()
	return args

#Obtain arguments
file = parser().infile
outfile = parser().outfile
lookup = parser().lookup
uniprot_taxa = parser().uniprot_taxa

#Use defaults if optional arguments not given
if not outfile:
	p=Path(file)
	extensions="".join(p.suffixes)
	file_name=str(p).replace(extensions, "")
	outfile=file_name+".out"

#Define functions
#Obtain go terms per gene (output: dictionary, genes as keys)
def obtain_go_terms_per_gene(file):
	go_dict={}
	with open(file,"rt") as opened_file:
		line=opened_file.readline().strip()
		while line:
			gene,goterms,ri=line.split("\t")
			if gene not in go_dict.keys():
				go_dict[gene]=set([goterms])
			else:
				go_dict[gene].add(goterms)
			line=opened_file.readline().strip()
	return go_dict

#Obtain taxonomic rank per Uniprot ID (output: dictionary, Uniprot IDs as keys)
def obtain_taxon_per_uniprot_id(file):
	id_taxon={}
	with open(file,"rt") as opened_file:
		line=opened_file.readline().strip()
		while line:
			id,taxon=line.split("\t")
			if id not in id_taxon.keys():
				id_taxon[id]=taxon
			elif id_taxon[id]!=taxon:
				if taxon=="human":
					if id_taxon[id] in ['mammals','vertebrates','animals']:
						continue
					elif id_taxon[id]=="rodents":
						id_taxon[id]=="mammals"
					elif id_taxon[id]=="invertebrates":
						id_taxon[id]="animals"
					else:
                                                raise Exception("Conflicting taxonomy found: "+taxon+" and "+id_taxon[id]+" for "+id)
				elif taxon=="rodents":
					if id_taxon[id]=="human":
						id_taxon[id]=="mammals"
					elif id_taxon[id] in ['mammals','vertebrates','animals']:
                                                continue
					elif id_taxon[id]=="invertebrates":
                                                id_taxon[id]="animals"
					else:
                                                raise Exception("Conflicting taxonomy found: "+taxon+" and "+id_taxon[id]+" for "+id)
				elif taxon=="mammals":
					if id_taxon[id] in ["vertebrates",'animals']:
						continue
					elif id_taxon[id] in ["human","rodents"]:
						id_taxon[id]=taxon
					elif id_taxon[id]=="invertebrates":
                                                id_taxon[id]="animals"
					else:
						raise Exception("Conflicting taxonomy found: "+taxon+" and "+id_taxon[id]+" for "+id)
				elif taxon=="vertebrates":
					if id_taxon[id] in ["mammals","human","rodents"]:
						id_taxon[id]=taxon
					elif id_taxon[id]=="invertebrates":
						id_taxon[id]="animals"
					elif id_taxon[id]=="animals":
						continue
					else:
						raise Exception("Conflicting taxonomy found: "+taxon+" and "+id_taxon[id]+" for "+id)
				elif taxon=="invertebrates":
					if id_taxon[id] in ["mammals","human","rodents","vertebrates"]:
						id_taxon[id]="animals"
					elif id_taxon[id]=="animals":
						continue
					else:
                                                raise Exception("Conflicting taxonomy found: "+taxon+" and "+id_taxon[id]+" for "+id)
				else:
					id_taxon[id]=id_taxon[id]+","+taxon
					print("Conflicting taxonomy found: "+taxon+" and "+id_taxon[id]+" for "+id)
			line=opened_file.readline().strip()
	return id_taxon

#Obtain go terms per Uniprot ID (output: dictionary, GO terms sets as keys)
def obtain_go_terms_per_uniprot_id(file):
	go_dict={}
	with open(file,"rt") as opened_file:
		line=opened_file.readline().strip()
		while line:
			id,goterms=line.split("\t")
			if id not in go_dict.keys():
				go_dict[id]=set(goterms.split(","))
			else:
				raise Exception("GO terms from ID "+id+" are already present in the data.")
			line=opened_file.readline().strip()
	return go_dict


#Script starts here
#Obtain needed dictionaries
gene_go=obtain_go_terms_per_gene(file)
id_taxon=obtain_taxon_per_uniprot_id(uniprot_taxa)
id_gos=obtain_go_terms_per_uniprot_id(lookup)

#Save results
genes_done=[]
with open(outfile,"wt") as out:
	for gene in gene_go.keys():
		for uniprot_id in id_gos.keys():
			gene_gos=gene_go[gene]
			uniprot_gos=id_gos[uniprot_id]
			if gene_gos==uniprot_gos:
				try:
					taxonomy=id_taxon[uniprot_id]
				except KeyError:
					taxonomy="unknown"
				out.write(gene+"\t"+uniprot_id+"\t"+taxonomy+"\n")
				print(gene+" OK")
				genes_done.append(gene)
				break
			else:
				continue

with open(outfile+".failed_genes","wt") as out:
	for gene in set(gene_go.keys())-set(genes_done):
		out.write(gene+"\n")
