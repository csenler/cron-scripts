#!/bin/bash

echo "copying cron job to /etc/cron.d/"

PASSWORD=1234

echo "1234" | sudo -S cp cron_test /etc/cron.d/
