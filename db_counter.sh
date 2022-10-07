#!/bin/bash

echo ">> db_counter START"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {increase || decrease || reset}" >&2
  exit 1
fi

echo "mode: $1"
MODE=$1

valuefile="db/player_check_counter.dat"
echo "value file : ${valuefile}"

# if we don't have a file, then initialize
if [ ! -f "$valuefile" ]; then
   bash initialize_db.sh counter
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