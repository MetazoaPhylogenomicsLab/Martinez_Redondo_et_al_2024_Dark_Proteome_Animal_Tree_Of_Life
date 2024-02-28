#!/bin/bash

# This script takes as input the results from the filter_thresholds_gopredsim.py script and writes it in standard output:
# gene1    goterm1
# gene1    goterm2
# gene1    goterm3
# gene2    goterm1
# gene2    goterm2
# gene2    goterm3

# In this case we are using the ProtT5 model for GOpredSim
# Execution: bash IC_output_gopredsim.sh /INPUTPATH /DESTINATIONPATH SPECIES

INPATH=$1
OUTPATH=$2
SPECIES=$3

cat $INPATH/gopredsim_${SPECIES}_prott5_1_bpo_filtered.txt $INPATH/gopredsim_${SPECIES}_prott5_1_cco_filtered.txt $INPATH/gopredsim_${SPECIES}_prott5_1_mfo_filtered.txt > $OUTPATH/${SPECIES}_prott5_1_bpo_cco_mfo_filtered.tsv
cut -f1,2 $OUTPATH/${SPECIES}_prott5_1_bpo_cco_mfo_filtered.tsv > $OUTPATH/${SPECIES}_gopredsim_prott5.filtered.standard.tsv
