#!/bin/bash -x

for MOUNT in $RD_OPTION_MOUNT_POINT;do
  NUMBER_OF_FILES=$(ls $MOUNT | wc -l)
  FOLDER_CONTENTS=$(ls $MOUNT)
  DATE=$(date +%y%m%d)

  if [ "$NUMBER_OF_FILES" -eq  "0" ]; then
    echo "No files to copy.. exiting"
     continue  

  elif [ "$NUMBER_OF_FILES" -gt "0" ]; then
    NUMBER_OF_FILES_TO_COPY=$(ls $MOUNT | wc -l)
   
    for i in $FOLDER_CONTENTS; do
      #sudo cp $RD_OPTION_MOUNT_POINT/$i.$DATE.tz $RD_OPTION_BACKUP_DIR
      sudo cp $MOUNT/$i $RD_OPTION_BACKUP_DIR
    done
     
     ls -ltr $MOUNT | awk '{print $5,$9}' | tail -n +2 >> archive_files_remote.txt 
     ls -ltr $RD_OPTION_BACKUP_DIR | awk '{print $5,$9}' | tail -$NUMBER_OF_FILES_TO_COPY >> archive_files_backup.txt
  
     cat archive_files_remote.txt | sort > archive_files_remote_sorted.txt
     cat archive_files_backup.txt | sort > archive_files_backup_sorted.txt
     
     diff -s archive_files_remote_sorted.txt archive_files_backup_sorted.txt
     STATUS=$(echo "$?")

     if [ "$STATUS" -eq "0" ]; then
       rm $MOUNT/*
       rm archive_files*
   
     elif [ "$STATUS" -gt "0" ];then
       echo "Files not successfully copied - they will be left on the server... exiting"
       rm archive_files*
       exit 1
    fi
  fi
done
