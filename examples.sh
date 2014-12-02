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

#Store all command line arguments in a variable

A="$@"
for i in $A; 
do printf "$i"
sleep 5
done
