#!/bin/bash

SOURCE="/home/ec2-user/expense.logs"

FIND=$(find $SOURCE -name "*.log" -mtime +14)
echo "$FIND"