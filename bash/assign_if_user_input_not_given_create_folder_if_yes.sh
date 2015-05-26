#!/bin/bash -x

#Get user input
echo "New user: "
read USER
echo "/var/tmp/ftp/ and /opt/connector/archive/outbound/ dir user?"
read TMP_DIR_USER

if [ -z "$TMP_DIR_USER" ]; then
  TMP_DIR_USER=$USER
fi

echo $USER
echo $TMP_DIR_USER


echo "Do you want an outbound folder created (y/n)?"
read CREATE_OUTBOUND

if [ "$CREATE_OUTBOUND" = "y" ]; then
  mkdir HERE_IT_IS
else
 echo "try again"
fi
