#!/bin/bash


#set -e # will exit the script if there is an error
source components/common.sh

COMPONENT=rabbitmq
LOG_FILE="/tmp/$COMPONENT.log"

APP_USER=roboshop



echo -n "Installing $COMPONENT Dependency package Erlang: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOG_FILE
stat $?

echo -n "Setting up $COMPONENT Repo: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOG_FILE
stat $?


echo -n "Installing $COMPONENT : "
yum install rabbitmq-server -y &>> $LOG_FILE
stat $?


echo -n "Starting $COMPONENT service: "
systemctl restart rabbitmq-server &>> $LOG_FILE
systemctl enable rabbitmq-server &>> $LOG_FILE
stat $?

rabbitmqctl list_users | grep roboshop &>> $LOG_FILE

if [ $? -ne 0 ] ; then
    echo -n "Create $APP_USER for $COMPONENT: "
    rabbitmqctl add_user $APP_USER roboshop123
    stat $?
fi

echo -n "Configuring $APP_USEr permissions for $COMPONENT: "
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?

echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------
