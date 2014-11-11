#!/bin/bash
#Nick Schofield 11-11-2014

#Usage: ./deploy.sh <folder_containing_script>
#e.g. ./deploy.sh RTL_5_3_0_D124

#variables
RTL_DIR=$1
INCR=1

#cd into script directory
cd $RTL_DIR

#A count of how many files 
NUMBER_OF_FILES=`ls | wc -l`

#While loop to run scripts in order
while [ $NUMBER_OF_FILES -gt 0 ]
  FILE=`ls | grep ^0$INCR.*pgs$`

#Run script
 do echo "nohup pgScript -h localhost -d process_activity -U postgres -e ansi $FILE 2> $FILE.log &"

#Check for errors in log
grep ERROR $FILE.log
  if [ $? -eq 0 ]; then
    echo "Error in script. Contact author."
  exit 1
fi

#increment counters
NUMBER_OF_FILES=$((NUMBER_OF_FILES - 1))
INCR=$((INCR + 1))

sleep 2

done
