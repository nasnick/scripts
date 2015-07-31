#!/bin/bash -x

# Find files in /syslog_archive/prod-tdx-01/portal/ directory that are older than 6 months
# 120 days are used in the find command because the backup script finds and backs up files that
# are 2 months old - so need to build a list based on creation date minus 2 months.

REMOTE_FOLDER=/mnt/archive_to_NAS/syslog_archive/prod-tdx-01/portal/
BACKUP_FOLDER=/mnt/backups/nfs/tdx-backups/prod-tdx-01/syslog_backups/
FILES_TO_BACKUP=$(find $REMOTE_FOLDER -maxdepth 1 -type f -not -name ".*" -ctime  +120)

REMOTE_FOLDER=/mnt/archive_to_NAS/syslog_archive/prod-tdx-01/portal/

# Check if there are any files to copy and exit if there are none

if [ -z "$FILES_TO_BACKUP" ]; then
  exit 1
fi

# Build a list of files md5sum and copy to remote location

for i in $FILES_TO_BACKUP; do
  md5sum $i >> checksumoriginal.txt
  sed 's/.\///g'  checksumoriginal.txt | sort  > checksumoriginalsorted.txt
    cp $i $BACKUP_FOLDER
done

#Get an md5sum of copied files

COPIED_FILES=$(ls /tdx-backups/prod-tdx-01/syslog_archive)

for i in $COPIED_FILES; do
   md5sum TEST/$i sort  >> checksumcopied.txt 
   sed 's/TEST\///g'  checksumcopied.txt | sort > checksumcopiedsorted.txt
done

# Look for differences in the checksum of the files

FILE_DIFF=$(diff -s  checksumoriginalsorted.txt checksumcopiedsorted.txt)

# Check for exit status

DIFF=$(echo "$?")

# If the checksums match then remove the files that were copied

if [ "$DIFF" = "0" ]; then
  for i in $FILES_TO_BACKUP; do
    rm $REMOTE_FOLDER/$i
  done
elif [ "$DIFF" != "0" ]; then
  echo "Checksum didn't match up - check these files: $FILE_DIFF"
fi

#Remove checksum log files

rm checksum*
