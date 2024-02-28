#!/bin/bash
#For eggnog None includes filtering to keep only the ones that cdhit retains
#EGGNOG LONGEST
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_eggnog/${SP}_output_for_IC_eggnog.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="eggnog"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_eggnog_filtered_depth/${SP}_output_for_IC_eggnog_filtered_depth.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="eggnog"
	FILTER="depth"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

#EGGNOG ALL
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_all_isoforms_eggnog/${SP}_output_for_IC_alliso_eggnog.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="eggnog"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_all_isoforms_eggnog_filtered_depth/${SP}_output_for_IC_alliso_eggnog_filtered_depth.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="eggnog"
	FILTER="depth"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

#DEEPGOPLUS LONGEST
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus/${SP}_output_for_IC_deepgoplus.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_depth/${SP}_output_for_IC_longiso_deepgoplus_filtered_depth.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="depth"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_thresholds/${SP}_output_for_IC_deepgoplus_longest_isoforms_filtered.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="threshold"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_thresholds_depth/${SP}_output_for_IC_longiso_deepgoplus_filtered_thresholds_depth.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="threshold_depth"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

#DEEPGOPLUS ALL
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_all_isoforms_deepgoplus/${SP}_output_for_IC_deepgoplus.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="deepgoplus"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/
IC_all_isoforms_deepgoplus_filtered_depth/${SP}_output_for_IC_alliso_deepgoplus_filtered_depth.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="deepgoplus"
	FILTER="depth"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/
IC_all_isoforms_deepgoplus_filtered_thresholds/${SP}_output_for_IC_deepgoplus_all_isoforms_filtered.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="deepgoplus"
	FILTER="threshold"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/
IC_all_isoforms_deepgoplus_filtered_thresholds_depth/${SP}_output_for_IC_alliso_deepgoplus_filtered_thresholds_depth.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="deepgoplus"
	FILTER="threshold_depth"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

#GOPREDSIM PROTT5 LONGEST
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_prott5/${SP}_output_for_IC_longiso_gopredsim_prott5.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="gopredsim_prott5"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_prott5_filtered_thresholds/${SP}_output_for_IC_filtered_gopredsim.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="gopredsim_prott5"
	FILTER="threshold"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

#GOPREDSIM PROTT5 ALL
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_all_isoforms_gopredsim_prott5/${SP}_output_for_IC_alliso_gopredsim_prott5.tsv  | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="gopredsim_prott5"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_all_isoforms_gopredsim_prott5_filtered_thresholds/${SP}_output_for_IC_alliso_gopredsim_prott5_filtered.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="gopredsim_prott5"
	FILTER="threshold"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

#GOPREDSIM SEQVEC LONGEST
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_seqvec/${SP}_output_for_IC_longiso_gopredsim_seqvec.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="gopredsim_seqvec"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_seqvec_filtered_thresholds/${SP}_output_for_IC_filtered_gopredsim.tsv | sort | uniq | wc -l)
	ISOFORMS="longest"
	PROGRAM="gopredsim_seqvec"
	FILTER="threshold"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

#GOPREDSIM SEQVEC ALL
while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_all_isoforms_gopredsim_seqvec/${SP}_output_for_IC_alliso_gopredsim_seqvec.tsv  | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="gopredsim_seqvec"
	FILTER="None"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt

while read -r SP
do
	NUM=$(cut -f1 $WD/Dark_proteome/ic_content/IC_all_isoforms_gopredsim_seqvec_filtered_thresholds/${SP}_output_for_IC_alliso_gopredsim_seqvec_filtered.tsv | sort | uniq | wc -l)
	ISOFORMS="all"
	PROGRAM="gopredsim_seqvec"
	FILTER="threshold"
	printf '%s\t%s\t%s\t%s\t%s\n' $NUM $SP $ISOFORMS $PROGRAM $FILTER >> genes_annotated_filters_stats.txt
done < all_species.txt
