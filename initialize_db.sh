#!/bin/bash

echo ">> initialize db START"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {key -> (timestamp,counter ...)}" >&2
  exit 1
fi

DB_KEY=$1
echo "DB key: ${DB_KEY}"

## ==================== FUNCTIONS =====================

## counter
initCounter(){
    counterFile="db/player_check_counter.dat"
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
    timestampFile="db/timestamp.dat"
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
    playerResetStateFile="db/player_config_reset_state.dat"
    echo "playerResetStateFile : ${playerResetStateFile}"
    # if we don't have a file, start at zero
    if [ ! -f "$playerResetStateFile" ]; then
        state=0
        # show it to the user
        echo "state: ${state}"
        # and save it for next time
        echo "${state}" > "$playerResetStateFile"
    else
        echo "player reset state file already exists!"
    fi
}
## ==================== FUNCTIONS END =====================


## ================== MAIN ===========================
if [ "${DB_KEY}" = "counter" ]; then
    initCounter
elif [ "${DB_KEY}" = "timestamp" ]; then
    initTimestamp
elif [ "${DB_KEY}" = "playerResetConfigState" ]; then
    initAutoConfigReset
else
    echo "UNKNOWN KEY"
    echo ">> initialize db START"
    exit -1
fi
echo ">> initialize db END"
## ================== MAIN END ===========================