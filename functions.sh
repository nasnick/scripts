#!/bin/bash

ERROR=3044
ERROR_DIR="/var/log"
LOG_FILES='syslog
debug
mysql.log'

NUMBER_OF_FILES=$1
INCR=1

function search_log(){
  cd $ERROR_DIR	
  PRESENT="$(cat $i | grep $ERROR | wc -l)"
  echo "Checking $i logfile for $ERROR ..." 
  if [ $PRESENT -gt 1 ]; then
   echo -e "$PRESENT $ERROR Errors in $i logs. Please contact your friendly admin.\n"
  else
    echo -e "No errors in $i log\n"
  fi
}

function increment(){
  NUMBER_OF_FILES=$((NUMBER_OF_FILES - 1))
  INCR=$((INCR + 1))
}


#MAIN
if [ $NUMBER_OF_FILES -gt 0 ]; then
  echo "Iteration number $INCR"
    for i in $LOG_FILES; 
      do search_log
        increment
  done
fi
