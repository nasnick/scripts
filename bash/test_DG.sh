#!/bin/bash
 
DEFAULT=""
FIBRE=10.0.8.254
VDSL=192.168.1.254
while getopts "fv" opt; do
  case $opt in
    f)
      DEFAULT=$FIBRE >&2
      ;;
    v)
      DEFAULT=$VDSL >&2
      ;;
  esac
done
shift $(($OPTIND - 1))
sudo /sbin/route del default
sudo /sbin/route add default gw $DEFAULT
