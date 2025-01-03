#!/bin/bash

SOURCE="/home/ec2-user/expense.logs"

FIND=$(find $SOURCE -name "*.log" -mtime +14)
echo "$FIND"
rm -rf $FIND
if [ $? -eq 0 ]
then 
    echo "files are deleted"
else
    echo "files are not deleted"
fi