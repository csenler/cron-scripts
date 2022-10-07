#!/bin/bash

echo ">> clearing db folder entitites"

PASSWORD=1234

echo "current DIR: ${PWD}"

read -p "Are you sure about current DIR? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    echo "executing rm"
    echo "${PASSWORD}" | sudo -S rm -rf db/*
fi
