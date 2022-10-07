#!/bin/bash

echo ">> configuring logrotate"

LOG_DIR=${PWD}/logs
echo "log DIR: ${LOG_DIR}"

ORGIGINAL_CONF=custom_logrotate_original
NEW_CONF=custom_logrotate_current.conf


echo "will change log file path to ${LOG_DIR}"
sed "s@PATH@${LOG_DIR}@g" ${ORGIGINAL_CONF} > ${NEW_CONF}