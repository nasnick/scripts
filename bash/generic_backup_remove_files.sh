#!/bin/bash -x
# Nick - 03/08/2015
#1/ Copies files from remote server and checks if they are the same size
#2/ Keeps x amount of days worth of files on the remote server, deleting the rest

ERRORS=0
SERVER=$RD_OPTION_SERVER
SPECIFIC_FOLDER=$RD_OPTION_SPECFIC_FOLDER
REMOTE_FOLDER=$RD_OPTION_REMOTE_FOLDER
BACKUP_FOLDER=$RD_OPTION_BACKUP_FOLDER

for i in $SPECIFIC_FOLDER; do
		FILES_TO_BACKUP=$(sudo find $REMOTE_FOLDER/$i -maxdepth 1 -type f -not -name ".*" \
			-ctime -$RD_OPTION_FILES_NEWER_THAN)
		FILES_TO_REMOVE_FROM_SERVER=$(sudo find $REMOTE_FOLDER/$i -maxdepth 1 -type f -not -name ".*" \
			-ctime +$RD_OPTION_REMOVE_FILES_OLDER_THAN)

	# Check if there are any files to copy and exit if there are none
	if [ -z "$FILES_TO_BACKUP" ] && [ -z "$FILES_TO_REMOVE_FROM_SERVER" ]; then
			echo "No files to backup or remove... continuing to next folder."
			continue
	fi
	
	# Create list of filesizes to be copied and sort them so they can be compared once copying is complete
	sudo find $REMOTE_FOLDER/$i -maxdepth 1 -type f -not -name ".*" -ctime -$RD_OPTION_FILES_NEWER_THAN \
	-ls | awk '{print $7,$11}' | sed -e 's/'$RD_OPTION_REMOTE_FOLDER_PATH_SED'\/'$i'\///g' >> filelistoriginal.txt

	cat filelistoriginal.txt | sort  > filelistoriginalsorted.txt

	# Copy files
	for FILE in $FILES_TO_BACKUP; do
	    	sudo cp -a $FILE $BACKUP_FOLDER/$i
	done

	# Build a list of copied file sizes
	sudo find $BACKUP_FOLDER/$i -maxdepth 1 -type f -not -name ".*" -ctime  -1 -ls | awk '{print $7,$11}' \
	| sed -e 's/'$RD_OPTION_LOCAL_FOLDER_PATH_SED'\/'$i'\///g' >> filelistcopied.txt
	cat filelistcopied.txt | sort > filelistcopiedsorted.txt

	# Make sure that the files are both in the remote and local directories before removing from source
	FILE_DIFF=$(diff -s  filelistoriginalsorted.txt filelistcopiedsorted.txt)

	# Check for exit status
	DIFF=$(echo "$?")

	# If the exit status is '0' then provide success log message
	if [ "$DIFF" = "0" ]; then
			echo "Files successfully copied"
		
		    #Remove files that are older than specified
		    for i in $FILES_TO_REMOVE_FROM_SERVER; do
		    sudo rm $i
		    done
            #Remove list of files
		    rm filelist*

	#Otherwise, take note of the failure in '$ERRORS' variable to be used in final 'if' statement and continue    
	elif [ "$DIFF" != "0" ]; then
			echo "Files weren't successfully copied"
		    
		    #count errors backing up files
		    ERRORS=$((ERRORS + 1))
            
            #Remove list of files
		    rm filelist*
			continue
	fi
done

if [ "$ERRORS" -gt "0" ]; then
		echo "There was an issue copying files on $RD_OPTION_SERVER"
 		exit 1
fi