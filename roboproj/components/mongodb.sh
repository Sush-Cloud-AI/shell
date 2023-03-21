#!/bin/bash

set -e # will exit the script if there is an error

COMPONENT=mongodb
LOG_FILE="/tmp/$COMPONENT.log"
MONGODB_REPO_URL="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
COMPONENT_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"
source components/common.sh   # validating if its a root user in common.sh

echo -n "Downloading $COMPONENT repo: "
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGODB_REPO_URL &>> $LOG_FILE
stat $?

echo -n "Inastalling  $COMPONENT: "
yum install -y mongodb-org  &>> $LOG_FILE
stat $?

echo -n "Upadting $COMPONENT Listening address: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf ## -i should be followed by -e
stat $?

echo -n "Starting and enabling $COMPONENT: "
systemctl enable mongod  &>> $LOG_FILE
systemctl restart mongod  &>> $LOG_FILE
stat $?

echo -n "Download the  $COMPONENT code: "
curl -s -L -o /tmp/mongodb.zip $COMPONENT_URL &>> $LOG_FILE
stat $?


echo -n "Extracting the schema: "
cd /tmp
unzip -o mongodb.zip &>> $LOG_FILE   ##-o is to overide when extacting multiple time or re run
stat $?



echo -n "Injecting the schema: "
cd mongodb-main
mongo < catalogue.js &>> $LOG_FILE
mongo < users.js &>> $LOG_FILE
stat $?


echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------
