#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {CRON_WS path}" >&2
  exit 1
fi

CRON_WS=$1
echo "CRON_WS: ${CRON_WS}"

valuefile="db/timestamp.dat"
echo "value file : ${valuefile}"

# if we don't have a file, then initialize
if [ ! -f "$valuefile" ]; then
    bash ${CRON_WS}/initialize_db.sh ${CRON_WS} timestamp
fi


timestamp=$(date +%s)

# show it to the user
echo "timestamp: ${timestamp}"

# and save it for next time
echo "${timestamp}" > "$valuefile"