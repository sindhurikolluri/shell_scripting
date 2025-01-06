#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
echo "ERROR:: You must have sudo sccess to execute this script" 
exit 1 
fi 
 dnf install mysql -y

 if [ $? -ne 0 ]

 then echo "Installing MYSQL is failure"
exit 1 

else 
echo "Installing MYSQL is success" 
fi 
