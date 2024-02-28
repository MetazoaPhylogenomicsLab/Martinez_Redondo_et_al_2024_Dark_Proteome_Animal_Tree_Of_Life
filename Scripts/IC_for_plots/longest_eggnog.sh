#!/bin/bash

cd $WD/Dark_proteome/plots_analysis/ic_filters/

#EGGNOG LONGEST
while read -r SP
do
	cut -f2,6 $WD/Dark_proteome/ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit/${SP}_output_for_IC_eggnog.tsv >> genes_annotated_ic_longest_eggnog_none.txt
done < $WD/Dark_proteome/all_species.txt

grep biological_process genes_annotated_ic_longest_eggnog_none.txt |cut -f2 > genes_annotated_ic_longest_eggnog_none_bp.txt
grep molecular_function genes_annotated_ic_longest_eggnog_none.txt |cut -f2 > genes_annotated_ic_longest_eggnog_none_mf.txt
grep cellular_component genes_annotated_ic_longest_eggnog_none.txt |cut -f2 > genes_annotated_ic_longest_eggnog_none_cc.txt
