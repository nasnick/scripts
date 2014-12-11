#!/bin/bash

for i in $(ls -ltr | tail -1 | awk '{print $9}'); do mv $i scan_reports/$1.pdf; done
