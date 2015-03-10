#!/bin/bash -x

ALIASES=/etc/postfix/aliases

PRESENT=$(cat $ALIASES | grep @option.aliasname@ | wc -l)

if [ $PRESENT -gt 0 ]; then
  sudo cp $ALIASES /etc/postfix/aliases.`date +%y%m%d%H%M` 
  sudo sed -i "s/@option.aliasname@@g.b2be.com,//g" $ALIASES
  sudo sed -i "s/, @option.aliasname@@g.b2be.com//g" $ALIASES
  sudo sed -i "s/@option.aliasname@@g.b2be.com//g" $ALIASES
  sudo sed -i "s/@option.aliasname@@b2be.com,//g" $ALIASES
  sudo sed -i "s/, @option.aliasname@@b2be.com//g" $ALIASES
  sudo sed -i "s/@option.aliasname@@b2be.com//g" $ALIASES
  sudo sed -i "s/@option.aliasname@://g" $ALIASES
  
  PRESENT=$(cat $ALIASES | grep @option.aliasname@ | wc -l)
  
  if [ $PRESENT -eq 0 ]; then
    echo "@option.aliasname@ has been deleted from the aliases file."
  else
    echo "@option.aliasname@ was not deleted. Please contact INF team."
 fi
fi
sudo newaliases
