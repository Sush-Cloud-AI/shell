#!/bin/bash


COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"

# validating if the user is a root to execute the commands
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[31m You may need to run it as a root user only. \e[0m"
    exit 1
fi


stat (){
    if [ $1 -eq 0 ] ; then
        echo -e  "\e[32m SUCCESS. \e[0m"
    else
        echo -e  "\e[31m FAILURE. \e[0m"
    fi
}



NODEJS(){
    echo -n "configuring NodeJS Repo:  "
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOG_FILE
    stat $?

    echo -n "Inastalling NodeJS: "
    yum install nodejs -y  &>> $LOG_FILE
    stat $?

    USER_CREA

    REPO_DOWN

    CLEAN_UP

    EXTRACT_COMP

    INSTALL_COMP
}

USER_CREA(){
    echo -n "Creating roboshop user: "
    id roboshop &>> $LOG_FILE || useradd $APP_USER
    stat $?
}

REPO_DOWN(){
    echo -n "Download the  $COMPONENT REPO: "
    curl -s -L -o /tmp/$COMPONENT.zip $COMPONENT_URL  &>> $LOG_FILE
    stat $?
}

CLEAN_UP(){
   echo -n "Performing cleanup: "
    cd /home/${APP_USER}/ && rm -rf ${COMPONENT} &>> $LOG_FILE
    stat $? 
}

EXTRACT_COMP(){
    echo -n "Extracting the $COMPONENT: "
    cd /home/roboshop/
    unzip -o /tmp/$COMPONENT.zip &>> $LOG_FILE
    mv $COMPONENT-main $COMPONENT && chown -R $APP_USER:$APP_USER $COMPONENT
    cd $COMPONENT
    stat $?
}

INSTALL_COMP(){
    echo -n "Installing the $COMPONENT: "
    npm install &>> $LOG_FILE
    stat $?
}


SERVICE_START(){
    echo -n "Starting $COMPONENT service: "
    systemctl daemon-reload &>> $LOG_FILE
    systemctl restart $COMPONENT &>> $LOG_FILE
    systemctl enable $COMPONENT &>> $LOG_FILE
    stat $?
}