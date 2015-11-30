#!/bin/bash -x
# $1 values: 1 is for mounting, 0 is for unmounting
 
MOUNTING=$1
MOUNT_POINT=$RD_OPTION_MOUNT_POINT
EXIT_STATUS=0
TROUBLESOME_FOLDERS=""
 
if test -z '$MOUNT_POINT'; then
                echo "There is nothing to be mounted or unmounted... exiting"
                exit 1
fi
 
for MOUNT in $MOUNT_POINT;
do
 
                # Check if it's already mounted
                MOUNTED=$(mount | grep $MOUNT | wc -l)
 
                case $MOUNTING in
               
                # Mount the folder(s)
                1)
                               
                                # Unmount if already mounted
                                if [ "$MOUNTED" -eq "1" ];then
                                                umount $MOUNT && mount $MOUNT
                                else
                                                mount $MOUNT
                                fi
               
                                # Check if the mount was successful or not
                                MOUNTED=$(mount | grep $MOUNT | wc -l)
               
                                if [ "$MOUNTED" -eq "0" ]; then
                                                echo "Issue mounting $MOUNT folder... exiting"
                                                exit 1
                                fi
                               
                                ;;
               
                # Unmount the folder(s)
                0)
 
                                if [ "$MOUNTED" -eq "1" ]; then
                                                umount $MOUNT
                                fi
                                                                               
                                MOUNTED=$(mount | grep $MOUNT | wc -l)
                                if [ "$MOUNTED" -eq "1" ]; then
                                                echo "Issue unmounting $MOUNT folder... exiting"
                                                EXIT_STATUS=1
                                                TROUBLESOME_FOLDERS=$TROUBLESOME_FOLDERS"$MOUNT "
                                fi
                               
                                ;;
               
                                *)
                                ;;
               
                esac
               
done
 
# Generate a failed exit status if there was an issue unmounting any of the folders
if [ "$EXIT_STATUS" -eq "1" ]; then
                echo "Issue unmounting $TROUBLESOME_FOLDERS"
                exit 1
fi
