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


dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "nodejs disabling"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "nodejs 20 version enabled"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "nodejs installing"

id expense &>>$LOG_FILE
if [ $? -eq 0 ]
then 
    echo -e "$Y expense user already added $N"
else 
    useradd expense 
    VALIDATE $? "expense user adding"
fi

mkdir -p /app &>>$LOG_FILE
VALIDATE $? "directory creating"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE
VALIDATE $? "backend files downloading"

cd /app &>>$LOG_FILE
VALIDATE $? "directory changed"

rm -rf /app/*
VALIDATE $? -e " $Y removing old files $N"

unzip /tmp/backend.zip &>>$LOG_FILE
VALIDATE $? "backend files unzipping"

npm install &>>$LOG_FILE
VALIDATE $? "dependents installing"

cp /home/ec2-user/shellscript/backend /etc/systemd/system/backend.service &>>$LOG_FILE
VALIDATE $? "copying expense config file "

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "mysql installing"

mysql -h 172.31.94.50 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE
VALIDATE $? "schema creating"

systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "deamon reloading"

systemctl enable backend &>>$LOG_FILE
VALIDATE $? "nodejs service enabling"

systemctl start backend &>>$LOG_FILE
VALIDATE $? "nodejs service starting"

systemctl restart backend &>>$LOG_FILE
VALIDATE $? "nodejs restarting"