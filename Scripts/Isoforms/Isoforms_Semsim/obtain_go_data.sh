#!/usr/bin/sh

WD=Dark_proteome/Isoforms_Semsim
SPECIES_FILE=$WD/../subset_sp.txt
MODEL=seqvec #prott5
DATA_FOLDER=$WD/gopredsim_${MODEL}/data
GO_DATA=Drago_backup/

while read -r SP
do
	cat $GO_DATA/all_isoforms_gopredsim/${SP}_GOPredSim/${SP}_${MODEL}/gopredsim_* | cut -f1,2 > $DATA_FOLDER/${SP}_all_isoforms.txt
	cat $GO_DATA/longest_isoforms_gopredsim/${SP}_GOPredSim/${SP}_${MODEL}/gopredsim_* | cut -f1,2 > $DATA_FOLDER/${SP}_longiso.txt
done < $SPECIES_FILE
