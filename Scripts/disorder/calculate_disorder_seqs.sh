#!/bin/bash
WD=Dark_proteome
source $WD/disorder/iupred_venv/bin/activate

SP_FILE=$WD/disorder/subset_sp.txt

SPECIES=$1

SEQ_FILE=${SPECIES}_longiso.pep

python3 $WD/disorder/iupred3/iupred3_multifasta.py $SEQ_FILE long > Results/${SPECIES}_disorder.txt
