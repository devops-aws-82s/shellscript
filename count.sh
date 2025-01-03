#!/bin/bash

echo "$0"
OUT=$(cat file.txt | tr ' ' '\n' | sort | uniq -c)

echo "$OUT"

if [ $OUT -gt 3 ]
then
    echo "thes words are frequnt words : $OUT"
fi


