#!/bin/bash

orig=(1 2 3 4 5)

printf "%d\n" ${orig[@]}  | sort | uniq -c | awk '{print $2, $1==1?"No match PASS":"match FAIL"}' | grep FAIL

if [ "$?" -eq 0 ]; then 
  echo "we have a match"
else
  echo "no match"
fi
