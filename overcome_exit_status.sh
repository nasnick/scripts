#!/bin/bash
PATH_TO_LOGS='/var/log'
LOGS='weekly.out
authd.log'

grep 'Rebuilding whatis database:' /var/log/weekly.out
if [ $? -eq 0 ]; then
  echo "well is this going to work?"
fi

grep 'ronald regan' /var/log/weekly.out
if [ $? -eq 0 ]; then
  echo "well is this going to work still?"
fi

for i in $LOGS; 
  do grep 'Nov 12 20:21:06' $PATH_TO_LOGS/$i;
  if [ $? -eq 0 ]; then
	  echo "this isn't on"
  sleep 3
  fi
done

grep yankee /var/log/weekly.out
echo $?
if [ $? -eq 0 ]; then
  echo "well is this going to work?"
fi
