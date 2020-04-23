#!/bin/bash

DATE=$(date +%Y-%m-%d)
APP_AMI_NAME="App_Backup - $DATE"
CALC_AMI_NAME="Calc_Backup - $DATE"
AMI_DESCRIPTION="Backup - $DATE"
INSTANCE_ID_APP=i-0fsfXXXXXXXXX
INSTANCE_ID_CALC=i-0eeXXXXXXXXX


#Creating AMI for App instance
echo "\e[31;43m***** Requesting AMI for APP instance $INSTANCE_ID_APP *****\e[0m"
aws ec2 create-image --instance-id $INSTANCE_ID_APP --name "$APP_AMI_NAME" --description "$AMI_DESCRIPTION" --no-reboot | grep -i ami | awk '{print $4}' > /tmp/amiID.txt
if [ $? -eq 0 ]; then
	echo "\e[31;43m***** AMI for APP instance $INSTANCE_ID Completed *****\e[0m"
fi

#Creating AMI for Calc instance
echo "\e[31;43m***** Requesting AMI for CALC instance $INSTANCE_ID_CALC *****\e[0m"
aws ec2 create-image --instance-id $INSTANCE_ID_CALC --name "$CALC_AMI_NAME" --description "$AMI_DESCRIPTION" --no-reboot
if [ $? -eq 0 ]; then
        echo "\e[31;43m***** AMI for CALC instance $INSTANCE_ID_CALC Completed *****\e[0m"
fi
