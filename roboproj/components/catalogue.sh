#!/bin/bash


set -e # will exit the script if there is an error

COMPONENT=catalogue
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop


source components/common.sh   # validating if its a root user in common.sh

# CALLING NODE JS FUNCTION FROM COMMON FILE 
NODEJS

USER_CREA

REPO_DOWN

CLEAN_UP

EXTRACT_COMP

INSTALL_COMP


echo -n "Configuring the service: "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' systemd.service
mv /home/${APP_USER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

SERVICE_START   # service start function


echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------