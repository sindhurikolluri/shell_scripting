#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
LOGS_FOLDER="/var/log/shellscript_logs"
LOG_FILE= $(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME= "$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE()
{
   if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE"
        exit 1
    else
        echo -e "$2 ...$G SUCCESS"
    fi  
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME
then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 #other than 0
fi

dnf list installed mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing Mysql"
else
    echo -e "MySQL is already ... $Y INSTALLED"
fi