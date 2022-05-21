# MariaDB-Backup-Cron Docker Image

Inspired by Jake Howard's [docker-db-auto-backup](https://github.com/RealOrangeOne/docker-db-auto-backup), I wanted a way to backup MariaDB/MySQL databases configured entirely in Docker Compose, without having to setup cron tasks on my host server. Unlike Jake's script, I also wanted to each database to go in a separate SQL file with the ability to exclude specific databases.

- Pre/Post backup hooks for calling [healthchecks.io](https://healthchecks.io/), etc. (`curl` pre-installed in image)

**Note**: This image isn't being automaticcally built and pushed to hub.docker.com yet.

## Example docker-compose snippet

```
  mariadb-backup-cron:
    image: rbender/mariadb-backup-cron:latest
    container_name: mariadb-backup-cron
    volumes:
      - /media/backup/db:/var/backups
    environment:
      DB_USER: root
      DB_PASSWORD: supersecretpassword
      DB_HOST: mariadb
      SCHEDULE: "0 1 * * *"
```

## Environment Variables

- `SCHEDULE`: Cron expression for when to run backups (required)
- `DB_USER`: Database user to run backup as (default: `root`)
- `DB_PASSWORD`: Database user's password (required)
- `DB_HOST`: Hostname of database (default: `mariadb`)
- `DB_PORT`: Port of database (default: `3306`)
- `BACKUP_DIR`: Path to write backup files to (default: `/var/backups`)
- `EXCLUDE_DATABASES`: Optional space-delimited list of databases to exclude from backups
- `PRE_HOOK`: Optional command to be run at beginning of backup process
- `POST_HOOK`: Optional command to be run at the end of the backup proces
