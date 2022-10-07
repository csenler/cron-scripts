#!/bin/bash

## /etc/logrotate.d/ is the default system location
# echo "copying logrotate config to /etc/logrotate.d/"
# cp custom_logrotate_current /etc/logrotate.d/

# echo "file copied?"
# ls /etc/logrotate.d/ | grep custom_logrotate_current

echo "applying custom logrotate conf"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 cron_working_directory_path" >&2
  exit 1
fi

echo "first arg: $1"

CRON_WS=$1
echo "received DIR: ${CRON_WS}"



CUSTOM_CONF=${CRON_WS}/config/current/custom_logrotate_current.conf
CUSTOM_LOGROTATE_STATE=${CRON_WS}/logs/logrotate-state

## we can use custom location by specifying logrorate-state file and calling logrotate periodically with a cron job
logrotate ${CUSTOM_CONF} --state ${CUSTOM_LOGROTATE_STATE} --verbose