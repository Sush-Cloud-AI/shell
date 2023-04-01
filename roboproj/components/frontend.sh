#!/bin/bash
set -e # will exit the script if there is an error

COMPONENT=frontend
LOG_FILE="/tmp/$COMPONENT.log"

source components/common.sh   # validating if its a root user in common.sh



echo -n "Installing Nginx: "  # -n : cursor wont move to the next line
yum install nginx -y  &>> $LOG_FILE
stat $?



systemctl enable nginx &>> $LOG_FILE

#echo -n "Starting Nginx: "
#systemctl start nginx &>> $LOG_FILE
#stat $?

echo -n "Downloading the Repo: "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $LOG_FILE
stat $?

echo -n "Clearing the old content: "
cd /usr/share/nginx/html
rm -rf *
stat $?

echo -n "Extracting the $COMPONENT: "
unzip /tmp/frontend.zip &>> $LOG_FILE
stat $?

echo -n "Updating the Proxy file: "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?



echo -n "restarting Ngnix: "
systemctl restart nginx
stat $?

#echo -n "configure the proxy file: "
#sed -i -e '/catalogue/s/localhost/catalogue.roboshop.internal/' -e '/user/s/localhost/user.roboshop.internal/' -e '/cart/s/localhost/cart.roboshop.internal/' -e '/shipping/s/localhost/shipping.roboshop.internal/' -e '/payment/s/localhost/payment.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
#stat $?

echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------