In main script (`main_cron_job_setup.sh`);

- name of the script that will be called with cron job is hardcoded as `SCRIPT_TO_RUN` variable
- cron job configuration file name is assigned to `SOURCE_CRON_FILE` variable
- logs and crontab backups will be held at their respective directories and will be controlled by logrotate, which will use configuration files present in the repo