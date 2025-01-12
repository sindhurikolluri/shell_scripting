#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
Dest_dir=$2
DAYS=${3: -14} #if user is not providing the no of days then we can take the default as 14 

LOGS_FOLDER=""/home/ec2-user/shellscript-logs""
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
    echo -e "$2......$R FAILURE $N"
    exit 1
    else
    echo -e "$2......$G SUCCESS $N"
    fi
}
#To check if the user is giving is giving the correct input

USAGE()
{
    echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs/

#Checking if the no of arguments provided is correct 

if [ $# -lt 2 ]
then
USAGE
fi

#checking if the given source directory exist
if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$SOURCE_DIR Does not exist....please check"
    exit 1
fi

#checking if the destination directory exist
if [ ! -d $DEST_DIR ]
then
    echo -e "$DEST_DIR Does not exist....please check"
    exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME