#!/bin/bash
DATE=`date +"%d-%m-%Y-%H:%M"`
TAMPER=0
EXIT_STATUS=0

while IFS='' read -r line || [[ -n "$line" ]]; do
      
      SITE=$(echo $line | awk -F, '{print $1}')
      TEXT=$(echo $line | cut -d '"' -f2)
      curl $SITE | grep "$TEXT"
      STATUS=$(echo $?)

        if [ $STATUS == 0 ]; then
           echo "$SITE is OK" >> /root/wordpress-monitoring/logs/$DATE.log
        
        elif [ $STATUS == 1 ]; then
           echo "$SITE" >> /root/wordpress-monitoring/logs/tampered-sites-$DATE.log
           TAMPER=$((TAMPER+1))
        
        else
           echo "$SITE" >> /root/wordpress-monitoring/logs/non-zero-or-one-exit-status-$DATE.log
           EXIT_STATUS=$((EXIT_STATUS+1))
        fi

done < "$1"

if [ $TAMPER -gt 0 ]; then
   echo "Possible issue detected at $DATE." | mutt -a "/root/wordpress-monitoring/logs/tampered-sites-$DATE.log" -s "WORDPRESS SITE: $TAMPER site(s) \
         appear to have been tampered with - **INVESTIGATE URLS IN ATTACHED LOG FOR ISSUES**" \
          -- email@email.com

elif [ $EXIT_STATUS -gt 0 ]; then
   echo "Possible issue detected at $DATE." | mutt -a "/root/wordpress-monitoring/logs/tampered-sites-$DATE.log" -s "WORDPRESS SITE: $EXIT_STATUS site(s) \
         may have issues - **INVESTIGATE URLS IN ATTACHED LOG FOR ISSUES**" \
          -- email@email.com
fi
