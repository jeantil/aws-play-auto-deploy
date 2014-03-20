#!/bin/bash
export SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/config.sh
if [ -z "$APPLICATION_NAME" ]; then
 echo "APPLICATION NAME IS NOT CONFIGURED aborting"
 exit -1
fi 
if [ -z "$INSTANCE_ID" ]; then
  export INSTANCE_ID=`/opt/aws/bin/ec2-metadata | grep instance-id | cut -d' ' -f2`
  APPLICATION_DESC=`aws ec2 describe-instances --instance-ids $INSTANCE_ID --region eu-west-1`
  export APPLICATION_ENV=`echo "$APPLICATION_DESC" | python -c 'import json,sys;obj=json.load(sys.stdin); print(map((lambda x:x["Value"]),filter((lambda x: x["Key"]=="env"),obj["Reservations"][0]["Instances"][0]["Tags"])))[0]'`
  export APPLICATION_ROLE=`echo "$APPLICATION_DESC" | python -c 'import json,sys;obj=json.load(sys.stdin); print(map((lambda x:x["Value"]),filter((lambda x: x["Key"]=="role"),obj["Reservations"][0]["Instances"][0]["Tags"])))[0]'`  
  export APPLICATION_HOME=/home/ec2-user/$APPLICATION_NAME
fi
