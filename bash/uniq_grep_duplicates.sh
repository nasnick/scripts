#!/bin/bash

INCR=1


if  [ $(ls | grep ^$INCR | uniq -u | wc -l) -gt 1 ]; then
 echo "duplicate"
else
 echo "no dupe"
fi
