#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p /home/ec2-user/expense-logs
if [ $? -eq 0 ]
then
    echo "directory created successfully"
else
    echo "directory creation failed"
fi

LOG_PATH="/home/ec2-user/expense-logs"
FILE_NAME=$( echo $0 | cut -d "." -f1)
DATE=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_PATH/$FILE_NAME-$DATE.log"

if [ $USERID -ne 0 ]
then
    echo -e " $R You need to root access to run this file $N"
    exit 1
fi 

echo "Script started at : $DATE" &>>$LOG_FILE

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo "$2..Failed"
else
    echo "$2..Success"
fi
}

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "mysql installing"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "mysql service enabled"

systemctl start mysqld &>>$LOG_FILE
VALIDATE $? "mysql service started"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG_FILE
if [ $? -eq 0 ]
then 
    echo -e "mysql root password $Y already created $N"
else 
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG_FILE
    VALIDATE $? "mysql root password creating"
fi



