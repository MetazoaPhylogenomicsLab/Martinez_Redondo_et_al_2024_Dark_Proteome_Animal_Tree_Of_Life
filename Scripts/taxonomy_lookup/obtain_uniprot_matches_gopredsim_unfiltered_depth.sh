#!/bin/bash

WD=Dark_proteome

GOPREDSIM_LOOKUP=GOPredSim/goPredSim/data/goa_annotations/goa_annotations_2022.txt
UNIPROT_TAXA=$WD/lookup_table_stats/

#Do only once
for db in {human,rodents,mammals,vertebrates,invertebrates,archaea,bacteria,fungi,plants,viruses}
do
gzip -d $UNIPROT_TAXA/uniprot_data/uniprot_sprot_${db}.xml.gz
grep accession $UNIPROT_TAXA/uniprot_data/uniprot_sprot_${db}.xml | cut -f2 -d">" | cut -f1 -d"<" | sort | uniq | sed -E "s/$/\t$db/g" >> $UNIPROT_TAXA/accessions_uniprot_sprot.txt
gzip $UNIPROT_TAXA/uniprot_data/uniprot_sprot_${db}.xml
done

UNIPROT_ACC=accessions_uniprot_sprot.txt
SP_FILE=$WD/subset_sp.txt

SPECIES=$(awk -v num_line=$SLURM_ARRAY_TASK_ID '{if(NR==num_line) print $1}' $SP_FILE)

cat Drago_backup/longest_isoforms_gopredsim/${SPECIES}_GOPredSim/${SPECIES}_prott5/gopredsim_${SPECIES}_prott5_1_*.txt > ${SPECIES}_gopredsim_temp2.txt

INPUT=${SPECIES}_gopredsim_temp2.txt

python get_tax_uniprot_reference_gopredsim.py -i $INPUT -l $GOPREDSIM_LOOKUP -u $UNIPROT_ACC -o Results_unfiltered/${SPECIES}_uniprot_taxonomy.txt

rm $INPUT
