#!/bin/bash
#ask the user for a name of folder and destination
echo "enter name of folder"
read folder_name
echo "Where would you like to move it?"
read move_location

#variablise folder name and  date
folder_date=$folder_name.`date +%F`

#make directory
mkdir ~/$folder_date

#Copy to folder
cp -r ~/$folder_date $move_location
