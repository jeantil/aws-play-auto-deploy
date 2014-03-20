#!/bin/sh
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/env.sh
VERSION=$1
if [ -z "$1" ]; then
  echo "no version provided : aborting"
  exit -1
fi
mkdir -p $APPLICATION_HOME
aws s3 cp --region $CONFIG_S3_BASEURL $PACKAGES_S3_BASEURL/${APPLICATION_NAME}/${APPLICATION_NAME}-$VERSION/$VERSION/zips/${APPLICATION_NAME}-$VERSION.zip /tmp/${APPLICATION_NAME}_2.10.zip
unzip -qo /tmp/${APPLICATION_NAME}_2.10.zip -d $APPLICATION_HOME/../
