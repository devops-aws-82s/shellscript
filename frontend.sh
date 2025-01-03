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

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "installing nginx"

systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "enabling nginx"

systemctl start nginx &>>$LOG_FILE
VALIDATE $? "nginx service starting"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATE $? "existing files removed"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
VALIDATE $? "downloading files"

cd /usr/share/nginx/html &>>$LOG_FILE
VALIDATE $? "directory changed"

unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "unzipping files"

cp /home/ec2-user/shellscript/expense.conf /etc/nginx/default.d/expense.conf &>>$LOG_FILE
VALIDATE $? "copying expense config file"

systemctl restart nginx &>>$LOG_FILE
VALIDATE $? "nginx service restarted"