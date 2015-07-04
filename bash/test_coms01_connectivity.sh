#!/bin/bash

REMOTE_HOSTS_1414='
192.168.91.196
169.7.66.1
199.40.29.208
10.160.21.34
10.51.24.71
192.168.217.13
203.98.22.154
202.124.113.27
131.203.79.37
ecngw1.nzpost.co.nz
10.92.8.150
'
#Check connectivity to hosts that connect to port 1414

echo "checking port 1414...."

for i in $REMOTE_HOSTS_1414; do
  echo exit | telnet $i 1414  | grep Connected
  if [ "$?" -eq 1 ]; then
	        echo -e "\n"
        echo -e  "+++++++++++++++++++++++++++++++++++++++++"
  	echo "cannot connect to $i"
	echo -e  "+++++++++++++++++++++++++++++++++++++++++\n"
  else
	echo -e "\n"
	echo -e  "+++++++++++++++++++++++++++++++++++++++++"
	echo -e "All good - could connect to $i"
	echo -e  "+++++++++++++++++++++++++++++++++++++++++\n"
  fi
done

echo "checking port 21...."

#Check connectivity to hosts that connect to port 1414

REMOTE_HOSTS_21='
198.133.252.52
209.95.252.33
61.8.31.118
202.49.200.6
'


for i in $REMOTE_HOSTS_21; do
  echo exit | telnet $i 21  | grep Connected
  if [ "$?" -eq 1 ]; then
                echo -e "\n"
        echo -e  "+++++++++++++++++++++++++++++++++++++++++"
        echo "cannot connect to $i"
        echo -e  "+++++++++++++++++++++++++++++++++++++++++\n"
  else
        echo -e "\n"
        echo -e  "+++++++++++++++++++++++++++++++++++++++++"
        echo -e "All good - could connect to $i"
        echo -e  "+++++++++++++++++++++++++++++++++++++++++\n"
  fi
done
