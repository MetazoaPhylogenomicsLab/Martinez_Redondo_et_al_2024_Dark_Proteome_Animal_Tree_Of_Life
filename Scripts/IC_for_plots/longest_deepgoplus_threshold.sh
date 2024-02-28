#!/bin/bash

cd $WD/Dark_proteome/plots_analysis/ic_filters/

#LONGEST DEEPGOPLUS THRESHOLD
while read -r SP
do
	cut -f2,6 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_thresholds/${SP}_output_for_IC_deepgoplus_longest_isoforms_filtered.tsv >> genes_annotated_ic_longest_deepgoplus_threshold.txt
done < $WD/Dark_proteome/all_species.txt

grep biological_process genes_annotated_ic_longest_deepgoplus_threshold.txt |cut -f2 > genes_annotated_ic_longest_deepgoplus_threshold_bp.txt
grep molecular_function genes_annotated_ic_longest_deepgoplus_threshold.txt |cut -f2 > genes_annotated_ic_longest_deepgoplus_threshold_mf.txt
grep cellular_component genes_annotated_ic_longest_deepgoplus_threshold.txt |cut -f2 > genes_annotated_ic_longest_deepgoplus_threshold_cc.txt
