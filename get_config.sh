#!/bin/sh
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/env.sh
if [ -n "$VERSION" ]; then
  APP_PATH=$APPLICATION_HOME/../${APPLICATION_NAME}-$VERSION
else
  APP_PATH=$APPLICATION_HOME
fi
aws s3 cp --region $S3_REGION $CONFIG_S3_BASEURL/$APPLICATION_ROLE/$APPLICATION_ENV/env.conf $APP_PATH/conf/env.conf
aws s3 cp --region $S3_REGION $CONFIG_S3_BASEURL/$APPLICATION_ROLE/$APPLICATION_ENV/hazelcast.xml $APP_PATH/conf/hazelcast.xml
aws s3 cp --region $S3_REGION $CONFIG_S3_BASEURL/$APPLICATION_ROLE/$APPLICATION_ENV/logger.xml $APP_PATH/conf/logger.xml
