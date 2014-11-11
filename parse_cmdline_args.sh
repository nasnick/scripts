#!/bin/bash

#DIR="~/update-scripts"
RTL_DIR=$1
INCR=1

#cd into script directory
cd $RTL_DIR

#A count of how many files 
FILES=`ls | wc -l`

#While loop to run scripts in order
while [ $FILES -gt 0 ]
FILE=`ls | grep 0$INCR`
do echo "nohup pgScript -h localhost -d process_activity -U postgres -e ansi $FILE 2> $FILE.log &"

#increment counters
FILES=$((FILES - 1))
INCR=$((INCR + 1))

done
