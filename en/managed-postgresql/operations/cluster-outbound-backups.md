---
title: PostgreSQL recovery from a WAL-G backup
description: Follow this guide to recover a PostgreSQL database from a WAL-G backup.
noIndex: true
---

# {{ PG }} recovery from a WAL-G backup

A {{ PG }} cluster backup comes with a WAL-G directory stored in S3, which includes base backups and the WAL archive. Recovery does not require {{ yandex-cloud }} or {{ mpg-short-name }}. You only need access to the backup storage, encryption key, and local installations of {{ PG }} and WAL-G.

## Transmitted data {#data}


| Resource             | Content                                                                                                                                                                                            |
|:-------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `basebackups_005/` | Base backups: full (`base_<WAL>`) and incremental (`base_<WAL>_D_<WAL>`). An incremental backup can only be restored with its full chain up to the nearest full backup. |
| `wal_005/`         | WAL archive. This archive is required to ensure backup consistency and to perform point-in-time recovery (PITR).         |

## Getting started {before-you-begin}

To complete this guide, you will need the following:

1. {{ PG }}: The {{ PG }} version must match the major version of the source cluster.
1. WAL-G: The wal-g-pg binary for {{ PG }} (available for download on the WAL-G [release page](https://github.com/wal-g/wal-g/releases)).
1. Encryption key: An exported key from the bucket used to secure the backups.
1. Bucket access: Static key (ID of the static access key and the value of the secret access key) with permissions to read the bucket.
1. Disk space: Free disk space big enough to store unpacked data with the following taken into account:

   * Size of the database itself.
   * Size of the WAL segments to recover.

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Restoring a database {#restore}

1. Install {{ PG }} and WAL-G:

   ```bash
   # PostgreSQL from the PGDG repository
   sudo apt install -y postgresql-common
   sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
   sudo apt install -y postgresql-<version>
   sudo systemctl stop postgresql

   # # WAL-G: download the wal-g-pg-<OC>-amd64 archive from the page with releases
   tar -xzf wal-g-pg-*.tar.gz
   sudo install -m 755 wal-g-pg-*-amd64 /usr/local/bin/wal-g
   wal-g --version
   ```

1. Provide the static key and configure WAL-G:

   ```bash
   sudo mkdir -p /etc/wal-g
   sudo cp GPG_KEY /etc/wal-g/GPG_KEY
   sudo chown -R postgres:postgres /etc/wal-g
   sudo chmod 600 /etc/wal-g/GPG_KEY
   ```

   Create the `/etc/wal-g/wal-g.yaml` configuration file:

   ```yaml
   AWS_ACCESS_KEY_ID:        <static_key_ID>
   AWS_SECRET_ACCESS_KEY:    <secret_access_key_value>
   AWS_ENDPOINT:             https://storage.yandexcloud.net   # or the endpoint of your S3
   AWS_REGION:               ru-central1
   AWS_S3_FORCE_PATH_STYLE:  true
   WALG_S3_PREFIX:           s3://<bucket>/<prefix_containing_basebackups_005/_and_wal_005/>
   WALG_PGP_KEY_PATH:        /etc/wal-g/GPG_KEY
   # WALG_PGP_KEY_PASSPHRASE: <password>   # only if the key is protected with a password
   PGDATA:                   /var/lib/postgresql/<version>/main
   PGHOST:                   /var/run/postgresql
   ```

   ```bash
   sudo chmod 600 /etc/wal-g/wal-g.yaml
   ```

   You do not need to specify a compression method; this parameter is only required when creating a backup.

1. Check the access and select and a backup:

   ```bash
   sudo -u postgres wal-g backup-list --detail --pretty --config /etc/wal-g/wal-g.yaml
   ```

   If the command returns a list, your bucket permissions and configuration paths are correct. Here is an example of the command output:

   ```
   name                                                     last_modified        wal_segment_backup_start
   base_000000010000139E00000073                            2020-07-29T23:50:20Z 000000010000139E00000073
   base_00000001000013A9000000B1_D_000000010000139E00000073 2020-07-30T23:46:00Z 00000001000013A9000000B1
   ```

   Select a backup created **prior to** your intended point of recovery. For an incremental backup, WAL-G automatically downloads the entire chain up to the full backup.

1. Download the backup:

   ```bash
   # The data directory must be empty
   sudo rm -rf /var/lib/postgresql/<version>/main
   sudo -u postgres wal-g backup-fetch /var/lib/postgresql/<version>/main <backup_name_or_LATEST> \
     --config /etc/wal-g/wal-g.yaml
   sudo chmod 700 /var/lib/postgresql/<version>/main
   ```

   Download speed is defined by `WALG_DOWNLOAD_CONCURRENCY`. This value defaults to ten or equals the total file count if their number is less than ten.

1. Check backup integrity:
 
   {% include [checkup](../../_includes/mdb/backup-checkup.md) %}

   1. Run the script:

      ```bash
      ./s3_test_script.sh */etc/wal-g/wal-g.yaml*
      ```
   
      If required, specify the directory:

      ```bash
      ./s3_test_script.sh */etc/wal-g/wal-g.yaml* basebackups_005 # checking backups
      ./s3_test_script.sh */etc/wal-g/wal-g.yaml* wal_005 # checking WAL
      ```

      Here is an example of the command output:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:
      ```

1. Clear the source cluster settings within the data folder:

   * `postgresql.auto.conf`: {{ PG }} reads this file automatically. Remove or comment out any lines that reference external paths, hosts, or libraries, such as `shared_preload_libraries`, `archive_command`, `primary_conninfo`, etc.
   * `ch_version`: Original cluster configuration. Use your own `postgresql.conf` from `/etc/postgresql/<version>/main/` and keep this folder for reference to copy any required parameters, such as `shared_buffers`, `max_connections`, etc. 

   If the source database utilized extensions that are not available in {{ mpg-name }} builds, remove them from `shared_preload_libraries`. Objects associated with these extensions will persist in the databases but will not function.

1. Configure recovery from a backup. Create a file named `/etc/postgresql/<version>/main/conf.d/recovery.conf`. The `conf.d` folder is included by default in the standard `postgresql.conf` for Debian or Ubuntu:

   ```ini
   restore_command = '/usr/local/bin/wal-g wal-fetch "%f" "%p" --config /etc/wal-g/wal-g.yaml'
   recovery_target_action = 'promote'
   archive_mode = off

   # Select one of these options:
   recovery_target = 'immediate'                         # Restore to backup completion (fastest)
   # recovery_target_time = '2026-10-10 12:00:00+03'     # Point-in-time recovery (PITR)
   # (Without recovery_target* to replay the entire available WAL archive)
   ```

   ```bash
   sudo -u postgres touch /var/lib/postgresql/<version>/main/recovery.signal
   ```

   If `wal-fetch` exits with code `74`, the WAL file is missing from the archive. This is expected behavior when reaching the end of the archive.

1. Initiate the recovery process:

   ```bash
   sudo systemctl start postgresql
   sudo tail -f /var/log/postgresql/postgresql-<version>-main.log
   ```

   The recovery is complete when the following conditions are met:

   * The log contains consistent `consistent recovery state reached` and `archive recovery complete`.
   * The `recovery.signal` file has been deleted.
   * `SELECT pg_is_in_recovery();` returns `false`.

   Once recovery is complete, delete `conf.d/recovery.conf` so these settings do not apply during future restarts.

1. Configure post-recovery security settings:

   * Roles: Run `ALTER ROLE <role> NOLOGIN` to disable login for service roles migrated from the source cluster or remove them if they are no longer required.
   * Authentication: Edit `/etc/postgresql/<version>/main/pg_hba.conf`. Update the access rules to match your new network and users. Restart the service.

After the recovery is complete, check your data by reviewing the database list (`\l`), row counts in key tables, and testing application performance.
