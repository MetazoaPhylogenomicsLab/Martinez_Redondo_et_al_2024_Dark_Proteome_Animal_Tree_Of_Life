#Obtain minimum value of confidence for gopredsim data when gene has more than one after combining bpo,mfo and cc
cd Results
for SP in $(cat ../model_organisms.txt); do awk '{ if (!($1 in a)) a[$1] = $2; else if (a[$1] > $2) a[$1] = $2 } END { for (key in a) print key, a[key] }' ${SP}_GOPredSim/${SP}_orig_confidence.txt > ${SP}_GOPredSim/${SP}_orig_confidence_min.txt; awk '{ if (!($1 in a)) a[$1] = $2; else if (a[$1] > $2) a[$1] = $2 } END { for (key in a) print key, a[key] }' ${SP}_GOPredSim/${SP}_prott5/${SP}_removed_confidence.txt > ${SP}_GOPredSim/${SP}_removed_confidence_min.txt; done
