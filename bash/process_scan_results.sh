#!/bin/bash
#Renames the lastest PDF downloaded from penetration test and moves it into shared folder.

for i in $(ls -ltr | tail -1 | awk '{print $9}'); do mv $i scan_reports/$1.pdf; done
