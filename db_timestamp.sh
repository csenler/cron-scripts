#!/bin/bash

valuefile="db/timestamp.dat"
echo "value file : ${valuefile}"

# if we don't have a file, then initialize
if [ ! -f "$valuefile" ]; then
    bash initialize_db.sh timestamp
fi


timestamp=$(date +%s)

# show it to the user
echo "timestamp: ${timestamp}"

# and save it for next time
echo "${timestamp}" > "$valuefile"