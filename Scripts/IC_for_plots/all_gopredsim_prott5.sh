#!/bin/bash

cd $WD/Dark_proteome/plots_analysis/ic_filters/

#ALL GOPREDSIM PROTT5
while read -r SP
do
	cut -f2,6 $WD/Dark_proteome/ic_content/IC_all_isoforms_gopredsim_prott5/${SP}_output_for_IC_alliso_gopredsim_prott5.tsv >> genes_annotated_ic_all_gopredsim_prott5_none.txt
done < $WD/Dark_proteome/all_species.txt

grep biological_process genes_annotated_ic_all_gopredsim_prott5_none.txt |cut -f2 > genes_annotated_ic_all_gopredsim_prott5_none_bp.txt
grep molecular_function genes_annotated_ic_all_gopredsim_prott5_none.txt |cut -f2 > genes_annotated_ic_all_gopredsim_prott5_none_mf.txt
grep cellular_component genes_annotated_ic_all_gopredsim_prott5_none.txt |cut -f2 > genes_annotated_ic_all_gopredsim_prott5_none_cc.txt
