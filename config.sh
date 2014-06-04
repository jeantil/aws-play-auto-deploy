#!/bin/bash
# Once the configuration is defined, you can comment the following line
# echo "Edit $SCRIPTPATH/config.sh to define application name and s3 settings"
# exit -1
export APPLICATION_NAME=frontweb
export PACKAGES_S3_BASEURL=s3://snapshots.openoox
export CONFIG_S3_BASEURL=s3://env.openoox
export S3_REGION=eu-west-1
