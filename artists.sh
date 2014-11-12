#!/bin/bash
#Usage: ./artists_sort.sh -y 1 artists 2
#can't explain the 1 after -y

while getopts :y: opt;
do
  case $opt in
  y )
      header=$OPTARG
  ;;
  esac
done

shift $(($OPTIND - 1))

echo -e -n ${header:+"ALBUMS ARTIST\n"}

filename=$1
howmany=$2

filename=${filename:?"missing"}
sort -nr $filename | head -${howmany:=10}
