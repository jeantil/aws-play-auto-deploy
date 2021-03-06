#!/bin/sh -e
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/config.sh
source $SCRIPTPATH/env.sh
if [ -n "$VERSION" ]; then
  APP_PATH=$APPLICATION_HOME/../${APPLICATION_NAME}-$VERSION
else
  APP_PATH=$APPLICATION_HOME
fi

S3_APPLICATION_PATH="$CONFIG_S3_BASEURL/$APPLICATION_ROLE/$APPLICATION_ENV/"

aws s3 cp --recursive --region $S3_REGION $S3_APPLICATION_PATH $APP_PATH/conf
