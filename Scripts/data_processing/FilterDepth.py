# Filter predictions by GO_ID depth
# Created By  : Israel Barrios, Ana Rojas Mendoza
# Modified By: Gemma Martínez Redondo (Instituto de Biologia Evolutiva)
# Credit: CBBio Lab (Centro Andaluz de Biología del Desarrollo)
# Contact: israel.barrios@csic.es
# Created Date: 1/5/2023
# Modified Date: 3/8/2023
# Status: Prototype
# version ='0.2'
# ---------------------------------------------------------------------------
# Martin Larralde; Philipp A.; Alex Henrie; Daniel Himmelstein; Dave Lawrence; Rafal Wojdyla; Spencer Mitchell; Tatsuya Sakaguchi althonos/pronto: v2.5.4 | 10.5281/zenodo.7814219

import os
from functools import lru_cache
import argparse
import pronto

@lru_cache(maxsize=None)
def filter_depth(go_id,depth):
    if godag.get(go_id):
        return len([x for x in godag[go_id].superclasses(with_self=False)])>depth
    else:
        return False

parser = argparse.ArgumentParser(
        prog="FilterDepth", description="Filter GO by depth"
    )
parser.add_argument(
    "inputfile", help="Path of the input data")
parser.add_argument("outputpath", help="Path of the output file")
parser.add_argument("obopath", help="OBO filepath")
parser.add_argument("depth",help="Depth",type=int)
args = parser.parse_args()

if os.path.exists(args.inputfile):
    if os.path.exists(args.obopath):
        godag=pronto.Ontology(args.obopath)
        with open(args.inputfile,"r") as fread:
            with open(args.outputpath,"w") as fwrite:
                for x in fread:
                    if x:
                        if filter_depth(x.split("\t")[2],int(args.depth)):
                            fwrite.write(x)
    else:
        print("Invalid OBOPATH")
        exit()
else:
    print("Invalid input path")
    exit()
