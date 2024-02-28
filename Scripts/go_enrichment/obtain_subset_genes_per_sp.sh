#!/bin/bash

#Script for obtaining per each species the subset of genes that were annotated by EggNOG-mapper

WD=Dark_proteome/GO_enrichment
OUT_DIR=$WD/topgo_input_files
LIST_OF_SPECIES=$WD/../all_species.txt

while read -r SPECIES
do
	cut -f1 $WD/..//ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit_depth/${SPECIES}_output_for_IC_eggnog_filtered_depth.tsv | sort | uniq > $OUT_DIR/${SPECIES}_genes_annotated_eggnog.txt
done < $LIST_OF_SPECIES
