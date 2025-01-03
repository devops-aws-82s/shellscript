#!/bin/bash

echo "Current Executing file name is :$0"
OUT=$(cat file.txt | tr ' ' '\n' | sort | uniq -c)

echo "$OUT"