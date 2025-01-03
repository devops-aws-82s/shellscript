#!/bin/bash

SOURCE="/home/ec2-user/expense.logs"
DATE=$(date)
FIND=$(find $SOURCE -name "*.log" -mtime +14)
#echo "$FIND"
#rm -rf $FIND

echo "$DATE"
echo "Below Files Will be Deleted:"
while read -r old
do
    
    
    echo "$old"
done <<<$FIND

echo "please enter yes or no"
read TYPO