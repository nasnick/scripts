#!/bin/bash

orig=(1 2 3 4 5 1)
incr=1

printf "%d\n" ${orig[@]}  | sort | uniq -c | awk '{print $2, $1==1?"a=1":"a=2"}';do 
echo $a
  if [ $a -eq 2 ]; then
    echo "we have a match"
  else
    echo "no worries... continue"
  fi
done

