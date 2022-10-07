#!/bin/bash

echo "configuring logrotate"

LOG_DIR=${PWD}/logs
echo "log DIR: ${LOG_DIR}"

BACKUPS_DIR=${PWD}/backups
echo "backups DIR: ${BACKUPS_DIR}"

ORGIGINAL_CONF=config/original/custom_logrotate_original
NEW_CONF=config/current/custom_logrotate_current.conf


echo "will change logs folder path to ${LOG_DIR}"
sed "s@PATH_LOGS@${LOG_DIR}@g" ${ORGIGINAL_CONF} > ${NEW_CONF}

echo "will change backups folder path to ${BACKUPS_DIR}"
sed -i "s@PATH_BACKUPS@${BACKUPS_DIR}@g" ${NEW_CONF}