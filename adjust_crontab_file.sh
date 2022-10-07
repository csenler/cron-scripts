#!/bin/bash

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 username script_name source_cron_file logrotate_script_name" >&2
  exit 1
fi

echo "first arg: $1"
echo "second arg: $2"
echo "third arg: $3"
echo "fourth arg: $3"
USERNAME=$1
SCRIPT_NAME=$2
ORIGINAL_CRON_FILE=$3
LOGROTATE_SCRIPT=$4

# ORIGINAL_CRON_FILE=cron_jobs_original_log_to_file
TARGET_CRON_FILE=cron_jobs_current

echo "will change username from csenler to ${USERNAME}"
sed "s/csenler/${USERNAME}/g" ${ORIGINAL_CRON_FILE} > ${TARGET_CRON_FILE}

echo "will change main script name to ${SCRIPT_NAME}"
sed "s/NULL_MAIN_SCRIPT/${SCRIPT_NAME}/g" ${ORIGINAL_CRON_FILE} > ${TARGET_CRON_FILE}

echo "will change logrotate script name to ${LOGROTATE_SCRIPT}"
sed -i "s/NULL_LOGROTATE/${LOGROTATE_SCRIPT}/g" ${TARGET_CRON_FILE}

echo ">> log output (if opened) will be in : ${PWD}/logs/cron_jobs_log.log"

echo "changes from original to target: "
diff ${ORIGINAL_CRON_FILE} ${TARGET_CRON_FILE}

echo "cron job username change should be completed."