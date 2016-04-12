#!/bin/bash

food='fish
chips
lollies
sauce'

for i in $food; do 
  echo $i | grep i
  if [ "$?" -eq "0" ]; then
    exit 1
  fi
done
