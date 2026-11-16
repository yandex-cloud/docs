---
title: Restoring a {{ MY }} database from a {{ mmy-full-name }} backup
description: Follow this guide to restore a {{ MY }} database from a provided {{ mmy-name }} backup on your own server.
noIndex: true
---

# Restoring a {{ MY }} database from a WAL-G backup

If someone provided you with a {{ mmy-name }} cluster's backup created with WAL-G, you can restore it on your own server without accessing the cluster in {{ yandex-cloud }}. To to that, you will need backup files in an S3-compatible storage and a PGP private key to decrypt them.

## Transmitted data {#data}

#|
|| **Resource** | **Content**: ||
|| `basebackups_005/` | Base backups. ||
|| `binlog_005/` | {{ MY }} binary log archive. It is required for point-in-time recovery (PITR). ||
|#

## Getting started {#before-you-begin}

Set up the following:

* A dedicated server managed by Ubuntu 22.04 with enough space for unpacked data and files created during recovery.
* Percona Server for MySQL of the same major version as {{ MY }} in the original cluster: 5.7, 8.0, or 8.4.
* Compatible version of Percona XtraBackup and [WAL-G for MySQL](https://github.com/wal-g/wal-g/releases).
* Access to reading the bucket with the backup: ID and secret access key. {{ objstorage-name }} uses a [static access key](../../iam/concepts/authorization/access-key.md).
* The backup's PGP private key and, if it is password-protected, its password.

Point-in-time recovery also requires a binary log archive. The recovery point must be later than the time at which the selected backup's creation was finished.

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Restoring a database {#restore}

1. Install Percona Server for MySQL, Percona XtraBackup, and WAL-G:

   ```bash
   sudo apt update
   sudo apt install -y ca-certificates curl gnupg2 lsb-release
   curl -fLO https://repo.percona.com/apt/percona-release_latest.generic_all.deb
   sudo apt install -y ./percona-release_latest.generic_all.deb
   ```

   Run the commands for the original cluster’s version:

   * **5.7**:

     ```bash
     sudo percona-release enable-only ps-57 release --scheme https
     sudo percona-release enable tools release --scheme https
     sudo apt update
     sudo apt install -y \
       percona-server-server-5.7=5.7.44-48-1.jammy \
       percona-server-common-5.7=5.7.44-48-1.jammy \
       percona-server-client-5.7=5.7.44-48-1.jammy \
       percona-xtrabackup-24=2.4.29-1.jammy
     ```

   * **8.0**:

     ```bash
     sudo percona-release setup ps80 --scheme https
     sudo percona-release enable pxb-80 release --scheme https
     sudo apt update
     sudo apt install -y \
       percona-server-server=8.0.43-34-1.jammy \
       percona-server-common=8.0.43-34-1.jammy \
       percona-server-client=8.0.43-34-1.jammy \
       percona-xtrabackup-80=8.0.35-34-1.jammy
     ```

   * **8.4**:

     ```bash
     sudo percona-release setup ps-84-lts --scheme https
     sudo percona-release enable pxb-84-lts release --scheme https
     sudo apt update
     sudo apt install -y \
       percona-server-server=8.4.7-7-1.jammy \
       percona-server-common=8.4.7-7-1.jammy \
       percona-server-client=8.4.7-7-1.jammy \
       percona-xtrabackup-84=8.4.0-5-1.jammy
     ```

   During installation, the server will create a new data folder and may request the admin password and an authentication method. Further recovery will employ users and passwords from the backup.

   Download the `wal-g-mysql-22.04-amd64.tar.gz` archive from the [WAL-G release page](https://github.com/wal-g/wal-g/releases) and install the executable, e.g., for version 3.0.9:

   ```bash
   curl -fLO https://github.com/wal-g/wal-g/releases/download/v3.0.9/wal-g-mysql-22.04-amd64.tar.gz
   tar -xzf wal-g-mysql-22.04-amd64.tar.gz
   sudo install -m 755 wal-g-mysql-22.04-amd64 /usr/local/bin/wal-g-mysql
   wal-g-mysql --version
   sudo usermod -s /bin/bash mysql
   ```

1. Place a PGP private key and configure WAL-G:

   ```bash
   sudo install -d -o mysql -g mysql -m 0700 /etc/wal-g
   sudo install -o mysql -g mysql -m 0600 <path_to_key> /etc/wal-g/PGP_KEY
   ```

   Create a file named `/etc/wal-g/wal-g.yaml`:

   ```yaml
   AWS_ACCESS_KEY_ID: <static_key_ID>
   AWS_SECRET_ACCESS_KEY: <secret_access_key>
   AWS_ENDPOINT: <S3_endpoint>
   AWS_REGION: <S3_region>
   AWS_S3_FORCE_PATH_STYLE: true
   WALG_S3_PREFIX: s3://<bucket_name>/<backup_prefix>
   WALG_PGP_KEY_PATH: /etc/wal-g/PGP_KEY
   WALG_MYSQL_DATA_DIR: /var/lib/mysql
   WALG_MYSQL_BINLOG_DST: /var/lib/mysql/.oldbinlogs
   WALG_STREAM_RESTORE_COMMAND: >
     xbstream --extract --parallel=8 --directory=/var/lib/mysql
   WALG_MYSQL_BINLOG_REPLAY_COMMAND: >
     mysqlbinlog --no-defaults --stop-datetime="$WALG_MYSQL_BINLOG_END_TS" "$WALG_MYSQL_CURRENT_BINLOG" |
     mysql --no-defaults --binary-mode --protocol=SOCKET --socket=/var/run/mysqld/mysqld.sock -u root
   ```

   In `WALG_S3_PREFIX`, specify the path to the folder containing `basebackups_005/` and, if required, `binlog_005/`. Take the `AWS_ENDPOINT` and `AWS_REGION` values from the storage settings. For example, for {{ objstorage-name }} in the Russia region, these are `https://storage.yandexcloud.net` and `ru-central1`. If the PGP key is password-protected, add the `WALG_PGP_KEY_PASSPHRASE` parameter to the configuration.

   Restrict access to the configuration file with the secret key:

   ```bash
   sudo chown mysql:mysql /etc/wal-g/wal-g.yaml
   sudo chmod 600 /etc/wal-g/wal-g.yaml
   ```

1. Check access to the backups and select the one to recover:

   ```bash
   sudo -u mysql wal-g-mysql backup-list --config /etc/wal-g/wal-g.yaml
   ```

   If the command output a list, access to the bucket and the `WALG_S3_PREFIX` path are configured correctly. Select a backup created before your intended recovery point. Here is a sample backup name: `stream_20261009T203209Z`.

1. Check backup integrity:
 
   {% include [checkup](../../_includes/mdb/backup-checkup.md) %}

   1. Run the script:

      ```bash
      WAL_G_BIN=wal-g-mysql ./s3_test_script.sh */etc/wal-g/wal-g.yaml*
      ```
   
      If required, specify a folder:

      ```bash
      WAL_G_BIN=wal-g-mysql ./s3_test_script.sh */etc/wal-g/wal-g.yaml* basebackups_005 # checks backups
      WAL_G_BIN=wal-g-mysql ./s3_test_script.sh */etc/wal-g/wal-g.yaml* binlog_005 # checks the binary log archive
      ```

      Here is an example of the command output:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:
      ```

1. Update {{ MY }} and recover the selected backup's files. Run commands only on a prepared server: deleting the `/var/lib/mysql` folder will also delete the data of the installed {{ MY }} instance:

   ```bash
   sudo systemctl stop mysql
   sudo rm -rf /var/lib/mysql
   sudo install -d -o mysql -g mysql -m 0750 /var/lib/mysql
   sudo -u mysql wal-g-mysql backup-fetch <backup_name> --config /etc/wal-g/wal-g.yaml
   sudo -u mysql xtrabackup --prepare --target-dir=/var/lib/mysql
   ```

   Before starting the server, expand the `[mysqld]` section of the `/etc/mysql/my.cnf` file with parameters for disabling authentication checks and network connections, as well as for enabling GTID:

   ```ini
   [mysqld]
   skip-grant-tables
   skip-networking
   gtid_mode=ON
   enforce_gtid_consistency=ON
   ```

   Start the server:

   ```bash
   sudo systemctl start mysql
   ```

   Use one and the same backup name when downloading and performing point-in-time recovery. If the latest backup is selected, you can specify `LATEST` instead of the name.

1. If you need PITR, reproduce the binary logs. Create a folder for the binary logs and run recovery. In the `--until` parameter, specify a time point in RFC 3339 format with a time zone:

   ```bash
   sudo install -d -o mysql -g mysql -m 0750 /var/lib/mysql/.oldbinlogs
   sudo -u mysql wal-g-mysql binlog-replay \
     --since <backup_name> \
     --until '2026-10-13T10:00:00Z' \
     --config /etc/wal-g/wal-g.yaml
   ```

   Where:

   * `--since`: Name of the backup you recovered in the previous step. WAL-G will start reproducing the binary logs after this backup.
   * `--until`: Time point until which you intend to recover data, in RFC 3339 format with a time zone: It must be later than the time at which the selected backup's creation was finished.
   * `--config`: Path to the WAL-G configuration file created in Step 2.

   If there is no `binlog_005/` or PITR is not required, skip this step.

1. Check the recovered data: the database list, number of lines in the main tables, and the application's performance. The users and passwords from the original cluster should also be recovered. Check their accesses ad block or delete the original cluster's service accounts that you no longer need.

   After configuring accounts and passwords, enable the authentication checks and network connections: delete the `skip-grant-tables` and `skip-networking` parameters from the `/etc/mysql/my.cnf` file.
