#!/bin/bash

SOURCE="/home/ec2-user/expense.logs"
DATE=$(date)
FIND=$(find $SOURCE -name "*.log" -mtime +14)
#echo "$FIND"
#rm -rf $FIND

echo "$DATE"
echo " please confirm if you want delete below files"
while read -r old
do
    
    rm -I 
    echo "$old"
    
done <<<$FIND




