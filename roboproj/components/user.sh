#!/bin/bash


set -e # will exit the script if there is an error
source components/common.sh   

COMPONENT=user
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop
REPO_VAR=main




# CALLING NODE JS FUNCTION FROM COMMON FILE 
NODEJS

USER_CREA

#REPO_DOWN

CLEAN_UP

#EXTRACT_COMP

EXTRACT_COMP(){
    echo -n "Extracting the $COMPONENT: "
    cd /home/roboshop/
    unzip -o /tmp/$REPO_VAR.zip &>> $LOG_FILE
    mv $COMPONENT-main $COMPONENT && chown -R $APP_USER:$APP_USER $COMPONENT
    cd $COMPONENT
    stat $?
}

INSTALL_COMP



#echo -n "Configuring the service: "
#sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' systemd.service
#mv /home/${APP_USER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
#stat $?

#SERVICE_START   # service start function


#echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------