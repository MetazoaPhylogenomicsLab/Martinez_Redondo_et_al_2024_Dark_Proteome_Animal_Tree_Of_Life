#!/usr/bin/bash

#Script created to obtain TopGO input files for a series of species

WD=Dark_proteome/GO_enrichment
SP_FILE=$WD/../all_species.txt
TOPGO_INPUT_DIR=$WD/topgo_input_files
GENE_LIST_DIR=$WD/topgo_input_files
GOPREDSIM_DIR=Drago_backup/longest_isoforms_gopredsim

mkdir $WD/temp

while read -r SPECIES
do

#Obtain temp file with all GOPredSim annotations
cat $GOPREDSIM_DIR/${SPECIES}_GOPredSim/${SPECIES}_prott5/gopredsim_${SPECIES}_prott5_1_*.txt > $WD/temp/gopredsim_${SPECIES}_prott5.txt

#Execute script for obtaining input files
python from_gopredsim_to_topgo_format.py -i $WD/temp/gopredsim_${SPECIES}_prott5.txt -o $TOPGO_INPUT_DIR/${SPECIES}_topGO_input.txt -g $GENE_LIST_DIR/${SPECIES}_genelist.txt

#Remove temp file
rm $WD/temp/gopredsim_${SPECIES}_prott5.txt

done < $SP_FILE

rmdir $WD/temp
