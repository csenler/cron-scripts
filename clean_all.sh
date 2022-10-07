#!/bin/bash

echo ">> cleaning all logs, cron backups and logrotate state"

PASSWORD=1234

echo "current DIR: ${PWD}"

read -p "Are you sure about current DIR? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    echo "executing rm"
    echo "${PASSWORD}" | sudo -S rm -rf logs/*
    echo "${PASSWORD}" | sudo -S rm -rf backups/*
    echo "${PASSWORD}" | sudo -S rm -f logrotate-state
fi
