COMPONENT=shipping
LOG_FILE="/tmp/$COMPONENT.log"
APP_USER=roboshop


source components/common.sh   # validating if its a root user in common.sh

echo -n "Installing Maven: "
yum install maven -y
stat $?

USER_CREA

REPO_DOWN

CLEAN_UP

EXTRACT_COMP

echo -n "Installing the $COMPONENT: "
mvn clean package &>> $LOG_FILE
mv target/shipping-1.0.jar shipping.jar
stat $?

echo -n "Configuring the service: "
sed -i -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' systemd.service
mv /home/${APP_USER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

SERVICE_START

echo -e -------------- "\e[33m $COMPONENT configuration completed. \e[0m"--------------------