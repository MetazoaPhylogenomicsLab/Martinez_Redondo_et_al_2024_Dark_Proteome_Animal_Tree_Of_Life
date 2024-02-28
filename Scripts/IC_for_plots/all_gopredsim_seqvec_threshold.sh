#!/bin/bash

cd $WD/Dark_proteome/plots_analysis/ic_filters/

#ALL GOPREDSIM SEQVEC THRESHOLD
while read -r SP
do
	cut -f2,6 $WD/Dark_proteome/ic_content/IC_all_isoforms_gopredsim_seqvec_filtered_thresholds/${SP}_output_for_IC_alliso_gopredsim_seqvec_filtered.tsv >> genes_annotated_ic_all_gopredsim_seqvec_threshold.txt
done < $WD/Dark_proteome/all_species.txt

grep biological_process genes_annotated_ic_all_gopredsim_seqvec_threshold.txt |cut -f2 > genes_annotated_ic_all_gopredsim_seqvec_threshold_bp.txt
grep molecular_function genes_annotated_ic_all_gopredsim_seqvec_threshold.txt |cut -f2 > genes_annotated_ic_all_gopredsim_seqvec_threshold_mf.txt
grep cellular_component genes_annotated_ic_all_gopredsim_seqvec_threshold.txt |cut -f2 > genes_annotated_ic_all_gopredsim_seqvec_threshold_cc.txt
