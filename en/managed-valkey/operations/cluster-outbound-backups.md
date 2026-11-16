---
title: Recovering {{ mrd-short-name }} from a WAL-G backup
description: Follow this guide to recover a {{ mrd-short-name }} cluster's database from a WAL-G backup.
noIndex: true
---

# Recovering {{ mrd-short-name }} from a WAL-G backup

You can restore a {{ mrd-short-name }} cluster's data on user infrastructure from a backup transferred to an S3 bucket through WAL-G.

## Getting started {before-you-begin}

To complete this guide, you will need the following:

1. {{ VLK }} and `valkey-cli`: It is advisable to use the same full version as on the original server; older versions are not suitable. You can find out the version in the backup metadata. If modules were used, such as JSON, Search, or Bloom, you will need their compatible versions.
1. WAL-G: A binary wal-g-pg file for {{ RD }}/{{ VLK }}, which you can download from the WAL-G [release page](https://github.com/wal-g/wal-g/releases). The names of the binary file and the `WALG_REDIS_*` settings are also saved for {{ VLK }}. The examples below use the WAL-G v3.0.9 UI.
1. Encryption key: The key exported from the bucket and used for protecting backups.
1. Bucket access: Static key (ID of the static access key and the value of the secret access key) with permissions to read the bucket.
1. Disk space: Free disk space big enough to store unpacked data with the following taken into account:
   * Size of the database itself.
   * Size of the WAL segments to recover.

The commands below run in `bash` as `root`. In the examples, the service is called `valkey-server`, the user and group, `valkey:valkey`, the configuration file, `/etc/valkey/valkey.conf`, and the data folder, `/var/lib/valkey`. If they are different in your setup, provide your values.

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Transmitted data {#data}

| Resource             | Content                                                                                                    |
|--------------------|---------------------------------------------------------------------------------------------------------------|
| `basebackups_005/` | WAL-G backups: metadata and all data objects. A complete backup is required, with the folder structure saved. |

In case of a sharded cluster, backups are transferred individually for each shard. Backups of all shards from one set of backups are required, and the folders must match the original shard IDs.

## Restoring a database {#restore}

1. Install WAL-G. Download `wal-g-redis` for your operating system and architecture. For example, for Ubuntu 24.04 x86-64:

   ```bash
   curl -fL \
     https://github.com/wal-g/wal-g/releases/latest/download/wal-g-redis-24.04-amd64 \
     -o /tmp/wal-g-redis
   install -m 0755 /tmp/wal-g-redis /usr/local/bin/wal-g-redis
   wal-g-redis --version
   wal-g-redis backup-fetch --help
   ```

   `backup-fetch` must have the `-t rdb|aof` and `--redis-version` parameters. The WAL-G version is not associated with the {{ VLK }} version.

1. Add and configure WAL-G:

   ```bash
   install -d -m 0700 /etc/wal-g-restore
   install -m 0600 /path/to/received-private-key.pgp /etc/wal-g-restore/private.pgp
   ```

   Create a `/etc/wal-g-restore/wal-g.yaml`:

   ```yaml
   AWS_ACCESS_KEY_ID:       "<static key ID>"
   AWS_SECRET_ACCESS_KEY:   "<static key secret>"
   AWS_ENDPOINT:           "https://storage.yandexcloud.net"  # or the endpoint of your S3
   AWS_REGION:             "ru-central1"
   AWS_S3_FORCE_PATH_STYLE: "true"
   WALG_S3_PREFIX:          "s3://<bucket>/<folder with basebackups_005/>"

   WALG_PGP_KEY_PATH: "/etc/wal-g-restore/private.pgp"
   # WALG_PGP_KEY_PASSPHRASE: "<password>"  # only if the key is protected with a password

   WALG_COMPRESSION_METHOD: "brotli"
   WALG_REDIS_DATA_PATH: "/var/lib/valkey"
   WALG_REDIS_APPENDONLY_PATH: "appendonlydir"
   WALG_REDIS_SERVER_PROCESS_NAME: "valkey-server"
   WALG_STREAM_RESTORE_COMMAND: "cat > /var/lib/valkey/dump.rdb"
   ```

   ```bash
   chmod 0600 /etc/wal-g-restore/wal-g.yaml
   export WALG_CONFIG=/etc/wal-g-restore/wal-g.yaml
   ```

`WALG_S3_PREFIX` points to the `basebackups_005/` parent folder, not to the folder itself or a separate file. For example, for objects in `s3://customer-backups/valkey-export/shard-1/basebackups_005/`, specfiy `s3://customer-backups/valkey-export/shard-1`. The bucket name and external prefix may differ from the original ones, while the object structure inside should be saved.

For a different S3 storage, replace the endpoint, region, and, if required, `AWS_S3_FORCE_PATH_STYLE`.

`brotli`: By default, compression in MDB. If the backup was compressed using a different algorithm, specify it: this setting is required for searching the slot map with the `backup-info --tag Slots` command.

You do not need to import the key to GPG, as WAL-G reads it from the file. You also need the original {{ VLK }}'s password for downloading the backup.

1. Check the access and select and a backup:

   ```bash
   wal-g-redis --config "$WALG_CONFIG" backup-list
   ```

   Select the exact name from the list and look at the metadata:

   ```bash
   export BACKUP_NAME="aof_20261004T223158Z"
   wal-g-redis --config "$WALG_CONFIG" backup-info "$BACKUP_NAME"
   ```

   Example of shortened output:

   ```json
   [
     {
       "BackupName": "aof_20261004T223158Z",
       "StartLocalTime": "2026-10-04T22:31:58.891678Z",
       "FinishLocalTime": "2026-10-04T22:34:28.238213Z",
       "UserData": {
         "backup_id": "mdbmletglr2cuu7m51t5",
         "shard_name": "shard1"
       },
       "DataSize": 1257101930,
       "BackupSize": 209362565,
       "BackupType": "aof",
       "Version": "9.1.2",
       "UsedMemory": 6437938008,
       "UsedMemoryRss": 6463381504,
       "MaxDBNumber": 0
     }
   ]
   ```

   From the output, you will require:

   * `BackupName`: Name for the recovery. Use it instead of `UserData.backup_id`.
   * `BackupType`: `rdb` or `aof`.
   * `Version`: Version of the original {{ VLK }}. If there is no field, ask the party who provided the backup to also provide the version.
   * `DataSize`, `BackupSize`: Data and backup size in bytes. `UsedMemory` and `UsedMemoryRss` show the original server's memory usage but do not guarantee equal usage when recovering.
   * `MaxDBNumber`: The maximum number of a non-empty logical database. The number of databases in the configuration file must be greater than that number.

   `StartLocalTime` and `FinishLocalTime` stand for the backup creation time; `UserData` stands for additional info on the backup and original shard. An individual field can be read through `backup-info --tag`, e.g.:

   ```bash
   wal-g-redis --config "$WALG_CONFIG" backup-info --tag Version "$BACKUP_NAME"
   ```

1. Check backup integrity:
 
   {% include [checkup](../../_includes/mdb/backup-checkup.md) %}

   1. Run the script:

      ```bash
      WAL_G_BIN=wal-g-redis ./s3_test_script.sh */etc/wal-g/wal-g.yaml*
      ```
   
      If required, specify a folder:

      ```bash
      WAL_G_BIN=wal-g-redis ./s3_test_script.sh */etc/wal-g/wal-g.yaml* basebackups_005 # checks backups
      ```

      Here is an example of the command output:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:

1. Set up {{ VLK }}:

   Install the required version from [public sources](https://valkey.io/topics/installation/). If the original cluster used modules, install and enable them through `loadmodule` before loading data.

   Check the version of the binary file run by the service and stop the server:

   ```bash
   valkey-server --version
   systemctl stop valkey-server
   systemctl is-active valkey-server
   ```

   Expected result: `inactive` and non-zero return code. Likewise, other {{ VLK }} processes must not use the recover folder. `backup-fetch` clears the AOF folder as well as the `*.rdb` and `*.aof` files in the data folder. Use a dedicated folder or save its contents in advance if you still need them.

   ```bash
   install -d -o valkey -g valkey -m 0750 /var/lib/valkey
   ```

   In `/etc/valkey/valkey.conf`, set the following:

   ```conf
   bind 127.0.0.1
   port 6379
   protected-mode yes
   requirepass "<new {{ VLK }} password>"

   dir /var/lib/valkey
   dbfilename dump.rdb
   appenddirname appendonlydir
   appendfilename "appendonly.aof"
   aof-use-rdb-preamble yes
   appendfsync everysec

   # For the AOF backup in Step 5, replace with _yes_.
   appendonly no

   # Increase it if MaxDBNumber >= 16.
   databases 16
   cluster-enabled no
   ```

   Stick with the `systemd` and journaling parameters suitable for your setup. `dir` must match `WALG_REDIS_DATA_PATH`, `appenddirname` must match `WALG_REDIS_APPENDONLY_PATH`, and the RDB path, that in `WALG_STREAM_RESTORE_COMMAND`.

   Users, roles, and access settings are not recovered from the data copy. Set a new password and enter it for local commands.

   ```bash
   read -r -s -p "Password for the new {{ VLK }} instance: " REDISCLI_AUTH
   export REDISCLI_AUTH
   ```

   `valkey-cli` uses the `REDISCLI_AUTH` variable despite its name. In the new session, enter the password again. If individual ACL users are configured, add `--user <name>` to the commands.

1. Recover the backup. Select an option based on the `BackupType` field. {{ VLK }} must be stopped; run it only after `backup-fetch` completes successfully.

  * Option A: RDB

      ```bash
      wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" -t rdb
      test -s /var/lib/valkey/dump.rdb
      chown -R valkey:valkey /var/lib/valkey
      ```

      When first running it, the configuration file must have **`appendonly no`**, so that {{ VLK }} loads the recovered `dump.rdb` instead of the AOF.

      ```bash
      systemctl start valkey-server
      valkey-cli PING
      valkey-cli INFO persistence
      ```

      Wait for `PONG` and `loading:0`. If the upload is not complete, view the log:

      ```bash
      journalctl -u valkey-server -n 100 --no-pager
      ```

      If you need AOF further on, enable it on the already uploaded server.

      ```bash
      valkey-cli CONFIG SET appendonly yes
      valkey-cli INFO persistence
      ```

      Wait until the AOF has been created. `INFO persistence` should have:

      ```text
      aof_enabled:1
      aof_rewrite_in_progress:0
      aof_rewrite_scheduled:0
      aof_last_bgrewrite_status:ok
      aof_last_write_status:ok
      ```

      After that, save the setting:

      ```bash
      valkey-cli CONFIG REWRITE
      ```

      If the command cannot write the configuration file, replace `appendonly no` with `appendonly yes` in it manually. Do not restart the server with enabled AOF until its files have been successfully created.

      To work only with RDB, leave `appendonly no` and configure the snapshot schedule.

  * Option B: AOF

      Transfer the full version of the **installed {{ VLK }}** from `valkey-server --version`. For example:

      ```bash
      export TARGET_VERSION="9.1.2"
      wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" \
         -t aof --redis-version "$TARGET_VERSION"
      ```

      WAL-G will recover the multi-file AOF to `/var/lib/valkey/appendonlydir`, complete with `manifest` and all files listed therein. You do not need to join parts or rename them.

      ```bash
      ls -lah /var/lib/valkey/appendonlydir
      chown -R valkey:valkey /var/lib/valkey
     ```

     In `/etc/valkey/valkey.conf`, enable AOF:

     ```conf
     appendonly yes
     ```

   Start the server:

   ```bash
   systemctl start valkey-server
   valkey-cli PING
   valkey-cli INFO persistence
   journalctl -u valkey-server -n 100 --no-pager
   ```

   Wait for `PONG`, `loading:0`, and `aof_enabled:1`. The log should contain no `manifest` read errors, upload errors, or AOF truncation errors.

1. Check the data and configure access:

   ```bash
   valkey-cli INFO keyspace
   ```

   Check the list of logical DBs and some of the known keys: types, values, and the application's performance. For a DB different from DB 0, use `valkey-cli -n <number>`. The log should show no data read errors, missing modules, insufficient memory.

   Keys whose TTL has expired by the time of the recovery may be missing, since recovery does not renew their TTL. Therefore, the number of keys may be different from that at the backup creation time.

   Before enabling the application, configure the users and ACL, `bind`, TLS, and firewall, adjusting them to your network. Use the new credentials.

## Restoring a sharded cluster {#sharded-cluster}

Each original shard is recovered to a dedicated new master with its **own original slots**. First, you need to build an empty cluster with the required slot distribution, then stop it, recover the data, and start it again.

1. Select backups and get a slot map.

   For each shard, prepare a WAL-G by following Steps 1-3, with its own `WALG_S3_PREFIX` and an exact backup name. Select backups from one set of backups. Independent choice of `LATEST` for each shard may lead to different sets.

   Record the mapping of the original shards' to the new servers. For example:

   | Original shard ID | S3 prefix | `BackupName` | New server |
   | --- | --- | --- | --- |
   | `<source-shard-id-1>` | `s3://.../shard-1` | `<backup-name-1>` | `10.0.0.11` |
   | `<source-shard-id-2>` | `s3://.../shard-2` | `<backup-name-2>` | `10.0.0.12` |
   | `<source-shard-id-3>` | `s3://.../shard-3` | `<backup-name-3>` | `10.0.0.13` |

   Read each backup's `BackupType` and `Version` and extract the slot map:

   ```bash
   wal-g-redis --config "$WALG_CONFIG" backup-info --tag Slots "$BACKUP_NAME"
   ```

   Here is an example:

   ```json
   {
     "source-shard-id-1": [["0", "5460"]],
     "source-shard-id-2": [["5461", "10922"]],
     "source-shard-id-3": [["10923", "16383"]]
   }
   ```

   Keys: Original shard IDs, not the new servers' node IDs and not necessarily `UserData.shard_name`. Map them to their folders based on the info provided along with the backup. A regular `backup-info` does not output the slot map.

   A shard can have multiple non-contiguous intervals, with both boundaries inclusive. A single slot is a pair of identical numbers. If the value equals `null`, the shard has no assigned slots and the command for assigning them should be skipped.

   The maps of the selected backups should be in alignment, and all ranges together should cover `0–16383` without gaps or overlaps.

   If the map cannot be read, check the prefix, backup name and integrity, and `WALG_COMPRESSION_METHOD`. If there is no map or the mapping of folders to the original IDs is lost, request this info from the party who provided the backup.

   {% note warning %}

   Do not replace the original map with uniform division and do not assign slots through automatic `valkey-cli --cluster create`, as the resulting distribution may not correspond to the data in.

   {% endnote %}

1. Prepare empty nodes.

   Install the required version of {{ VLK }} and modules on each server and prepare the configuration file and data folder. The folders must be new and clear of old data or an extra `nodes.conf`.

   Replace the network and cluster mode properties in the configuration file. Example for the first server:

   ```conf
   bind 127.0.0.1 10.0.0.11
   cluster-enabled yes
   cluster-config-file /var/lib/valkey/nodes.conf
   cluster-node-timeout 15000
   cluster-require-full-coverage yes
   cluster-announce-ip 10.0.0.11
   cluster-announce-port 6379
   cluster-announce-bus-port 16379
 
   # While the empty cluster is being created, for both backup types.
   appendonly no
   databases 1
   ```

   On the rest of the servers, provide their own IPs. Allow the nodes to connect to each other on ports `6379` and `16379`. Set `requirepass` and `REDISCLI_AUTH` as in Step 4. The application should not write to the cluster until the recovery is complete.

   In {{ VLK }} 9.0+, the number of DBs in cluster mode is defined by `cluster-databases`: add `cluster-databases 1` for a regular cluster with DB 0, and if `MaxDBNumber` is greater than zero, set a number greater than that number. {{ VLK }} 7.2/8.x does not feature this parameter.

   Start the empty servers:

   ```bash
   systemctl start valkey-server
   valkey-cli CLUSTER NODES
   ```

   Right now, each node should only have its own record without slots.

1. Assign slots and join nodes.

   To join, assign each node a unique positive config epoch and assign ranges from the `Slots` map.

   For the map from the example on the first server:

   ```bash
   valkey-cli CLUSTER SET-CONFIG-EPOCH 1
   valkey-cli CLUSTER ADDSLOTSRANGE 0 5460
   ```

   On the second server:

   ```bash
   valkey-cli CLUSTER SET-CONFIG-EPOCH 2
   valkey-cli CLUSTER ADDSLOTSRANGE 5461 10922
   ```

   On the third one:

   ```bash
   valkey-cli CLUSTER SET-CONFIG-EPOCH 3
   valkey-cli CLUSTER ADDSLOTSRANGE 10923 16383
   ```

   Use your backup's actual ranges. You can provide multiple ranges with one command, e.g., `CLUSTER ADDSLOTSRANGE 0 100 500 700`.

   For the first server, meet the nodes:

   ```bash
   valkey-cli CLUSTER MEET 10.0.0.12 6379
   valkey-cli CLUSTER MEET 10.0.0.13 6379
   ```

   Wait for the topology exchange to complete. On each server, check and save it:

   ```bash
   valkey-cli CLUSTER NODES
   valkey-cli CLUSTER INFO
   valkey-cli CLUSTER SAVECONFIG
   ```

   All nodes with the original ranges should appear, `cluster_state:ok`, `cluster_slots_assigned:16384`, and `cluster_slots_ok:16384`.

   Stop the service on all servers:

   ```bash
   systemctl stop valkey-server
   systemctl is-active valkey-server
   ```

   Save the created `/var/lib/valkey/nodes.conf`: they contain the new topology. Do not delete them when performing recovery and do not replace them with the original cluster's files.

1. Recover the shard data.

   On each stopped node, specify its `WALG_CONFIG` and `BACKUP_NAME`. For AOF, also specify `TARGET_VERSION`, which is the complete version of the installed {{ VLK }}.

   Run one command based on the backup type:

   ```bash
   # RDB:
   wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" -t rdb

   # Or AOF:
   wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" \
     -t aof --redis-version "$TARGET_VERSION"
   ```

   After it completes successfully, check the recovered files as in Step 5 and correct the owner:

   ```bash
   chown -R valkey:valkey /var/lib/valkey
   ```

   In the configuration file, set `appendonly no` for RDB or `appendonly yes` for AOF. The cluster parameters and `nodes.conf` should be saved.

   After all shards' files have been recovered, run start the services:

   ```bash
   systemctl start valkey-server
   ```

   After RDB recovery, enable AOF in the order described in Step 5 if required, with RDB upload followed by AOF creation and saving the settings. While the rest of the nodes are being started and the topology exchange is under way, a temporary `cluster_state:fail` is possible.

1. Check the cluster.

   On each server, run the following:

   ```bash
   valkey-cli PING
   valkey-cli INFO persistence
   valkey-cli INFO keyspace
   valkey-cli CLUSTER INFO
   valkey-cli CLUSTER NODES
   journalctl -u valkey-server -n 100 --no-pager
   ```

   Make sure that:

   * All nodes have loaded data (`loading:0`) and the logs show no data or module read errors.
   * The state on all nodes is as follows: `cluster_state:ok`, `cluster_slots_assigned:16384`, `cluster_slots_ok:16384`, `cluster_slots_fail:0`, and `cluster_slots_pfail:0`.
   * Each shard ends up on the required server, with its ranges matching the `Slots`. There are now incomplete migrating/importing slots or nodes with the `fail`/`fail?` flags.
   * Known keys are read through the client with cluster support. For the CLI, use `valkey-cli -c`.

After checking all that, configure access and enable the application. The client needs new credentials and network access to the addresses announced by all nodes

## If recovery failed {#troubleshooting} 

| Symptom | What to check                                                                                  |
| --- |------------------------------------------------------------------------------------------------|
| `backup-list` is empty. | The prefix should point to the `basebackups_005/` parent. Check the endpoint, bucket, and S3 permissions. |
| S3 returns `AccessDenied`. | Keys, list and read permissions, region, and S3 addressing parameters.                           |
| Decryption error. | Private PGP key and its password phrase, if it is set.                                     |
| `backup-info --tag Slots` does not find the object. | Backup integrity, presence of a map in the original backup, and `WALG_COMPRESSION_METHOD`.           |
| WAL-G states that the version is incompatible when recovering AOF. | `--redis-version` should have the installed {{ VLK }} version, not older than the original one.          |
| After recovery, the RDB is empty or different data is uploaded. | Data folder, `dbfilename`, and the first run with `appendonly no`.                                |
| The RDB/AOF error mentions an unknown module type or command. | Whether compatible the original cluster's compatible modules have been installed and enabled through `loadmodule`.   |
| {{ VLK }} cannot open files. | Owner, permissions, and matching paths in the WAL-G and {{ VLK }} configuration files.                |
| `CLUSTERDOWN` after launching all nodes. | Network, announced addresses, slot map, `nodes.conf`, and each shard's upload.                 |
| There are fewer keys than expected. | Choice of selected backup, presence of all shards and DBs, expired TTLs, and upload log.               |

After a download or upload error, fix the cause and repeat the recovery with the server stopped. Partially created files do not mean backup recovery has succeeded.