#!/bin/bash

echo "$0"
OUT=$(cat file.txt | tr ' ' '\n' | sort | uniq -c)

echo " Count is : ($OUT) "



