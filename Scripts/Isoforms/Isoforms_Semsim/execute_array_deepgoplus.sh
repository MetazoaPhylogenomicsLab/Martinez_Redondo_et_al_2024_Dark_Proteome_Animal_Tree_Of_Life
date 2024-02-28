#!/bin/bash

SPECIES=$1

source pygosemsim_venv/bin/activate

python3 calculate_semsim_all_isoforms_vs_longest_go_categories.py -i deepgoplus/data/${SPECIES}_all_isoforms.txt -I deepgoplus/data/${SPECIES}_longiso.txt -o deepgoplus/SemSim_GO_cat/${SPECIES}_semsim_go_cat.txt
