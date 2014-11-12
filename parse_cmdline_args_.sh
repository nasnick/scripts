#!/bin/bash
RTL_DIR=$1
cd "$RTL_DIR"

for i in "${@:2}"
#do echo "nohup pgScript -h localhost -d process_activity -U postgres -e ansi $i 2> $i.log &"
do echo "$i"
#sleep 5

done
