set -e # will exit the script if there is an error

source components/common.sh

COMPONENT=payment
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop

echo -n "Installing Pyton: "
yum install python36 gcc python3-devel -y &>> $LOG_FILE
stat $?

USER_CREA

REPO_DOWN

CLEAN_UP

EXTRACT_COMP

echo -n "Installing dependencies: "
cd /home/roboshop/payment 
pip3 install -r requirements.txt &>> $LOG_FILE
stat $?

#sed -i -e '