#!/bin/bash -x
set -e

#Nick Schofield 11-11-2014

#Usage: ./deploy.sh <folder_containing_script> <host>
#e.g. ./deploy.sh RTL_5_3_0_D124 0001-db-prod-ndc

#variables
SCRIPT_PATH="/var/rundeck/projects/RTL-Deployment/rtl-update-scripts"
RTL_DIR=$SCRIPT_PATH/$1
INCR=1
DB_ENVIRON=$2


function errors(){                                      #Check for errors in log
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
      echo "No error in log"
    fi
}

function increment(){                                   #increment counters
        NUMBER_OF_FILES=$((NUMBER_OF_FILES - 1))
        INCR=$((INCR + 1))
}

#MAIN

cd $RTL_DIR
NUMBER_OF_FILES=$(ls | wc -l)
NAME_ERROR=$(ls | grep ^$INCR.*pgs$ | wc -l)

while [ $NUMBER_OF_FILES -gt 0 ]; do
  if [ $NAME_ERROR -eq 0 ]; then
    echo "Either no script to run or the script is not named correctly. Contact author"
    exit 1
  else
    FILE=$(ls | grep ^$INCR.*pgs$)
      /usr/bin/pgScript -h $DB_ENVIRON -d process_activity -U postgres -e ansi $FILE 2>&1 | tee $FILE.log
      sleep 5
      errors
      increment
  fi
done

