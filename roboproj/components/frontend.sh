#!/bin/bash
set -e # will exit the script if there is an error

COMPONENT=frontend
LOG_FILE="/tmp/$COMPONENT.log"

source components/common.sh   # validating if its a root user in common.sh

echo -n "Installing Nginx: "  # -n : cursor wont move to the next line
yum install nginx -y  &>> $LOG_FILE

if [ $? -eq 0 ] ; then
    echo -e  "\e[32m SUCCESS. \e[0m"
else
    echo -e  "\e[31m FAILURE. \e[0m"
fi
# systemctl enable nginx
# systemctl start nginx

# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

# systemctl restart nginx