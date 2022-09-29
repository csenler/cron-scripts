#!/bin/bash

echo "checking cron folders..."

echo "current DIR: ${PWD}"

if [ ! -d "${PWD}/logs" ]; then
   echo "logs folder does not exist, creating ..."
   mkdir -p logs
else
   echo "logs folder exists."
fi

if [ ! -d "${PWD}/backups" ]; then
   echo "backups folder does not exist, creating ..."
   mkdir -p backups
else
   echo "backup folders exist."
fi

echo "folder check done."