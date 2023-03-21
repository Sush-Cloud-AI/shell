#!/bin/bash


set -e # will exit the script if there is an error
source components/common.sh   

COMPONENT=user
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop




# CALLING NODE JS FUNCTION FROM COMMON FILE 
NODEJS


echo -n "Configuring the service: "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' systemd.service
mv /home/${APP_USER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

SERVICE_START   # service start function


echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------