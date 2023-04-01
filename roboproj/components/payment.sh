set -e # will exit the script if there is an error

source components/common.sh

COMPONENT=payment
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop

echo -n "Installing Pyton: "
yum install python36 gcc python3-devel -y &>> $LOG_FILE
stat $?

USER_CREA

echo -n "Downloading the repo:  "
curl -s -L -o /tmp/main.zip "https://github.com/stans-robot-project/user/archive/main.zip" &>> $LOG_FILE
stat $?

CLEAN_UP

EXTRACT_COM(){
    echo -n "Extracting the $COMPONENT: "
    cd /home/roboshop/
    unzip -o /tmp/main.zip &>> $LOG_FILE
    mv $COMPONENT-main $COMPONENT && chown -R $APP_USER:$APP_USER $COMPONENT
    cd $COMPONENT
    stat $?
}
EXTRACT_COM
echo -n "Installing dependencies: "
cd /home/roboshop/payment 
pip3 install -r requirements.txt &>> $LOG_FILE
stat $?

#sed -i -e '