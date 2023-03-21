set -e # will exit the script if there is an error

source components/common.sh

COMPONENT=redis
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop


echo -n "Downloading $COMPONENT repo: "
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?


echo -n "Inastalling  $COMPONENT: "
yum install redis-6.2.11 -y  &>> $LOG_FILE
stat $?

echo -n "Upadting $COMPONENT Listening address: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf ## -i should be followed by -e
stat $?

SERVICE_START


echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------