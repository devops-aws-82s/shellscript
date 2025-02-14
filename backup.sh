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

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo " script executing at: $DATE"
# echo "files are : $FILES"

if [ -n "$FILES" ]
then 
    echo "files found older than : $DAYS days and fikes are : $FILES"
    ZIP_FILE="$DEST_DIR/archive-logs-$DATE.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "Successfully created zip file for files older than $DAYS"
        rm -rf $FILES
        if [ $? -eq 0 ]
        then
            echo "files are archived and deleted"
        else
            echo "no files to delete"
        fi
    else
        echo "zip creation failed"
    
    fi
else
    echo " no files found older than $DAYS days"
    exit 1
fi