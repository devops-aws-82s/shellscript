#!/bin/bash

SOURCE="/home/ec2-user/expense.logs"
DATE=$(date)
FIND=$(find $SOURCE -name "*.log" -mtime +14)
#echo "$FIND"
#rm -rf $FIND

while read -r old
do
    echo "$DATE"
    echo "Below Files Will be Deleted:"
    echo "$old"
done <<<$FIND