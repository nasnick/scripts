#!/bin/bash

#Takes input from user

echo "Trigger folder: "
read TRIG_FOLDER
echo "Queue: "
read queue
queue1=`awk -F. queue1="$queue" '{ print $1, '_', $2 }'queue1` 
echo $queue1

#didn’t know how to escape so created variables

#Define folders to be created

MQTRIGUATFOLDER=/usr/local/ecnet/Connector/mqtrig/uat.ftp.$TRIG_FOLDER
MQTRIGPRODFOLDER=/usr/local/ecnet/Connector/mqtrig/prod.ftp.$TRIG_FOLDER

perl="'perl /usr/local/ecnet/scripts/mqtrig.pl'"
PROD_ENVIRDATA="'$MQTRIGUATFOLDER -w 5 &'"
UAT_ENVIRDATA="'$MQTRIGUATFOLDER -w 5 &'"

#Echo output. Don’t forget to put the last “ in the right place - ) ⇐ here |runmqsc

echo "define qlocal(PROD.FTP.$queue) defpsist(yes) trigger process(MQTRIG_$queue) initq(SYSTEM.DEFAULT.INITIATION.QUEUE) CLUSTER(ECN.PROD) |runmqsc"
echo "define process(MQTRIG_$queue) APPLICID($perl) ENVRDATA($PROD_ENVIRDATA) | runmqsc"
echo "define qlocal(UAT.FTP.$queue) trigger process(MQTRIG_"$queue"_UAT) initq(SYSTEM.DEFAULT.INITIATION.QUEUE) CLUSTER(ECN.UAT) | runmqsc"
echo "define process(MQTRIG_"$queue1"_UAT) APPLICID($perl) ENVRDATA($UAT_ENVIRDATA) | runmqsc"

#Make folders 

echo "mkdir -p $MQTRIGUATFOLDER && chown connector:client $MQTRIGUATFOLDER && chmod 777 $MQTRIGUATFOLDER" 
echo "mkdir -p $MQTRIGPRODFOLDER && chown connector:client $MQTRIGPRODFOLDER && chmod 777 $MQTRIGPRODFOLDER"

