#!/bin/sh
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/env.sh

sudo rm /tmp/VERSION &> /dev/null
sudo rm /var/log/cloud-init.log &> /dev/null
rm -rf /home/ec2-user/newrelic/logs/*.log
rm -rf "$APPLICATION_HOME"
echo ${APPLICATION_HOME}-* | xargs rm -r &> /dev/null
sudo rm /var/lib/cloud/sem/* &>/dev/null

