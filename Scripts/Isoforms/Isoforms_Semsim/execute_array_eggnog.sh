#!/bin/bash

SPECIES=$1

source pygosemsim_venv/bin/activate

python3 calculate_semsim_all_isoforms_vs_longest_go_categories.py -i eggnog-mapper/data/${SPECIES}_all_isoforms.txt -I eggnog-mapper/data/${SPECIES}_longiso.txt -o eggnog-mapper/SemSim_GO_cat/${SPECIES}_semsim_go_cat.txt
