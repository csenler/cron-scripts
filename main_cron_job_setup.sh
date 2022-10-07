#!/bin/bash

echo ">> main cron job script running..."

USER="svrn"
echo "for user: ${USER}"

# enter main script to run with cron here
SCRIPT_TO_RUN=test.sh

## to enable file log
SOURCE_CRON_FILE=cron_jobs_original_log_to_file
## to disable file log
#SOURCE_CRON_FILE=cron_jobs_original_no_file_log

LOGROTATE_SCRIPT=apply_logrotate_config.sh

echo ">> checking folder structure"
bash check_folders.sh

echo ">> readying crontab file" 
bash adjust_crontab_file.sh ${USER} ${SCRIPT_TO_RUN} ${SOURCE_CRON_FILE} ${LOGROTATE_SCRIPT}

echo ">> appyling crontab file"
bash apply_cron_jobs.sh

echo ">> FIN."


