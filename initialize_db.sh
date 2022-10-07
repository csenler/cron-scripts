#!/bin/bash

echo ">> initialize db START"

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 {CRON_WS path} {key -> (timestamp,counter ...)}" >&2
  exit 1
fi

CRON_WS=$1
echo "CRON_WS : ${CRON_WS}"

DB_KEY=$2
echo "DB key: ${DB_KEY}"

## ==================== FUNCTIONS =====================
## ALL
initALL(){
    initCounter
    initTimestamp
    initAutoConfigReset
    initCronWSPath
}

## counter
initCounter(){
    counterFile="${CRON_WS}/db/player_check_counter.dat"
    echo "counterFile : ${counterFile}"
    # if we don't have a file, start at zero
    if [ ! -f "$counterFile" ]; then
        count=0
        # show it to the user
        echo "count: ${count}"
        # and save it for next time
        echo "${count}" > "$counterFile"
    else
        echo "counter file already exists!"
    fi
}

## timestamp
initTimestamp(){
    timestampFile="${CRON_WS}/db/timestamp.dat"
    echo "timestamp : ${timestampFile}"
    # if we don't have a file, start at zero
    if [ ! -f "$timestampFile" ]; then
        timestamp=$(date +%s)
        # show it to the user
        echo "timestamp: ${timestamp}"
        # and save it for next time
        echo "${timestamp}" > "$timestampFile"
    else
        echo "timestamp file already exists!"
    fi
}

## player auto_config_reset state
initAutoConfigReset(){
    playerResetStateFile="${CRON_WS}/db/player_config_reset_state.dat"
    echo "playerResetStateFile : ${playerResetStateFile}"
    # if we don't have a file, start at zero
    if [ ! -f "$playerResetStateFile" ]; then
        state=false
        # show it to the user
        echo "state: ${state}"
        # and save it for next time
        echo "${state}" > "$playerResetStateFile"
    else
        echo "player reset state file already exists!"
    fi
}

## cron_ws path
initCronWSPath(){
    cronWsPathFile="${CRON_WS}/db/cron_ws_path.dat"
    echo "cronWsPathFile : ${cronWsPathFile}"
    # if we don't have a file, start at zero
    if [ ! -f "$cronWsPathFile" ]; then
        path=""
        # show it to the user
        echo "path: ${path}"
        # and save it for next time
        echo "${path}" > "$cronWsPathFile"
    else
        echo "cron_ws path file already exists!"
    fi
}
## ==================== FUNCTIONS END =====================


## ================== MAIN ===========================
if [ "${DB_KEY}" = "ALL" ]; then
    initALL
elif [ "${DB_KEY}" = "counter" ]; then
    initCounter
elif [ "${DB_KEY}" = "timestamp" ]; then
    initTimestamp
elif [ "${DB_KEY}" = "playerResetConfigState" ]; then
    initAutoConfigReset
elif [ "${DB_KEY}" = "cronWsPath" ]; then
    initCronWSPath
else
    echo "UNKNOWN KEY"
    echo ">> initialize db START"
    exit -1
fi
echo ">> initialize db END"
## ================== MAIN END ===========================