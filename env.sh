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
  APPLICATION_DESC=`echo "$APPLICATION_DESC" | python -c 'import json,sys;obj=json.load(sys.stdin);envFilter=lambda x: x["Key"]=="env";roleFilter=lambda x: x["Key"]=="role";tags=[map(lambda x:x["Value"],filter(envFilter,obj["Reservations"][0]["Instances"][0]["Tags"]))[0]];tags.append(map(lambda x:x["Value"],filter(roleFilter,obj["Reservations"][0]["Instances"][0]["Tags"]))[0]);tags.append(obj["Reservations"][0]["Instances"][0]["PrivateIpAddress"]);print(" ".join(tags))'`
  read ENV ROLE IP <<< $(echo $APPLICATION_DESC)
  export APPLICATION_ENV=$ENV
  export APPLICATION_ROLE=$ROLE
  export APPLICATION_IP=$IP
  export APPLICATION_HOME=/home/ec2-user/$APPLICATION_NAME
fi
