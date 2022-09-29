#!/bin/bash

echo "copying logrotate config to /etc/logrotate.d/"
cp custom_logrotate_current /etc/logrotate.d/

echo "file copied?"
ls /etc/logrotate.d/ | grep custom_logrotate_current