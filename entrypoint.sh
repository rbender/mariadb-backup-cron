#!/usr/bin/env bash

set -ex

echo "${SCHEDULE:?Must specify SCHEDULE environment variable} /backup.sh" > /crontab

env > /etc/environment
crontab crontab

echo Starting cron with schedule "${SCHEDULE}"
crond -f
