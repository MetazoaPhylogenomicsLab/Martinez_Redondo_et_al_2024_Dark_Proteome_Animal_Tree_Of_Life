#!/bin/bash

SP_FILE=$WD/subset_sp.txt

SPECIES=$(awk -v num_line=$SLURM_ARRAY_TASK_ID '{if(NR==num_line) print $1}' $SP_FILE)

grep -f $WD/Semsim/common_genes/longest_eggnog_deepgoplus_go_category/${SPECIES}_common_genes.txt $WD/ic_content/IC_longest_isoforms_deepgoplus_filtered_thresholds_depth/${SPECIES}_output_for_IC_longiso_deepgoplus_filtered_thresholds_depth.tsv | cut -f1,2,6 | sed "s/cellular_component/CC/g; s/molecular_function/MF/g; s/biological_process/BP/g" > IC_semsim/${SPECIES}_deepgoplus_IC.txt
grep -f $WD/Semsim/common_genes/longest_eggnog_deepgoplus_go_category/${SPECIES}_common_genes.txt $WD/ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit_depth/${SPECIES}_output_for_IC_eggnog_filtered_depth.tsv | cut -f1,2,6 | sed "s/cellular_component/CC/g; s/molecular_function/MF/g; s/biological_process/BP/g" > IC_semsim/${SPECIES}_eggnog_IC.txt
grep -f $WD/Semsim/common_genes/longest_eggnog_prott5_go_category/${SPECIES}_common_genes.txt $WD/ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit_depth/${SPECIES}_output_for_IC_eggnog_filtered_depth.tsv | cut -f1,2,6 | sed "s/cellular_component/CC/g; s/molecular_function/MF/g; s/biological_process/BP/g" > IC_semsim/${SPECIES}_eggnog_prott5_IC.txt
grep -f $WD/Semsim/common_genes/longest_eggnog_prott5_go_category/${SPECIES}_common_genes.txt $WD/ic_content/IC_longest_isoforms_gopredsim_prott5_filtered_thresholds/${SPECIES}_output_for_IC_filtered_gopredsim.tsv | cut -f1,2,6 | sed "s/cellular_component/CC/g; s/molecular_function/MF/g; s/biological_process/BP/g" > IC_semsim/${SPECIES}_prott5_IC.txt
