# ----------------------------------------------------------------------------
# Custom lookup sets for GoPredSim
# Created By  : Israel Barrios
# Credit: CBBio Lab (Centro Andaluz de Biología del Desarrollo)
# Contact: israel.barrios@csic.es
# Created Date: 23/6/2023
# Status: Prototype
# version ='0.1'
# ---------------------------------------------------------------------------


import requests
import gzip
import re
import h5py
import argparse

parser=argparse.ArgumentParser()
parser.add_argument("lookuppath")
parser.add_argument("custom_lookuppath")
parser.add_argument("configpath")
parser.add_argument("-f","--fastapath",help="Path to targetfasta")
parser.add_argument("-t","--taxid",help="Target tax id")

args=parser.parse_args()
if args.fastapath and args.taxid:
    print("ERROR. Can't use fastapath and taxid at the same time")
    exit()
elif args.fastapath:
    print("FASTAPATH PROVIDED")
    fastapath=args.fastapath
elif args.taxid:
    print("TAXID provided")
    FASTA_URL="https://rest.uniprot.org/uniprotkb/stream?compressed=true&format=fasta&query=%28%28taxonomy_id%3A{taxid}%29%29".format(taxid=args.taxid)
else:
    print("ERROR. You must provide fastapath or taxid")
    exit()

regex=re.compile("^>",re.MULTILINE)
custom_lookuppath=args.custom_lookuppath
modelpath=args.lookuppath

def download_URL(URL,retry=5):
    try:
        with requests.get(URL,stream=True) as res:
            extracted = gzip.decompress(res.content)
            extracted_decoded= [line.decode() for line in extracted.split(b'\n')]
        
            return "\n".join(extracted_decoded)
    except:
        if retry>0:
            return download_URL(URL,retry=retry-1)
        else:
            print("TAXID NOT FOUND IN UNIPROT OR MAX RETRIES")
            return "\n"

if args.fastapath:
    with open(fastapath,"r") as fread:
        ids2discard=set([x.split("\n")[0].split("|")[1] for x in regex.split(fread.read()) if x])
elif args.taxid:
    data=download_URL(URL=FASTA_URL)
    ids2discard=set([x.split("\n")[0].split("|")[1] for x in regex.split(data) if x])
else:
    print("ERROR no fastapath or taxid to download")
    exit()

print(len(ids2discard),"IDs to discard")

with h5py.File(modelpath,"r") as fread:
    keys=[x for x in fread.keys()]
    with h5py.File(custom_lookuppath,"w") as fwrite:
        fwrite.attrs.update(fread.attrs)
        for key in keys:
            original_id=fread[key].attrs['original_id']
            if original_id not in ids2discard:
                group_id = fwrite.require_group(fread[key].parent.name)
                fread.copy(f"/{key}",group_id,name=key)

if args.configpath:
    CONFIG_PATH=args.configpath
    gopredsim_config="lookup_set: {}"
    with open(CONFIG_PATH,"r") as fread:
        config=[x.strip() if not "lookup_set" in x else gopredsim_config.format(custom_lookuppath).strip() for x in fread.read().split("\n") if x]
    with open(CONFIG_PATH,"w") as fwrite:
        fwrite.write("\n".join(config))
else:
    print("No configpath provided, you must edit lookup_set in config.yml manually")

