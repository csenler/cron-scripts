#!/bin/bash

echo ">> db_playerResetState START"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {CRON_WS} {true || false}" >&2
  exit 1
fi

CRON_WS=$1
echo "CRON_WS: ${CRON_WS}"

echo "state: $2"
STATE=$2

valuefile="db/player_config_reset_state.dat"
echo "value file : ${valuefile}"

# if we don't have a file, then initialize
if [ ! -f "$valuefile" ]; then
   bash initialize_db.sh ${CRON_WS} playerResetConfigState
fi

# read the value from the file
value=$(cat "$valuefile")

if [ "${STATE}" = "true" ]; then
    value="true"   
elif [ "${STATE}" = "false" ]; then
    value="false"
else
    echo "UNKNOWN STATE : ${STATE}"
    exit -1
fi

# show it to the user
echo "value: ${value}"

# and save it for next time
echo "${value}" > "$valuefile"

echo ">> db_playerResetState FINISH"