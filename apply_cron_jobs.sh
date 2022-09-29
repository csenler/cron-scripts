#!/bin/bash

PASSWORD=1234

echo "stop cron service"
echo "${PASSWORD}" | sudo -S service cron stop

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
echo "Current Time : $current_time"

echo "backing up current crontab"
crontab -l > "./backups/cron_backup_${current_time}.txt"

echo "removing crontab"
crontab -r

echo "applying cron_jobs_current"
crontab cron_jobs_current

echo "check if successful: "
crontab -l

echo "re-start cron service"
echo "${PASSWORD}" | sudo -S service cron start

echo "should be done."