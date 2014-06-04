#!/bin/sh -e
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/config.sh
source $SCRIPTPATH/env.sh
VERSION=$1
if [ -z "$1" ]; then
  echo "no version provided : aborting"
  exit -1
fi
rm -rf $APPLICATION_HOME
ln -s `dirname $APPLICATION_HOME`/${APPLICATION_NAME}-$VERSION $APPLICATION_HOME
mkdir -p $APPLICATION_HOME/logs
