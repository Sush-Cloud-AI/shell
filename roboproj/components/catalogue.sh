#!/bin/bash


set -e # will exit the script if there is an error

COMPONENT=catalogue
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop

COMPONENT_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"
source components/common.sh   # validating if its a root user in common.sh

echo -n "configuring NodeJS Repo:  "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOG_FILE
stat $?

echo -n "Inastalling NodeJS: "
yum install nodejs -y  &>> $LOG_FILE
stat $?


echo -n "Creating roboshop user: "
id roboshop &>> $LOG_FILE || useradd $APP_USER
stat $?

echo -n "Download the  $COMPONENT code: "
curl -s -L -o /tmp/catalogue.zip $COMPONENT_URL  &>> $LOG_FILE
stat $?

echo -n "Performing cleanup: "
cd /home/${APP_USER}/ && rm -rf ${COMPONENT} &>> $LOG_FILE
stat $?

echo -n "Extracting the $COMPONENT: "
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip &>> $LOG_FILE
mv ${COMPONENT}-main ${COMPONENT} && chown -R $APP_USER:$APP_USER $COMPONENT
cd ${COMPONENT}
stat $?

echo -n "Installing the $COMPONENT: "
npm install &>> $LOG_FILE
stat $?

echo -n "Configuring the service: "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' systemd.service
mv /home/$APP_USER/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

service_start    # service start function


echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------