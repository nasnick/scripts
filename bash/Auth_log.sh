#!/bin/bash

User=$1
Users=`cat /etc/passwd | awk -F: '{print$1}'`
Match="0"
for i in $Users
do
  if [ "$i" ==  "$User" ];
	then
	User_found="$i"
	Match="1"
	Failed_Logins=`sudo cat /var/log/auth.log | grep $User_found | grep "authentication failure" | wc -l`
	echo "$User_found has $Failed_Logins failed login attempts";
    fi
done
if [ "$Match" = "0" ]
	then
	echo "user not in file"; 
fi
