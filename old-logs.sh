#!/bin/bash

SOURCE="/home/ec2-user/expense.logs"

FIND=$(find $SOURCE -name "*.log" -mtime +14)
#echo "$FIND"
#rm -rf $FIND

while read -r old
do 

    echo " these files will be deleted: $old"
done <<<$FIND