#!/bin/bash
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=devops" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID
COMPONENT=$1
PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID  --instance-type t3.micro  --security-group-ids sg-03ec6d3f23f96aefd --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g') 
echo $PRIVATE_IP

#sed -e 's/IPADDRESS/${PRIVATE_IP}/' -e 's/COMPONENT/${COMPONENT}/' route53.json > /tmp/record.json


#aws route53 change-resource-record-sets --hosted-zone-id Z05313022PGNHL8COSD1E --change-batch file:///tmp/record.json | jq