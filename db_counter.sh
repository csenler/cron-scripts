#!/bin/bash

echo ">> db_counter START"

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 {CRON_WS} {increase || decrease || reset}" >&2
  exit 1
fi

CRON_WS=$1
echo "CRON_WS: ${CRON_WS}"

echo "mode: $2"
MODE=$2

valuefile="db/player_check_counter.dat"
echo "value file : ${valuefile}"

# if we don't have a file, then initialize
if [ ! -f "$valuefile" ]; then
   bash ${CRON_WS}/initialize_db.sh ${CRON_WS} counter
fi

# read the value from the file
value=$(cat "$valuefile")

if [ "${MODE}" = "increase" ]; then
    # increment the value
    value=$((value + 1))   
elif [ "${MODE}" = "decrease" ]; then
    # if we don't have a file
    value=$((value - 1))
elif [ "${MODE}" = "reset" ]; then
    value=0
else
    echo "UNKNOWN COUNTER MODE : ${MODE}"
    exit -1
fi

# show it to the user
echo "value: ${value}"

# and save it for next time
echo "${value}" > "$valuefile"

echo ">> db_counter FINISH"