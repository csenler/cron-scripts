#!/bin/bash

#xdg-open test_image.png


#to find terminal's pts, use -> tty
#echo "THIS IS TEST" > /dev/pts/0

timestamp=$(date +%s)
echo "${timestamp} : TEST"

# log to syslog (/var/log/syslog)
logger --id --tag TEST "${timestamp} : TEST"
