#!/bin/bash
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=devops" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID
COMPONENT=$1
aws ec2 run-instances --image-id $AMI_ID  --instance-type t3.micro  --security-group-ids sg-03ec6d3f23f96aefd --tag-specifications "ResourceType=instance,Tags=[{Key=name,Value=${COMPONENT}}]" | jq