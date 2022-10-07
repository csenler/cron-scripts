#!/bin/bash

echo "<<< player_control START >>>"

CONFIG_RESET_DELAY_TIME=180 # seconds
echo "config reset delay time in seconds: ${CONFIG_RESET_DELAY_TIME}"

## find scripts folder path
SCRIPTS_DIR="$(echo $(cd ../ && pwd))"
echo "scripts DIR: ${SCRIPTS_DIR}"

# ## check xibo states
# SERVICE_WATCHDOG="xibo-watchdog"
# SERVICE_PLAYER="xibo-player"

# STATUS_WATCHDOG=0
# STATUS_PLAYER=0

# if pgrep -x "$SERVICE_WATCHDOG" >/dev/null
# then
#     echo "$SERVICE_WATCHDOG is running"
#     STATUS_WATCHDOG=1
# else
#     echo "$SERVICE_WATCHDOG stopped"
# fi


# if pgrep -x "$SERVICE_PLAYER" >/dev/null
# then
#     echo "$SERVICE_PLAYER is running"
#     STATUS_PLAYER=1
# else
#     echo "$SERVICE_PLAYER stopped"
# fi

# echo "watchdog status : ${STATUS_WATCHDOG}"
# echo "player status : ${STATUS_PLAYER}"

## =========================== FUNCTIONS START ==================================================================
function check_player_config_reset_state(){
    # check auto_config_reset
    # read from db
    resetStateFile="db/player_config_reset_state.dat"
    playerResetState=""
    echo "resetStateFile file : ${resetStateFile}"
    # if we don't have a file, then initialize
    if [ ! -f "$resetStateFile" ]; then
        bash initialize_db.sh playerResetConfigState
    else
        # read the value from the file
        playerResetState=$(cat "$resetStateFile")
    fi
}

function player_error_state(){
    ## check elapsed time since last db call, then execute player_kill, auto_config_reset if above threshold
    # read from db
    timestampFile="db/timestamp.dat"
    refTimestamp=""
    echo "timestampFile file : ${timestampFile}"
    # if we don't have a file, then initialize
    if [ ! -f "$timestampFile" ]; then
        bash initialize_db.sh timestamp
    else
        # read the value from the file
        refTimestamp=$(cat "$timestampFile")
    fi
    # calculate elapsed time
    currentTimestamp=$(date +%s)
    echo "current ts: ${currentTimestamp}"
    echo "ref ts: ${refTimestamp}"
    temp=$((currentTimestamp-refTimestamp))
    diffTime="${temp##*[+-]}" ## remove '+' and '-' signs for absolute value
    echo "diffTime: ${diffTime}"
    # if now above threashold, do nothing, if above threashold, call db_timestamp again (change ref)
    threshold=${CONFIG_RESET_DELAY_TIME} ## in seconds
    echo "Time Taken - $((diffTime /60/60)) hours and $((($diffTime /60) % 60)) minutes and $(($diffTime % 60)) seconds elapsed."
    if [ "${diffTime}" -gt "${threshold}" ]; then
        # kill xibo
        echo "3 minustes passed, executing player_kill"
        bash ${SCRIPTS_DIR}/player-scripts/player_kill.sh
        # execute auto_config
        bash ${SCRIPTS_DIR}/player-scripts/auto_config_reset.sh
        # set player reset state
        check_player_config_reset_state # to initialize if not initialized before
        bash db_playerResetState.sh "true"
        # update reference timestamp
        bash db_timestamp.sh
    fi
}

function player_start(){
    # execute player_kill just in case
    echo "executing player_kill"
    bash ${SCRIPTS_DIR}/player-scripts/player_kill.sh
    # start player
    bash ${SCRIPTS_DIR}/player-scripts/run_player_with_args.sh
}
## =========================== FUNCTIONS END ==================================================================


## main control 
if [ "${STATUS_WATCHDOG}" -eq 1 ] && [ "${STATUS_PLAYER}" -eq 0 ]; then # error state
    echo "player error state detected."
    player_error_state
elif [ "${STATUS_WATCHDOG}" -eq 0 ] && [ "${STATUS_PLAYER}" -eq 0 ]; then # watchdog not started, start state
    echo "watchdog & player not running, check reset state"
    check_player_config_reset_state
    if [ "${playerResetState}" = "true" ]; then
        echo "player reset detected, will start player with arguments"
        player_start 
        echo "setting player_config_reset_state to false"
        bash db_playerResetState.sh "false"
    elif [ "${playerResetState}" = "false" ]; then
        echo "player reset NOT detected, will start player by calling savron-player"
        exec savron-player
    else
        echo "playerResetState can not be obtained, will try to run player normally..."
        exec savron-player
    fi
elif [ "${STATUS_WATCHDOG}" -eq 1 ] && [ "${STATUS_PLAYER}" -eq 1 ]; then # working state, set config_reset to false -> this will also be the first condition
    echo "watchdog & player running..."
    check_player_config_reset_state
    echo "playerResetState : ${playerResetState}"
    if [ "${playerResetState}" = "true" ]; then
        echo "setting player_config_reset_state to false"
        # set config_reset state to false
        bash db_playerResetState.sh "false"
    fi    
fi

echo "<<< player_control END >>>"