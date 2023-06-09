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
curl -s -L -o /tmp/main.zip "https://github.com/stans-robot-project/payment/archive/main.zip" &>> $LOG_FILE
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
pip3 install -r requirements.txt &>> $LOG_FILE
stat $?



echo -n "Configuring the service: "
sed -i -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' systemd.service
mv /home/${APP_USER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Updating the $COMPONENT.ini file: "
UR_ID=$(id -u roboshop)
GP_ID=$(id -g roboshop)
sed -i -e "/uid/ c uid = $UR_ID" -e "/gid/ c gid = $GP_ID" payment.ini
stat $?

SERVICE_START


echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------