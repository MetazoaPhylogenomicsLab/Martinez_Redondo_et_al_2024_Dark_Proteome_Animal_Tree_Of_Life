#!/bin/bash

SPECIES=$1

#1) Obtain gene lists (cut -f1 IC_FILE > GENE_LIST)
#EGGNOG SUBSET LONGEST ISOFORMS DEPTH
cut -f1 $WD/ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit_depth/${SPECIES}_output_for_IC_eggnog_filtered_depth.tsv  | uniq > $WD/Semsim/genes_to_analyze/eggnog_longest_depth/${SPECIES}_gene_list.txt

#GOPREDSIM SEQVEC SUBSET LONGEST ISOFORMS THRESHOLD
cut -f1 $WD/ic_content/IC_longest_isoforms_gopredsim_seqvec_filtered_thresholds/${SPECIES}_output_for_IC_filtered_gopredsim_seqvec.tsv | uniq > $WD/Semsim/genes_to_analyze/gopredsim_seqvec_longest_threshold/${SPECIES}_gene_list.txt

#2) Obtain common genes (python3 $WD/Semsim/obtain_common_genes.py OUT FILE1 FILE2...)
python3 $WD/Semsim/obtain_common_genes.py $WD/Semsim/common_genes/longest_eggnog_seqvec_go_category/${SPECIES}_common_genes.txt $WD/Semsim/genes_to_analyze/eggnog_longest_depth/${SPECIES}_gene_list.txt $WD/Semsim/genes_to_analyze/gopredsim_seqvec_longest_threshold/${SPECIES}_gene_list.txt

#3) Obtain GO terms & their GO category (grep -f COMMON_GENES IC_RESULTS |cut -f1-3 > GO_COMMON)
#EGGNOG SUBSET LONGEST ISOFORMS DEPTH
grep -wf $WD/Semsim/common_genes/longest_eggnog_seqvec_go_category/${SPECIES}_common_genes.txt $WD/ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit_depth/${SPECIES}_output_for_IC_eggnog_filtered_depth.tsv | cut -f1-3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog.txt

#GOPREDSIM SEQVEC SUBSET LONGEST ISOFORMS THRESHOLD
grep -wf $WD/Semsim/common_genes/longest_eggnog_seqvec_go_category/${SPECIES}_common_genes.txt $WD/ic_content/IC_longest_isoforms_gopredsim_seqvec_filtered_thresholds/${SPECIES}_output_for_IC_filtered_gopredsim_seqvec.tsv | cut -f1-3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec.txt

#4) Obtain GO terms per GO category
#EGGNOG SUBSET LONGEST ISOFORMS DEPTH
grep "biological_process" $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog.txt | cut -f1,3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog_bp.txt
grep "molecular_function" $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog.txt | cut -f1,3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog_mf.txt
grep "cellular_component" $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog.txt | cut -f1,3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog_cc.txt
rm $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog.txt

#GOPREDSIM SEQVEC SUBSET LONGEST ISOFORMS THRESHOLD
grep "biological_process" $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec.txt | cut -f1,3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec_bp.txt
grep "molecular_function" $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec.txt | cut -f1,3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec_mf.txt
grep "cellular_component" $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec.txt | cut -f1,3 > $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec_cc.txt
rm $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec.txt

#5) Obtain semantic similarity (python3 $WD/Semsim/calculate_semsim.py FILE1 FILE2 OUT)
source $WD/Isoforms_Semsim/pygosemsim_venv/bin/activate

#eggnog-seqvec BP
python3 $WD/Semsim/calculate_semsim.py -i $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog_bp.txt -I $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec_bp.txt -o $WD/Semsim/SemSim/longest_eggnog_seqvec_go_category/${SPECIES}_semsim_eggnog_depth_seqvec_threshold_bp.txt

#eggnog-seqvec MF
python3 $WD/Semsim/calculate_semsim.py -i $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog_mf.txt -I $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec_mf.txt -o $WD/Semsim/SemSim/longest_eggnog_seqvec_go_category/${SPECIES}_semsim_eggnog_depth_seqvec_threshold_mf.txt

#eggnog-seqvec CC
python3 $WD/Semsim/calculate_semsim.py -i $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/eggnog_longest_depth/${SPECIES}_common_genes_go_eggnog_cc.txt -I $WD/Semsim/common_genes_go/longest_eggnog_seqvec_go_category/gopredsim_seqvec_longest_threshold/${SPECIES}_common_genes_go_seqvec_cc.txt -o $WD/Semsim/SemSim/longest_eggnog_seqvec_go_category/${SPECIES}_semsim_eggnog_depth_seqvec_threshold_cc.txt
