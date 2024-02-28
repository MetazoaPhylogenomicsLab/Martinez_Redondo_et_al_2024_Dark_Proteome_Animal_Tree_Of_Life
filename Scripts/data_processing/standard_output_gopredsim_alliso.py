# This script transforms the output of GOPredSim having into account the isoforms to an output like the following:
# gene1  goterm1, goterm2, goterm3
# gene2  goterm1, goterm2, goterm3

# Execution: python3 standard_output_gopredsim_alliso.py /INPUT/FILES/PATH /DESTINATION/PATH

models = ["prott5", "seqvec"]
parameters = ["bpo", "cco", "mfo"]

for model in models:
    f_out = open(sys.argv[2] + "/<argument>_" + model + "_1_bpo_cco_mfo.standard_alliso.txt", 'w')
    result = dict()
    for parameter in parameters:
        f = open(sys.argv[1] + "/<argument>_GOPredSim/_" + model + "/gopredsim_<argument>_" + model + "_1_" + parameter + ".txt", 'r')
        for line in f:
            gene = line.split("_i")[0]
            if gene not in result:
                result[gene] = set()
                result[gene].add(line.split()[1])
            else:
                result[gene].add(line.split()[1])

    for k, v in result.items():
        f_out.write(f"{k}\t{', '.join(v)}\n")
