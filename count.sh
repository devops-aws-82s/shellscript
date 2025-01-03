#!/bin/bash

FILE=$(cat file.txt | tr ' ' '\n' | sort | uniq -c)
echo $FILE