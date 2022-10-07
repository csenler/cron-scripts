#!/bin/bash

#xdg-open test_image.png


#to find terminal's pts, use -> tty
#echo "THIS IS TEST" > /dev/pts/0

timestamp=$(date +%s)
echo "${timestamp} : THIS IS TEST"
