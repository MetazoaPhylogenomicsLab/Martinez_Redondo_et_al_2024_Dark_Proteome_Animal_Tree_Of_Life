#!/usr/bin/bash
cat longest_eggnog_deepgoplus_go_category/* | sed "s/cellular_component/CC/g; s/biological_process/BP/g; s/molecular_function/MF/g" > Longest_semsim_eggnog_depth_deepgoplus_threshold_depth_go_category.txt
cat longest_eggnog_prott5_go_category/* | sed "s/cellular_component/CC/g; s/biological_process/BP/g; s/molecular_function/MF/g" > Longest_semsim_eggnog_depth_prott5_threshold_go_category.txt
cat longest_eggnog_seqvec_go_category/* | sed "s/cellular_component/CC/g; s/biological_process/BP/g; s/molecular_function/MF/g" > Longest_semsim_eggnog_depth_seqvec_threshold_go_category.txt
