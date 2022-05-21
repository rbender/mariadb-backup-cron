#!/usr/bin/env bash

set -ex

echo "Backup MariaDB"

if [[ ! -z "${PRE_HOOK}" ]]
then
    echo Run pre-hook: "${PRE_HOOK}"
    eval "${PRE_HOOK}"
fi

MARIADB_PARAMS="-u${DB_USER:-root} -p${DB_PASSWORD} -h${DB_HOST:-mariadb} -P${DB_PORT:-3306}"

DATABASES=$(mysql -N ${MARIADB_PARAMS} -e 'show databases')
for DATABASE in $DATABASES
do
    if [[ $EXCLUDE_DATABASES =~ (^|[[:space:]])$DATABASE($|[[:space:]]) ]]
    then
        echo Skip database "${DATABASE}"
    else
        BACKUP_FILE="${BACKUP_DIR:-/var/backups}/${DATABASE}.sql"
        echo Backup database "${DATABASE}" to "${BACKUP_FILE}"

        mysqldump ${MARIADB_PARAMS} --complete-insert --routines --triggers --single-transaction "$DATABASE" > "${BACKUP_FILE}"

        echo Finished backup "${DATABASE}"
    fi
done

echo "Backups complete"

if [[ ! -z "${POST_HOOK}" ]]
then
    echo Run post-hook: "${POST_HOOK}"
    eval "${POST_HOOK}"
fi
