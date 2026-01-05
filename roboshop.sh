#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0f9e10b0b5e242043"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z1011650191JZ4JYJQ4FE"
DOMAIN_NAME="ramdevops.site"


for instance in ${instance[@]}
do
    INSTANCE_ID=aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids  sg-0f9e10b0b5e242043 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].PrivateIpAddress" --output text
    if [ instance != "fronend" ]
    then
       IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
       IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)   
    fi
    echo "$INSTANCE IP Address : $IP"    
done