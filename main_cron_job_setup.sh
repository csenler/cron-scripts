#!/bin/bash

echo ">> main cron job script running..."

echo "current DIR: ${PWD}"

## ============== CONFIG ==========================
## eshot_scripts_path
# SCRIPTS_DIR=${HOME}/eshot_ws/eshot-player-scripts
# echo "scripts folder path: ${SCRIPTS_DIR}"

## find scripts folder path
SCRIPTS_DIR="$(echo $(cd ../ && pwd))"
echo "scripts DIR: ${SCRIPTS_DIR}"

## enter main script to run with cron here
# SCRIPT_TO_RUN=test.sh
SCRIPT_TO_RUN=player_control.sh

## to enable file log
# SOURCE_CRON_FILE=config/original/cron_jobs_prod_log_to_file
SOURCE_CRON_FILE=config/original/cron_jobs_test_log_to_file
## to disable file log
#SOURCE_CRON_FILE=config/original/cron_jobs_prod_no_file_log
# SOURCE_CRON_FILE=config/original/cron_jobs_test_no_file_log

LOGROTATE_SCRIPT=apply_logrotate_config.sh
## ================================================

echo ">> checking folder structure"
bash check_folders.sh

echo ">> readying crontab file" 
CRON_WS=${SCRIPTS_DIR}/cron-scripts
# bash adjust_crontab_file.sh ${USER} ${SCRIPT_TO_RUN} ${SOURCE_CRON_FILE} ${LOGROTATE_SCRIPT}
bash adjust_crontab_file.sh ${SCRIPTS_DIR} ${SCRIPT_TO_RUN} ${SOURCE_CRON_FILE} ${LOGROTATE_SCRIPT}

echo ">> appyling crontab file"
bash apply_cron_jobs.sh

echo ">> configuring logrotate"
bash configure_logrotate.sh

echo ">> initializing db (ALL)"
bash initialize_db.sh "${CRON_WS}" "ALL"

# echo ">> setting cron_ws path to db"
# bsah db_cron_ws_path.sh

echo ">> FIN."


