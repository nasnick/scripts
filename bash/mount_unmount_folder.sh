#!/bin/bash -x
# $1 values: 1 is for mounting, 0 is for unmounting

MOUNT_OR_UNMOUNT=$1
MOUNT_POINT=$RD_OPTION_MOUNT_POINT
EXIT_STATUS=0

# Mount folders if $1 is set to '1'
if [ "$MOUNT_OR_UNMOUNT" -eq "1" ];then
  for MOUNT in $MOUNT_POINT; 
    do
    MOUNTED=$(mount | grep $MOUNT | wc -l)
      if [ "$MOUNTED" -eq "1" ]; then 
        sudo umount $MOUNT && sudo mount $MOUNT
        MOUNTED=$(mount | grep $MOUNT | wc -l)
        if [ "$MOUNTED" -eq "0" ]; then
          echo "Issue mounting $MOUNT folder... exiting"
          exit 1
        fi
      else 
        sudo mount $MOUNT
        MOUNTED=$(mount | grep $MOUNT | wc -l)
        if [ "$MOUNTED" -eq "0" ]; then
          echo "Issue mounting $MOUNT folder... exiting"
          exit 1
        fi
      fi
   done
fi

# Unmount folders if $1 is set to '0'
if [ "$MOUNT_OR_UNMOUNT" -eq "0" ];then
  for MOUNT in $MOUNT_POINT;
    do
    MOUNTED=$(mount | grep $MOUNT | wc -l)
      if [ "$MOUNTED" -eq "1" ]; then
      sudo umount $MOUNT
      MOUNTED=$(mount | grep $MOUNT | wc -l)
      if [ "$MOUNTED" -eq "1" ]; then
          echo "Issue unmounting $MOUNT folder... exiting"
          EXIT_STATUS=1
          TROUBLESOME_FOLDER=$MOUNT
        fi
     elif [ "$MOUNTED" -eq "0" ]; then
       echo "$MOUNT wasn't mounted"
     fi
  done
  # Generate a failed exit status if there was an issue unmounting any of the folders
  if [ "$EXIT_STATUS" -eq "1" ]; then
    echo "Issue unmounting $TROUBLESOME_FOLDER"
    exit 1
  fi
fi
