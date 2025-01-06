#!/bin/bash

R="\e[31m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2

if [ $# -lt 2 ]
then 
    echo "usage of passing parameters <source dir> <dest dir>"
    exit 1
fi