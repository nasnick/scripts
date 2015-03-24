#!/bin/bash -x

a=3

if [ $a -ne 0 ]; then
 echo "Not zero"
 let "a = $a - 1"
 if [ $a -ne 0 ]; then
  echo "Not zero"
  let "a = $a - 1"
   if [ $a -ne 0 ]; then
  echo "Not zero"
  let "a = $a - 1"
   if [ $a -ne 0 ]; then
    echo "Not zero"
    let "a = $a - 1"
   else
    sleep 2
    echo "exiting"
    exit 0
   fi
  fi
 fi
fi
