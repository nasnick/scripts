#Bash examples

#check for a zero byte string

VAR="hello"
if [ -n "$VAR" ]; then
    echo "VAR is not empty"
fi

Similarly, the -z operator checks whether the string is null. ie:

VAR=""
if [ -z "$VAR" ]; then
    echo "VAR is empty"
fi


#Get user input - create folder if variable not blank
echo "New user: "
read USER
echo "/var/tmp/ftp/ and /opt/connector/archive/outbound/ dir user (no folder created if blank)?"
read TMP_DIR_USER

if [ -z "$TMP_DIR_USER" ]; then
  TMP_DIR_USER=$USER
fi

echo $USER
echo $TMP_DIR_USER

#create a folder if user input is "y"

echo "Do you want an outbound folder created (y/n)?"
read CREATE_OUTBOUND

if [ "$CREATE_OUTBOUND" = "y" ]; then
  mkdir HERE_IT_IS
else
 echo "try again"
fi
 
#find and list full file path:
find . -type f -ls | grep Ch.*Lab[1-9]$

#Find files that end in either/ or:
find . -type f \( -name "*.txt" -o -name "*.rog" \)
