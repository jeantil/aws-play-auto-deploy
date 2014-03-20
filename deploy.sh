#!/bin/sh
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/config.sh
source $SCRIPTPATH/env.sh
export PATH=$PATH:$HOME/bin/
if [ -z "$1" ]; then
  rm -rf /tmp/VERSION 
  aws s3 cp --region $S3_REGION $CONFIG_S3_BASEURL/$APPLICATION_ROLE/$APPLICATION_ENV/VERSION /tmp/VERSION
  export VERSION=`cat /tmp/VERSION`
  if [ -z "$VERSION" ]; then
    echo "unable to determine version, aborting"
    exit -1; 
  fi
else
  export VERSION=$1
fi
echo $VERSION
$SCRIPTPATH/get_package.sh $VERSION
$SCRIPTPATH/get_config.sh $VERSION
$SCRIPTPATH/app_shutdown.sh 
$SCRIPTPATH/logstash_stop.sh
$SCRIPTPATH/switch_package.sh $VERSION
$SCRIPTPATH/app_startup.sh
$SCRIPTPATH/logstash.sh $VERSION 
