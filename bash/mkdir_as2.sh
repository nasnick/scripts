#!/bin/bash -x

#Get user input
echo "New user: "
read USER
echo "create inbound and outbound (outbound/inbound/both)?"
read OUTBOUND_INBOUND
echo "/var/tmp/ftp/ and /opt/connector/archive/outbound/ dir useri (no dir created if blank)?"
read TMP_DIR_USER

if [ -z "$TMP_DIR_USER" ]; then
  TMP_DIR_USER=$USER
fi

#Variables
BASE_DIR=/home/ftp/nzb2be
USER_DIR=$BASE_DIR/$USER
TMP_DIR=/var/tmp/ftp/$TMP_DIR_USER
ARCHIVE_DIR=/opt/connector/archive/outbound/$TMP_DIR_USER
GROUP=ftp:nogroup
TMP_DIR_GROUP=nobody:nogroup
ARCHIVE_DIR_GROUP=connector:connector


#Make in bound and outbound directories
if [ "$OUTBOUND_INBOUND" = "inbound" ]; then
  mkdir -p $USER_DIR/inbound; chown -R $GROUP $USER_DIR; chmod -R 775 $USER_DIR
elif [ "$OUTBOUND_INBOUND" = "outbound" ]; then
  mkdir -p $USER_DIR/outbound; chown -R $GROUP $USER_DIR; chmod -R 775 $USER_DIR
elif [ "$OUTBOUND_INBOUND" = "both" ]; then
    mkdir -p $USER_DIR/inbound; chown -R $GROUP $USER_DIR; chmod -R 775 $USER_DIR
    mkdir -p $USER_DIR/outbound; chown -R $GROUP $USER_DIR; chmod -R 775 $USER_DIR
fi

#Make TEMP directory
mkdir $TMP_DIR; chown $TMP_DIR_GROUP $TMP_DIR; chmod 777 $TMP_DIR

#Make archive directory
mkdir $ARCHIVE_DIR; chown $ARCHIVE_DIR_GROUP $ARCHIVE_DIR; chmod 775 $ARCHIVE_DIR
