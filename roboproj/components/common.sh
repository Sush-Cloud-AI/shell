#!/bin/bash

# validating if the user is a root to execute the commands

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[31m You may need to run it as a root user only. \e[0m"
    exit 1
fi