#!/bin/bash

cd $WD/Dark_proteome/plots_analysis/ic_filters/

#LONGEST DEEPGOPLUS THRESHOLD DEPTH
while read -r SP
do
	cut -f2,6 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_thresholds_depth/${SP}_output_for_IC_longiso_deepgoplus_filtered_thresholds_depth.tsv >> genes_annotated_ic_longest_deepgoplus_threshold_depth.txt
done < $WD/Dark_proteome/all_species.txt

grep biological_process genes_annotated_ic_longest_deepgoplus_threshold_depth.txt |cut -f2 > genes_annotated_ic_longest_deepgoplus_treshold_depth_bp.txt
grep molecular_function genes_annotated_ic_longest_deepgoplus_threshold_depth.txt |cut -f2 > genes_annotated_ic_longest_deepgoplus_treshold_depth_mf.txt
grep cellular_component genes_annotated_ic_longest_deepgoplus_threshold_depth.txt |cut -f2 > genes_annotated_ic_longest_deepgoplus_treshold_depth_cc.txt