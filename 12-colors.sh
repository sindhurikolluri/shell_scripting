#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

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

if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 #other than 0
fi

dnf list installed mysql

if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y
    VALIDATE $? "Installing Mysql"
else
    echo -e "MySQL is already ... $Y INSTALLED"
fi