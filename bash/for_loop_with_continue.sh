#!/bin/bash -x

DIRS='testa
testb'

for i in $DIRS; do
  CONTENTS=$(ls $i | wc -l)
  if [ "$CONTENTS" -eq "0" ]; then
    echo "nothing there... continuing"
     continue
     echo "can you see this?"
  elif [ "$CONTENTS" -gt "0" ]; then
    rm -rf $i/*
  fi
done
