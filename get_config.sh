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

aws s3 cp --region $S3_REGION $S3_APPLICATION_PATH/env.conf $APP_PATH/conf/env.conf
aws s3 cp --region $S3_REGION $S3_APPLICATION_PATH/hazelcast.xml $APP_PATH/conf/hazelcast.xml
aws s3 cp --region $S3_REGION $S3_APPLICATION_PATH/logger.xml $APP_PATH/conf/logger.xml
aws s3 cp --region $S3_REGION $S3_APPLICATION_PATH/jvm.sh $APP_PATH/conf/jvm.sh
