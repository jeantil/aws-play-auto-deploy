#!/bin/sh
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
source $SCRIPTPATH/config.sh
source $SCRIPTPATH/env.sh
STOP_TIMEOUT=10
if [ -f $APPLICATION_HOME/RUNNING_PID ]; then
  RUNNING_PID=`cat $APPLICATION_HOME/RUNNING_PID`
  echo "Stopping application $RUNNING_PID ..."
  kill `cat $APPLICATION_HOME/RUNNING_PID`
  sleep $STOP_TIMEOUT
  ps -e | grep $RUNNING_PID 
  ZOMBIE_PID=`ps -e | grep $RUNNING_PID | grep java | head -1 | cut  -d" " -f1`
  if [ ! -z "$ZOMBIE_PID" ]; then
     echo "Application hasn't stopped after $STOP_TIMEOUT seconds, kill with SIG_TERM..."
     kill -9 $ZOMBIE_PID
     
  fi
  ps -e | grep $RUNNING_PID 
  ZOMBIE_PID=`ps -e | grep $RUNNING_PID | grep java | head -1 | cut  -d" " -f1`
  if [ ! -z "$ZOMBIE_PID" ]; then
    echo "Application $ZOMBIE_PID is still running"
  else
    echo "Application has stopped"
    rm -rf $APPLICATION_HOME/RUNNING_PID 2>&1 > /dev/null
  fi
else
  RUNNING_PID=`ps -e | grep java | grep $APPLICATION_NAME | head -1 | cut -d" " -f1`
  if [ ! -z "$RUNNING_PID"]; then
    echo "Detected probable application running with process info"
    ps -e | grep java | grep $APPLICATION_NAME
    read -p "Are you sure you want to kill this application ? [y/n]" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[YyOo]$ ]]
    then
      kill -9 $ZOMBIE_PID
      ZOMBIE_PID=`ps -e | grep $RUNNING_PID | head -1 | cut  -d" " -f1`
      if [ ! -z "$ZOMBIE_PID" ]; then
        echo "Application $ZOMBIE_PID is still running"
      else
        echo "Application has stopped"
        rm $APPLICATION_HOME/RUNNING_PID
      fi
    fi
  else
    echo "application is not started"
  fi
fi
