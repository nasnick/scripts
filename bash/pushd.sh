#!/bin/sh

pushd ()
{
dirname=$1
if cd ${dirname:?"missing directory name."}
then
DIR_STACK="$dirname ${DIR_STACK:-$PWD' '}"
echo $DIR_STACK
else 
echo still in $PWD.
fi
}
pushd "$1"
