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
