#!/bin/sh -e
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/config.sh
source $SCRIPTPATH/env.sh
MAXWAIT=30
function check {
  nc -vz localhost 9000 &>/dev/null
}
export APP_JVM_OPTS=""

if [ -f $HOME/$APPLICATION_NAME/conf/jvm.sh ]; then
  source $HOME/$APPLICATION_NAME/conf/jvm.sh
fi 
#export NEWRELIC_OPTS="-Dnewrelic.environment=$APPLICATION_ENV -J-javaagent:$HOME/newrelic/newrelic.jar"
#export HAZELCAST_OPTS="-Dhazelcast.logging.type=slf4j -Dhazelcast.icmp.enabled=true"
mkdir -p $APPLICATION_HOME/logs

$APPLICATION_HOME/bin/$APPLICATION_NAME $APP_JVM_OPTS   \
  -Dapplication.home=$HOME/$APPLICATION_NAME/           \
  -Dlogger.file=$HOME/$APPLICATION_NAME/conf/logger.xml \
  -Dconfig.file=$HOME/$APPLICATION_NAME/conf/env.conf   \
  &>$APPLICATION_HOME/logs/startup.log & 

COUNTER=0;
while ! check && [ $COUNTER -lt $MAXWAIT ]  ;do
sleep 5
 COUNTER=$[$COUNTER+1]
done
echo "starting application"
check && curl http://localhost:9000/ping && echo
