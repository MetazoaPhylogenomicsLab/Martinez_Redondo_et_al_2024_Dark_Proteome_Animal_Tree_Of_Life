# This script creates a file with eggnog-mapper annotations but removing those lines (queries) that have no go terms annotation
# Execution: python3 filter_go_terms_eggnog.py SPECIES.emapper.annotations SPECIES.emapper.annotations.filtered.goterms.txt
import sys

with open(sys.argv[1], "r") as input_file, open(sys.argv[2], "w") as output_file:
    # Iterate through each line in the input file
    for line in input_file:
        # Split the line by tab to get individual columns
        columns = line.strip().split("\t")
        # Check if the line has at least 10 columns and the 10th column does not contain "-"
        if len(columns) >= 10 and columns[9] != "-":
            # Write the line to the output file
            output_file.write(line)
