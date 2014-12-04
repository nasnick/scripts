#!/bin/bash

#!/bin/bash
 
PATH_TO="/etc"
MAIN_FILE="/etc/resolv.conf"

FILE_HOME="resolv.conf.HOME"
FILE_WORK="resolv.conf.WORK"

HOME=$PATH_TO/$FILE_HOME
WORK=$PATH_TO/$FILE_WORK

while getopts "hw" opt; do
  case $opt in
    h)
      $(cp $HOME $MAIN_FILE) >&2
      ;;
    w)
      $(cp $WORK $MAIN_FILE) >&2
      ;;
  esac
done
shift $(($OPTIND - 1))
