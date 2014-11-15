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
<<<<<<< Local Changes


#!/bin/bash
PATH_TO_LOGS='/var/log'
LOGS='weekly.out
authd.log'

grep 'leaving (1) step instbootloader' /var/log/anaconda.log
if [ $? -eq 0 ]; then
  echo "well is this going to work?"
fi

grep 'ronald regan' /var/log/anaconda.log
if [ $? -eq 0 ]; then
  echo "you there ronald?"
  exit 1
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
fi=======

##################

PATH_TO_LOGS='/var/log'
LOGS='weekly.out
authd.log'

grep 'leaving (1) step instbootloader' /var/log/anaconda.log
if [ $? -eq 0 ]; then
  echo "well is this going to work?"
  sleep 2
fi

ERROR="$(grep 'leaving (1) step instbootloader' /var/log/anaconda.log | wc -l)"
echo $ERROR
if [ $ERROR -gt 0 ]; then
  echo "no good. exiting...."
 sleep 2
fi

ERROR="$(grep 'ronald regan' /var/log/anaconda.log | wc -l)"
echo $ERROR
if [ $ERROR -eq 0 ]; then
  echo "you there ronald?"
fi

ERROR="$(grep 'leaving (1) step instbootloader' /var/log/anaconda.log | wc -l)"
echo $ERROR
if [ $ERROR -gt 0 ]; then
  echo "made it to the end no dramas"
fi

>>>>>>> External Changes
