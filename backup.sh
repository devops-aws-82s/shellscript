#!/bin/bash

R="\e[31m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}


if [ $# -lt 2 ]
then 
    echo " please pass two arguments, USAGE shellscript file name and  <source dir> <dest dir>"
    exit 1
fi

LOG_FOLDER="/home/ec2-user/app-logs"
DATE=$(date +%Y-%m-%d-%H-%M-%S)

mkdir -p /home/ec2-user/app-logs
mkdir -p /home/ec2-user/archive-logs


if [ ! -d $SOURCE_DIR ]
then    
    echo " $SOURCE_DIR not exist"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then    
    echo " $DEST_DIR not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log")
echo "$DATE"
echo "files are : $FILES"