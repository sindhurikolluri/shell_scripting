#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if user is not providing the no of days then we can take the default as 14 

LOGS_FOLDER=""/home/ec2-user/shellscript-logs""
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


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

#Finding the log files 
FILES=$(find "$SOURCE_DIR" -name "*.log" -mtime +"$DAYS")


#check if you can fetch the files 

if [ -n "$FILES" ]
then 
echo "Files are: $FILES"
ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
find "$SOURCE_DIR" -name "*.log" -mtime +"$DAYS" | zip -@ "$ZIP_FILE"

#check if there exist a zip file 
if [ -f "$ZIP_FILE" ]
then 
echo -e "Successfully created zip file for files older then $DAYS"
# We are ready to delete the files 
 while read -r filepath # here filepath is the variable name, you can give any name
        do
            echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
            rm -rf $filepath
            echo "Deleted file: $filepath"
        done <<< $FILES
else
echo -e "$R Error:: $N Failed to create ZIP FILE"
exit 1
fi

else
echo "No files found older then $DAYS"
fi