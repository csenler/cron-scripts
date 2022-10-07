#!/bin/bash

echo ">> main cron job script running..."

USER="svrn"
echo "for user: ${USER}"

echo "current DIR: ${PWD}"

## ============== CONFIG ==========================
# eshot_scripts_path
SCRIPTS_DIR=${HOME}/eshot_ws/eshot-player-scripts

echo "scripts folder path: ${SCRIPTS_DIR}"

# enter main script to run with cron here
# SCRIPT_TO_RUN=test.sh
SCRIPT_TO_RUN=player_control.sh

## to enable file log
SOURCE_CRON_FILE=config/original/cron_jobs_original_log_to_file
## to disable file log
#SOURCE_CRON_FILE=config/original/cron_jobs_original_no_file_log

LOGROTATE_SCRIPT=apply_logrotate_config.sh
## ================================================

echo ">> checking folder structure"
bash check_folders.sh

echo ">> readying crontab file" 
CRON_WS=${SCRIPTS_DIR}/cron-scripts
# bash adjust_crontab_file.sh ${USER} ${SCRIPT_TO_RUN} ${SOURCE_CRON_FILE} ${LOGROTATE_SCRIPT}
bash adjust_crontab_file.sh ${CRON_WS} ${SCRIPT_TO_RUN} ${SOURCE_CRON_FILE} ${LOGROTATE_SCRIPT}

echo ">> appyling crontab file"
bash apply_cron_jobs.sh

echo ">> configuring logrotate"
bash configure_logrotate.sh

echo ">> FIN."


