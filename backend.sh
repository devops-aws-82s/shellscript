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


dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
useradd expense
mkdir /app
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
npm install

cp 