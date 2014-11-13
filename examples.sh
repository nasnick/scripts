#Bash examples

VAR="hello"
if [ -n "$VAR" ]; then
    echo "VAR is not empty"
fi

Similarly, the -z operator checks whether the string is null. ie:

VAR=""
if [ -z "$VAR" ]; then
    echo "VAR is empty"
fi
