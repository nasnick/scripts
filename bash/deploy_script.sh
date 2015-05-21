#!/bin/bash -x
set -e

#Nick Schofield 11-11-2014

#Usage: ./deploy.sh <folder_containing_script> <host>
#e.g. ./deploy.sh RTL_5_3_0_D124 0001-db-prod-ndc

#variables
SCRIPT_PATH="XXXX"
RTL_DIR=$SCRIPT_PATH/$1
INCR=1
DB_ENVIRON=$2


function errors(){					#Check for errors in log
  ERROR="$(grep -e 'Error: PGSCRIPT:' -e ERROR $FILE.log | wc -l)"
    if [ $ERROR -gt 0 ]; then
      ERROR_SCRIPT=$(grep ERROR $FILE.log | sed -e 's/^[ \t]*//')
      ERROR_PGSCRIPT=$(grep 'Error: PGSCRIPT:' $FILE.log | sed -e 's/^[ \t]*//')
	  if [ ! -z "$ERROR_SCRIPT" ]; then
	    echo "Issue with script - contact script author. Issue ==> '$ERROR_SCRIPT'"
            exit 1
   	  else
	    echo "Issue connecting to database - check hostname is correct. Issue ==> '$ERROR_PGSCRIPT'"
	    exit 1
          fi
    else
      echo "########## NO ERROR IN LOG ##########"
    fi
}

function increment(){					#increment counters
	NUMBER_OF_FILES=$((NUMBER_OF_FILES - 1))
	INCR=$((INCR + 1))
}

#MAIN

cd $RTL_DIR
NUMBER_OF_FILES=$(ls | wc -l)
NAME_ERROR=$(ls | grep ^$INCR.*pgs$ | wc -l)
LOG_PRESENT=$(ls | grep log$ | wc -l)

#remove any log files that were created when scripts run in different environments

if [ $LOG_PRESENT -ne 0 ]; then
  rm *.log
fi 

while [ $NUMBER_OF_FILES -ne 0 ]; do
  NAME_ERROR=$(ls | grep ^$INCR.*pgs$ | wc -l)
  DUPLICATE=$(ls | grep ^$INCR | uniq -u | wc -l)
  if [ $NAME_ERROR -eq 0 ] || [ $DUPLICATE -gt 1 ]; then
    echo "Either no script to run or one of the scripts is't named correctly. Contact author."
    exit 1
  else    
    FILE=$(ls | grep ^$INCR.*pgs$)
      /usr/bin/pgScript -h $DB_ENVIRON -d process_activity -U postgres -e ansi $FILE 2>&1 | tee $FILE.log
      sleep 2
      errors
      increment
  fi
done

