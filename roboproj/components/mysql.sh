COMPONENT=mysql
LOG_FILE="/tmp/$COMPONENT.log"
MYSQL_REPO_URL=" https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo"
#COMPONENT_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"
source components/common.sh   # validating if its a root user in common.sh

echo -n "Downloading $COMPONENT repo: "
curl -s -o /etc/yum.repos.d/mysql.repo $MYSQL_REPO_URL &>> $LOG_FILE
stat $?

echo -n "Inastalling  $COMPONENT: "
yum install mysql-community-server -y  &>> $LOG_FILE
stat $?

echo -n "Starting and enabling $COMPONENT: "
systemctl enable mysqld  &>> $LOG_FILE && systemctl restart mysqld  &>> $LOG_FILE
stat $?

echo "show databases" | mysql -uroot -pRoboShop@1 &>> $LOG_FILE
 
if [ 0 -ne $? ]; then 
    echo -n "Changing the default root password: "
    DEF_PASSW=$(sudo grep "temporary password" /var/log/mysqld.log | awk '{print $NF}')
    echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('RoboShop@1');" > /tmp/rootpassw.sql
    mysql --connect-expired-password -uroot -p"$DEF_PASSW" < /tmp/rootpassw.sql
    stat $?
fi