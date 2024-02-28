#!/usr/bin/bash
IN_LONGEST=$1
IN_ALL=$2
OUT=$3

paste $IN_ALL $IN_LONGEST | awk '{print $2 "\t" $1 "\t" $6}' | grep -wv 0 > $OUT
