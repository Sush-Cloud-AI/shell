#!/bin/bash


set -e # will exit the script if there is an error


COMPONENT=rabbitmq
LOG_FILE="/tmp/$COMPONENT.log"

APP_USER=roboshop


echo -n "Installing $COMPONENT Dependency package Erlang: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOG_FILE
stat $?

echo -n " etting up $COMPONENT Repo: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOG_FILE
stat $?

echo -n "Installing $COMPONENT : "
yum install rabbitmq-server -y &>> $LOG_FILE
stat $?


echo -n "Starting $COMPONENT service: "
systemctl restart rabbitmq-server &>> $LOG_FILE
systemctl enable rabbitmq-server &>> $LOG_FILE
stat $?