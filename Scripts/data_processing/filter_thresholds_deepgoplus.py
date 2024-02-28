#  This script filters the output of DeepGOPlus by the thresholds of best performance by checking the IC content files
#  To execute this script the command is the following: python3 filter_thresholds_deepgoplus.py PATH/TO/INPUT/FILES/DEEPGOPLUS PATH/TO/THE/DIRECTORY/WITH/THE/OUTPUTS/ PATH/TO/IC/CONTENT/FILES/

import csv
import sys

# Define the thresholds for each category
thresholds = {
    'biological_process': 0.22,
    'cellular_component': 0.27,
    'molecular_function': 0.18
}

go_values = {}

with open(sys.argv[1] + "/<argument>_deepgoplus.txt", 'r') as f:
    reader = csv.reader(f, delimiter='\t')
    for row in reader:
        gene = row[0]
        go_values[gene] = {}
        for go_value in row[1:]:
            go_term, value = go_value.split('|')
            value = float(value)
            go_values[gene][go_term] = value

with open(sys.argv[2] + "/<argument>_deepgoplus.filtered.txt", 'w') as fout:
    with open(sys.argv[3] + "/<argument>_EXTENSION_OF_THE_IC_CONTENT_FILES", 'r') as f:
        reader = csv.reader(f, delimiter='\t')
        for row in reader:
            gene = row[0]
            category = row[1]
            go_term = row[2]
            value = go_values[gene].get(go_term)
            threshold = thresholds.get(category)
            if threshold and value and value > threshold:
                fout.write('\t'.join(row) + '\n')
