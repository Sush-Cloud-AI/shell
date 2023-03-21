#!/bin/bash


set -e # will exit the script if there is an error

COMPONENT=catalogue
LOG_FILE="/tmp/$COMPONENT.log"

COMPONENT_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"
source components/common.sh   # validating if its a root user in common.sh

echo -n "configuring NodeJS Repo:  "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOG_FILE
stat $?

echo -n "Inastalling NodeJS: "
yum install nodejs -y  &>> $LOG_FILE
stat $?


echo -n "Creating roboshop user: "
id roboshop &>> $LOG_FILE || useradd roboshop
stat $?

echo -n "Download the  $COMPONENT code: "
curl -s -L -o /tmp/catalogue.zip $COMPONENT_URL  &>> $LOG_FILE
stat $?

echo -n "Performing cleanup: "
cd /home/roboshop/ && rm -rf $COMPONENT &>> $LOG_FILE
stat $?

echo -n "Extracting the $COMPONENT: "
cd /home/roboshop
unzip -o /tmp/catalogue.zip &>> $LOG_FILE
mv catalogue-main catalogue && chown -R roboshop:roboshop $COMPONENT
cd $COMPONENT
stat $?

echo -n "Installing the $COMPONENT: "

npm install &>> $LOG_FILE
stat $?