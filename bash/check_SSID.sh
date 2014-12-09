#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/nschofield/scripts_git/bash

SSID=$(iwconfig wlan0 | head -1 | awk -F\" '{print $2}')
SSID_HOME="R0gern0mics" 
SSID_WORK="ecn_wireless"
SCRIPT="/home/nschofield/scripts_git/bash/resolve.sh"

if [ $SSID == $SSID_HOME ] 
  then 
    sudo $SCRIPT -h
elif [ $SSID == $SSID_WORK ]
  then
    sudo $SCRIPT -w
fi
