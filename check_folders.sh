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
   echo "backup folder exist."
fi

if [ ! -d "${PWD}/db" ]; then
   echo "database folder does not exist, creating ..."
   mkdir -p db
else
   echo "database folder exist."
fi

if [ ! -d "${PWD}/config" ]; then
   echo "config folder does not exist, creating ..."
   mkdir -p config/original
   mkdir -p config/current
   echo "copying necessery original configs from resource"
   cp -r resource/* config/original
else
   echo "config folder exist."
   ## TODO: make conditional
   echo "copying necessery original configs from resource"
   cp -r resource/* config/original
fi

echo "folder check done."