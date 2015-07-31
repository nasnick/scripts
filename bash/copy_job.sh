#!/bin/bash -x

A=$(find . -maxdepth 1 -type f -not -name ".*" | grep Racoon[2-7])

if [ -z "$A" ]; then
  exit 1
fi

for i in $A; do
  md5sum $i >> checksumoriginal.txt
  cat  checksumoriginal.txt | sort  > checksumoriginalsorted.txt
  sed 's/.\///g' checksumoriginalsorted.txt > checksumoriginal.txt
    cp  $i TEST
done

#echo "hellothere" > TEST/Racoon2.txt

B=`ls TEST`
for i in $B; do
   md5sum TEST/$i sort  >> checksum.txt 
   cat checksum.txt | sort > checksumsorted.txt
   sed 's/TEST\///g' checksumsorted.txt > checksum.txt
     cp $i TEST
done

FILE_DIFF=$(diff -s  checksum.txt checksumoriginal.txt)

DIFF=$(echo "$?")

if [ "$DIFF" = "0" ]; then
  for i in $A; do
    rm $i
  done
elif [ "$DIFF" != "0" ]; then
  echo "Checksum didn't match up - check these files: $FILE_DIFF"
fi

rm checksum*
