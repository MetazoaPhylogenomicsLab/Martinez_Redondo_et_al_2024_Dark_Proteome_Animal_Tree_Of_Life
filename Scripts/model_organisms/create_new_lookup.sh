#!/usr/bin/bash

source venv/bin/activate

while read -r LINE
do
	CODE=$(echo $LINE | awk '{ print $1 }')
	TAXID=$(echo $LINE | awk '{ print $2 }')
	mkdir $WD/Results/${CODE}_GOPredSim/new_lookup
	python custom_lookup.py -t $TAXID /GOPredSim//goPredSim/data/prott5_goa_2022.h5 $WD/Results/${CODE}_GOPredSim/new_lookup/prott5_no_${TAXID}.h5 $WD/Results/${CODE}_GOPredSim/config_files/gopredsim/${CODE}_prott5.yml
	python custom_lookup.py -t $TAXID /new_seqvec_lookup/reduced_embeddings_file.h5 $WD/Results/${CODE}_GOPredSim/new_lookup/seqvec_no_${TAXID}.h5 $WD/Results/${CODE}_GOPredSim/config_files/gopredsim/${CODE}_seqvec.yml
done < model_organisms_taxid_code_conversion.txt
