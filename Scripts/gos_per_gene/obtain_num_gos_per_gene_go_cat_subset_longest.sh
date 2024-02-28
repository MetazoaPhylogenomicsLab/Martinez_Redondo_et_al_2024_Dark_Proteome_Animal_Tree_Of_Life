#!/bin/bash
#For eggnog None includes filtering to keep only the ones that cdhit retains
#EGGNOG LONGEST
while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit/${SP}_output_for_IC_eggnog.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="eggnog"
	FILTER="None"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_eggnog_filtered_goterms_cdhit_depth/${SP}_output_for_IC_eggnog_filtered_depth.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="eggnog"
	FILTER="depth"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

#DEEPGOPLUS LONGEST
while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus/${SP}_output_for_IC_deepgoplus.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="None"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_depth/${SP}_output_for_IC_longiso_deepgoplus_filtered_depth.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="depth"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_thresholds/${SP}_output_for_IC_deepgoplus_longest_isoforms_filtered.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="threshold"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_deepgoplus_filtered_thresholds_depth/${SP}_output_for_IC_longiso_deepgoplus_filtered_thresholds_depth.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="deepgoplus"
	FILTER="threshold_depth"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

#GOPREDSIM PROTT5 LONGEST
while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_prott5/${SP}_output_for_IC_longiso_gopredsim_prott5.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="gopredsim_prott5"
	FILTER="None"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_prott5_filtered_thresholds/${SP}_output_for_IC_filtered_gopredsim.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="gopredsim_prott5"
	FILTER="threshold"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

#GOPREDSIM SEQVEC LONGEST
while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_seqvec/${SP}_output_for_IC_longiso_gopredsim_seqvec.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="gopredsim_seqvec"
	FILTER="None"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt

while read -r SP
do
	NUM=$(cut -f1,2 $WD/Dark_proteome/ic_content/IC_longest_isoforms_gopredsim_seqvec_filtered_thresholds/${SP}_output_for_IC_filtered_gopredsim_seqvec.tsv | sort | uniq -c)
	ISOFORMS="longest"
	PROGRAM="gopredsim_seqvec"
	FILTER="threshold"
	printf '%s\t%s\t%s\n' $NUM | awk 'NF'| sed -E "s/$/\t$ISOFORMS\t$PROGRAM\t$FILTER/g" >> go_per_gene_filters_stats_go_cat.txt
done < $WD/Dark_proteome/subset_sp.txt
