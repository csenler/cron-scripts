#!/bin/bash

echo ">> db_cron_ws_path START"
f [ "$#" -ne 1 ]; then
  echo "Usage: $0 {path}" >&2
  exit 1
fi

echo "CRON_WS_PATH: $1"
CRON_WS_PATH=$1

valuefile="db/cron_ws_path.dat"
echo "value file : ${valuefile}"

# if we don't have a file, then initialize
if [ ! -f "$valuefile" ]; then
   bash ${CRON_WS_PATH}/initialize_db.sh ${CRON_WS_PATH} cronWsPath
fi

# read the value from the file
value=$(cat "$valuefile")

echo "setting path to: ${CRON_WS_PATH}"
value="${CRON_WS_PATH}"

# show it to the user
echo "value: ${value}"

# and save it for next time
echo "${value}" > "$valuefile"
echo ">> db_cron_ws_path END"