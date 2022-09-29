#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 username script_name source_cron_file" >&2
  exit 1
fi

echo "first arg: $1"
echo "second arg: $2"
echo "third arg: $3"
USERNAME=$1
SCRIPT_NAME=$2
ORIGINAL_CRON_FILE=$3

# ORIGINAL_CRON_FILE=cron_jobs_original_log_to_file
TARGET_CRON_FILE=cron_jobs_current

echo "will change username from csenler to ${USERNAME}"
sed "s/csenler/${USERNAME}/g" ${ORIGINAL_CRON_FILE} > ${TARGET_CRON_FILE}

echo "will change script name to ${SCRIPT_NAME}"
sed "s/NULL/${SCRIPT_NAME}/g" ${ORIGINAL_CRON_FILE} > ${TARGET_CRON_FILE}

echo ">> log output (if opened) will be in : ${PWD}/logs/cron_jobs_log.log"

echo "changes from original to target: "
diff ${ORIGINAL_CRON_FILE} ${TARGET_CRON_FILE}

echo "cron job username change should be completed."