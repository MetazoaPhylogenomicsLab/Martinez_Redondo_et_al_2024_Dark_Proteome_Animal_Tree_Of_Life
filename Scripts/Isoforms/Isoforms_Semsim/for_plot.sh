#!/usr/bin/bash
cat SemSim_GO_cat/* | sed "s/$/\tgopredsim_seqvec/g" > semsim_allvslong_seqvec_go_cat.txt
