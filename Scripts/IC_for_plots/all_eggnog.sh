#!/bin/bash

cd $WD/Dark_proteome/plots_analysis/ic_filters/

#EGGNOG ALL
while read -r SP
do
	cut -f2,6 $WD/Dark_proteome/ic_content/IC_all_isoforms_eggnog_filtered_go_terms_cdhit/${SP}_output_for_IC_alliso_eggnog.tsv >> genes_annotated_ic_all_eggnog_none.txt
done < $WD/Dark_proteome/all_species.txt

grep biological_process genes_annotated_ic_all_eggnog_none.txt |cut -f2 > genes_annotated_ic_all_eggnog_none_bp.txt
grep molecular_function genes_annotated_ic_all_eggnog_none.txt |cut -f2 > genes_annotated_ic_all_eggnog_none_mf.txt
grep cellular_component genes_annotated_ic_all_eggnog_none.txt |cut -f2 > genes_annotated_ic_all_eggnog_none_cc.txt
