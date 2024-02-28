#  This script filters the output of IC content by the thresholds of best performance for GOPredSim
# Execution python3 filter_thresholds_gopredsim.py /PATH/TO/GOPREDSIM/RESULTS /PATH/TO/OUTPUT/FILES

import sys

models = ["prott5", "seqvec"]
parameters = ["bpo", "cco", "mfo"]

for model in models:
    for parameter in parameters:
        f = open(sys.argv[1] + "/<argument>_GOPredSim/<argument>_" + model + "/gopredsim_<argument>_" + model + "_1_" + parameter + ".txt", 'r')
        f_out = open(sys.argv[2] + "/gopredsim_<argument>_" + model + "_1_" + parameter + "_filtered.txt", 'w')
        for line in f:
            line = line.strip().split('\t')
            if parameter == "bpo":
                if float(line[2]) >= 0.35:
                    f_out.write(line[0] + '\t' + line[1] + '\t' + line[2] + '\n')
            elif parameter == "cco":
                if float(line[2]) >= 0.29:
                    f_out.write(line[0] + '\t' + line[1] + '\t' + line[2] + '\n')
            elif parameter == "mfo":
                if float(line[2]) >= 0.28:
                    f_out.write(line[0] + '\t' + line[1] + '\t' + line[2] + '\n')
