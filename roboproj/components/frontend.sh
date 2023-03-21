#!/bin/bash
set -e # will exit the script if there is an error

COMPONENT=frontend
LOG_FILE="/tmp/$COMPONENT.log"

source components/common.sh   # validating if its a root user in common.sh

stat (){
    if [ $1 -eq 0 ] ; then
        echo -e  "\e[32m SUCCESS. \e[0m"
    else
        echo -e  "\e[31m FAILURE. \e[0m"
    fi
}

echo -n "Installing Nginx: "  # -n : cursor wont move to the next line
yum install nginx -y  &>> $LOG_FILE
stat $?



systemctl enable nginx &>> $LOG_FILE

echo -n "Starting Nginx: "
systemctl start nginx &>> $LOG_FILE
stat $?

echo -n "Downloading the Repo: "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $LOG_FILE
stat $?

echo -n "Clearing the old content: "
cd /usr/share/nginx/html
rm -rf *
stat $?

echo -n "Extracting the $COMPONENT: "
unzip /tmp/frontend.zip
stat $?

echo -n "Updating the Proxy file: "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -e -------------- "\e[31m $COMPONENT configuration. \e[0m"--------------------