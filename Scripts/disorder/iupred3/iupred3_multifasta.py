#!/usr/bin/python3

import sys
import os
import iupred3_lib
import argparse
from statistics import mean

parser = argparse.ArgumentParser()
parser.add_argument("seqfile", help="multiFASTA formatted sequence file")
parser.add_argument("iupred_type", help="Analysis type: \"long\", \"short\" or \"glob\"")
parser.add_argument("-s", "--smoothing", help="Smoothing type: \"no\", \"medium\" or \"strong\". Default is \"medium\"",
                    default="medium")
parser.add_argument("-r", "--per_residue", required=False, action="store_true", default=False, help="If provided, output includes disorder per residue instead of protein average.")
args = parser.parse_args()

PATH = os.path.dirname(os.path.realpath(__file__))

if args.smoothing not in ['no', 'medium', 'strong']:
	raise ValueError('Smoothing (-s, --smoothing) must be either \"no\", \"medium\" or \"strong\"!')

if args.per_residue:
	print('# POS\tRES\tIUPRED2')
else:
	print('# SEQ\tIUPRED2')

sequences = iupred3_lib.read_multiseq(args.seqfile)
for header in sequences.keys():
	sequence=sequences[header]
	if len(sequence)<19:
		continue
	iupred2_result = iupred3_lib.iupred(sequence, args.iupred_type, smoothing=args.smoothing)
	if args.per_residue:
		print(">"+header)
		if sys.argv[-1] == 'glob':
			print(iupred2_result[1])
		for pos, residue in enumerate(sequence):
			if residue=="*":
				continue
			print('{}\t{}\t{:.4f}'.format(pos + 1, residue, iupred2_result[0][pos]))
		print()
	else:
		mean_disorder=mean([iupred2_result[0][pos] for pos,residue in enumerate(sequence) if residue != "*"])
		print('{}\t{:.4f}'.format(header, mean_disorder))
