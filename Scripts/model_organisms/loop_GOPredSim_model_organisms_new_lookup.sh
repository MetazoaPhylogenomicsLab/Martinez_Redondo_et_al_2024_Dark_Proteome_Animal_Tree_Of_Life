#!/bin/bash
#Activate conda and python environments
source /lustre/home/ibe/bio/Metazomics/miniconda3/etc/profile.d/conda.sh
conda activate gopredsim
source /lustre/home/ibe/bio/Metazomics/GOPredSim/venv/bin/activate

#Setting variables
LIST=model_organisms.txt # species_list
CONFIG_FOLDER=GOPredSim_model_organisms/Results # Complete PATH to config_folder. Exclude "config_folder" from the path
MODEL=prott5 # Model for prediction [seqvec/prott5]

echo "From species $1 to $2"

for i in $(seq $1 $2)
do

SPECIES=$(awk -v num_line=$i '{if(NR==num_line) print $1}' $LIST)

echo "" Predicting GO $SPECIES $MODEL model "*"

cd $CONFIG_FOLDER/${SPECIES}_GOPredSim

EMBEDDINGS_CONFIG=$CONFIG_FOLDER/${SPECIES}_GOPredSim/config_files/embeddings/${SPECIES}_${MODEL}.yml
GOPREDSIM_CONFIG=$CONFIG_FOLDER/${SPECIES}_GOPredSim/config_files/gopredsim/${SPECIES}_${MODEL}_sp_removed.yml

#Compute embeddings with the desired model
bash GOPredSim/launch_embeddings.sh -f $EMBEDDINGS_CONFIG

#Transfer GO annotation using GOPredSim
bash GOPredSim/launch_gopredsim.sh -f $GOPREDSIM_CONFIG

cd ../

echo "**"

done
