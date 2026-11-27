---
title: Recovering MongoDB from a {{ mmg-full-name }} backup with the help of WAL-G
description: Follow this guide to recover MongoDB from a WAL-G backup you got from {{ mmg-name }}.
noIndex: true
alternate:
  - href: en/storedoc/operations/cluster-outbound-backups.md
    type: text/markdown
    title: Markdown version
---

# Recovering MongoDB from a WAL-G backup

If you received a backup of a {{ mmg-name }} cluster as a WAL-G directory from S3, you can recover the data on a MongoDB server of your own. You do not need {{ yandex-cloud }} and {{ mmg-name }} for that: all you need is access to the backup, an encryption key, and MongoDB and WAL-G installed.

## Transmitted data {#data}

#|
|| **Resource** | **Content** ||
|| `basebackups_005/` | Backups: binary (`binary_<time>`) or logical (`stream_<time>`, for old clusters). Each backup is self-sufficient and does not require a chain of previous backups. ||
|| `oplog_005/` | Operations log archive `oplog` required for Point-in-Time-Recovery (PITR). ||
|#

For a sharded cluster, you need this set of data separately for the configuration server replica set (`config server replica set`) and each data shard.

## Getting started {#before-you-begin}

To complete this guide, you will need the following:

* MongoDB of the same major version as the original cluster. Use [Percona Server for MongoDB](https://docs.percona.com/percona-server-for-mongodb/8.0/install/index.html) because {{ mmg-name }} uses a build based on Percona.
* Binary WAL-G file for MongoDB (`wal-g-mongo`) from the [release page](https://github.com/wal-g/wal-g/releases) suitable for the OS and the server architecture.
* Encryption key.
* If the backup is in S3, static access key with bucket read permissions: ID and secret key. If the backup has already been downloaded to the disk, no S3 access is required.
* Free disk space with a margin for full unpacked data size. To view the backup's metadata, use the `backup-show` command at the [backup selection](#select-backup) step.

The main guide describes recovering a binary copy of an unsharded cluster into a single-host replica set. Use separate sections for a [sharded cluster](#sharded-cluster) and a [logical backup](#logical-backup).

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Restoring a database {#restore}

### Install MongoDB and WAL-G {#install}

1. Install Percona Server for MongoDB. For example, for version `8.0` on Debian or Ubuntu:

   ```bash
   wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
   sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
   sudo percona-release enable psmdb-80 release
   sudo apt update && sudo apt install -y percona-server-mongodb
   sudo systemctl stop mongod
   ```

   For a different version select a suitable Percona repository, e.g., `psmdb-70` for MongoDB `7.0`.

1. Download the WAL-G for MongoDB archive from the [release page](https://github.com/wal-g/wal-g/releases). Unpack and install the binary:

   ```bash
   tar -xzf <WAL-G_archive>
   sudo install -m 755 <WAL-G_binary_file> /usr/local/bin/wal-g-mongo
   wal-g-mongo --version
   ```

   Where `<WAL-G_archive>` is in `wal-g-mongo-*.tar.gz` format, and `<WAL-G_binary_file>` is in `wal-g-mongo-*-amd64` format.

### Configure WAL-G {#configure-wal-g}

1. Create the configuration and log directories, then copy the encryption key:

   ```bash
   sudo mkdir -p /etc/wal-g /var/log/wal-g
   sudo cp GPG_KEY /etc/wal-g/GPG_KEY
   sudo chmod 600 /etc/wal-g/GPG_KEY
   ```

1. Create the `/etc/wal-g/wal-g.yaml` file, its parameters depending on where the backup is:

   {% list tabs %}

   - Backup in S3

     ```yaml
     AWS_ACCESS_KEY_ID: <static_key_ID>
     AWS_SECRET_ACCESS_KEY: <secret_key>
     AWS_ENDPOINT: https://storage.yandexcloud.net
     AWS_REGION: ru-central1
     AWS_S3_FORCE_PATH_STYLE: true
     WALG_S3_PREFIX: s3://<bucket_name>/<backup_prefix>
     WALG_PGP_KEY_PATH: /etc/wal-g/GPG_KEY
     ```

     In `WALG_S3_PREFIX`, specify the directory `basebackups_005/` and `oplog_005/` are in. For a third-party S3 storage, replace endpoint and region with values of its own.

   - Backup on disk

     ```yaml
     WALG_FILE_PREFIX: /data/backup/<backup_directory>
     WALG_PGP_KEY_PATH: /etc/wal-g/GPG_KEY
     ```

     In `WALG_FILE_PREFIX`, specify the local directory `basebackups_005/` and `oplog_005/` are in.

   {% endlist %}

   If the PGP key is password-protected, add the `WALG_PGP_KEY_PASSPHRASE` parameter with this password.

   For point-in-time recovery (PITR), add an idempotency error processing setting to the `/etc/wal-g/wal-g.yaml` file at the [Recover binary copy](#restore-binary) step:

   ```yaml
   OPLOG_REPLAY_IGNORE_ERROR_CODES: '{"u": [11000, 11001, 12582, 16460], "i": [11000, 11001, 12582, 16460]}'
   ```

   The compression method needs not be specified: it is only required when creating a backup.

1. Restrict access to the configuration:

   ```bash
   sudo chmod 600 /etc/wal-g/wal-g.yaml
   ```

### Select a backup {#select-backup}

1. Check access to the storage:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml backup-list
   ```

   If the command returns the backup list, your access to the storage and configuration path are configured correctly. The names of binary backups begin with `binary_`, e.g., `binary_20260407T222057Z`. If the names begin with `stream_`, navigate to [recovering a logical backup](#logical-backup).

1. Select a backup created prior to the time point you want to restore the cluster to and get its metadata.

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml backup-show <copy_name>
   ```

   Look up the original cluster's version in `MongoMeta.Version` and data size. PITR also uses `MongoMeta.BackupLastTS`, i.e., the backup approval moment.

1. Check the backup for integrity:
 
   {% include [checkup](../../_includes/mdb/backup-checkup.md) %}

   1. Run the script:

      ```bash
      WAL_G_BIN=wal-g-mongo ./s3_test_script.sh */etc/wal-g/wal-g.yaml*
      ```
   
      If necessary, specify the directory:

      ```bash
      WAL_G_BIN=wal-g-mongo ./s3_test_script.sh */etc/wal-g/wal-g.yaml* basebackups_005 # checking backups
      WAL_G_BIN=wal-g-mongo ./s3_test_script.sh */etc/wal-g/wal-g.yaml* oplog_005 # checking operations log archive
      ```

      Here is an example of the command output:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:

### Prepare the MongoDB configuration {#configure-mongodb}

1. Edit `/etc/mongod.conf`:

   ```yaml
   storage:
     dbPath: /var/lib/mongodb
     directoryPerDB: true
     engine: wiredTiger
     wiredTiger:
       collectionConfig:
         blockCompressor: snappy

   net:
     port: 27017
     bindIp: 127.0.0.1

   replication:
     replSetName: rs01
   ```

   The storage settings must be aligned with the original cluster. The example uses `directoryPerDB: true` and `snappy` for compression; if the original cluster uses a different `blockCompressor`, specify its value.

   Until you have configured authentication, leave only access through the local interface. The host name you specify in `--mongo-rs-members` must resolve on this server into an address available for `mongod`.

1. Create a minimal configuration `/etc/wal-g/mongod-minimal.conf`, which WAL-G will use to start the `mongod` temporary process:

   ```yaml
   systemLog:
     destination: file
     path: /var/log/wal-g/mongod-restore.log
     logAppend: true

   storage:
     dbPath: /var/lib/mongodb
     directoryPerDB: true
     engine: wiredTiger
     wiredTiger:
       collectionConfig:
         blockCompressor: snappy
   ```

   The `dbPath`, `directoryPerDB`, and `blockCompressor` values must match in both files.

### Restore the binary backup {#restore-binary}

{% note warning %}

WAL-G deletes the old content of the `dbPath` directory. If you need this data, save it before you run the recovery. During recovery, MongoDB must be stopped.

{% endnote %}

1. Stop MongoDB:

   ```bash
   sudo systemctl stop mongod
   ```

1. Perform the recovery. Instead of the backup name, you can specify `LATEST` to select the last one. Specify a major version of the original cluster, e.g., `8.0`.

   {% list tabs %}

   - At the time of backup creation

     ```bash
     sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
       <backup_name_or_LATEST> /etc/mongod.conf <major_version> \
       --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
       --mongo-rs-name rs01 \
       --mongo-rs-members "$(hostname -f):27017" \
       2>&1 | sudo tee /var/log/wal-g/restore.log
     ```

   - At a specified time

     ```bash
     sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
       <backup_name_or_LATEST> /etc/mongod.conf <major_version> \
       --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
       --mongo-rs-name rs01 \
       --mongo-rs-members "$(hostname -f):27017" \
       --pitr-since LATEST_ON_REPLICA \
       --pitr-until <target_moment> \
       2>&1 | sudo tee /var/log/wal-g/restore.log
     ```

     Where `<target_moment>` is the time point you need to restore the cluster to, in `<Unix_seconds>.<increment>` format, e.g., `1760086800.1`.

     For PITR, you need a continuous archive `oplog_005/` from the selected backup the time point you need to restore the cluster to. The archive files have this naming format: `oplog_<start>_<end>.*`.

     `LATEST_ON_REPLICA` selects the start point based on the last logged record `local.oplog.rs` of the restored backup. Instead of it, you can provide `MongoMeta.BackupLastTS` from `backup-show`: `<T>.<I>`, where `T` is Unix time in seconds, `I` is an increment.

     To get the number of Unix seconds for `October 10, 2026, 12:00:00`, Moscow time, do the following on Linux:

     ```bash
     date -d '2026-10-10 12:00:00+03' +%s
     ```

     The command will return `1791622800`. Add `.1` to the result to get `1791622800.1`. The end boundary is not included: the operation corresponding to `--pitr-until` is not used.

     To restore till the end of the available archive, specify `--pitr-until LATEST`.

   {% endlist %}

   WAL-G will run a version compatibility check and make sure that no `mongod` is running; it will then download, decrypt, and unpack the data. Next, it will run a temporary `mongod`, change the replica set configuration and, if necessary, apply `oplog`. When done, WAL-G will stop the temporary process.

   Download parallelism is controlled by the `WALG_DOWNLOAD_CONCURRENCY` parameter in the WAL-G configuration.

### Run MongoDB {#start-mongodb}

1. Identify the user and service group:

   ```bash
   systemctl show mongod --property=User --property=Group
   ```

   In Percona, the service normally operates from the `mongod` user; in MongoDB packages for Debian or Ubuntu it does from `mongodb`. If `Group` is not set, use the service user's main group, which you can learn using the `id -gn <user>` command.

1. Correct the owner of the recovered files and run the service:

   ```bash
   sudo chown -R <user>:<group> /var/lib/mongodb
   sudo systemctl start mongod
   mongosh --port 27017 --eval 'rs.status().members.map(m => [m.name, m.stateStr])'
   ```

   Wait for the `PRIMARY` status. If the host is not changing to this status, check the configuration and logs:

   ```bash
   mongosh --port 27017 --eval 'rs.conf()'
   sudo journalctl -u mongod --no-pager -n 200
   ```

   The host name from `--mongo-rs-members` must resolve locally and match the address in `rs.conf()`.

   Do not run `rs.initiate()` automatically: WAL-G is already restoring the replica set configuration. The command is allowed only is you have made sure that there is no replica set configuration.

### Configure users and access {#configure-access}

Users and password hashes are restored together with the data, which is why the passwords of the app users get saved. The original cluster's service user passwords are not transmitted, so create an administrator of your own.

1. Create an administrator while authorization is off:

   ```javascript
   db.getSiblingDB("admin").createUser({user: "root", pwd: passwordPrompt(), roles: ["root"]})
   ```

1. View the list of users:

   ```javascript
   db.getSiblingDB("admin").system.users.find({}, {user: 1, db: 1, roles: 1})
   ```

   Delete the service users of the original cluster:

   ```javascript
   db.getSiblingDB("admin").dropUser("<name>")
   ```

   You do not need the `mdb_internal` service base on the new server.

1. Exit `mongosh` and create a key for internal replica set authentication. The single-host set needs one too:

   ```bash
   sudo openssl rand -base64 756 | sudo tee /etc/mongod-keyfile > /dev/null
   sudo chown <user>:<group> /etc/mongod-keyfile
   sudo chmod 400 /etc/mongod-keyfile
   ```

1. Add the following to `/etc/mongod.conf`:

   ```yaml
   security:
     authorization: enabled
     keyFile: /etc/mongod-keyfile
   ```

1. Restart MongoDB and configure `net.bindIp`, TLS, and firewall to connect applications from your network. Check the database list using the `show dbs` command, number of documents in collections using `db.<collection>.countDocuments()`, and test the application.

## Restoring a sharded cluster {#sharded-cluster}

To restore an original sharded cluster, you need backups of all the shards and configuration servers. Configuration servers store information on shards, chunks, sharded collections, main database shards, and zones.

If you have no backup of the configuration servers, you can restore individual shards as independent sets of replicas using the [main guide](#restore). In which case WAL-G will delete the old `shardIdentity`; the original structure of the sharded cluster cannot be restored.

Below is an example with separate servers: one for the replica set (`mongocfg`), one for each shard (`shard01` and `shard02`), and one for the router (`mongos`). Replace their names and URLs with yours. Save the original shard IDs.

### Prepare the servers {#prepare-sharded-cluster}

1. [Install MongoDB and WAL-G](#install) and [set up access to backups](#configure-wal-g) on each server you plan to recover data on.
1. In each server's WAL-G configuration, specify `WALG_S3_PREFIX` or `WALG_FILE_PREFIX` for the relevant component. Inside the directory, its `basebackups_005/` and `oplog_005/` must be residing.
1. Select the backups and the time point to restore the cluster to. Each component's `oplog` archive must cover the interval from its backup to this moment without interruption. Use the same `--pitr-until` value and `--pitr-since LATEST_ON_REPLICA` parameter for all components. Do not use `LATEST` in the `--pitr-until` parameter: the end of the archive can be different for different components.
1. Configure name resolution and network connectivity between the servers. While authorization is off, isolate the recovery network from external connections. The `net` parameters in the examples must be adapted for your network.

   The examples below illustrate restoration via WAL-G which you can do yourself and require `oplog` archives of all components. They do not change the [PITR limitations in {{ mmg-name }}](../concepts/backup.md#pitr-details).

### Restore the configuration server {#restore-config-server}

1. Create a `/etc/mongocfg.conf`:

   ```yaml
   storage:
     dbPath: /var/lib/mongodb
     directoryPerDB: true
     engine: wiredTiger
     wiredTiger:
       collectionConfig:
         blockCompressor: snappy

   net:
     port: 27019
     bindIp: 127.0.0.1

   replication:
     replSetName: mongocfg

   sharding:
     clusterRole: configsvr
   ```

1. Create a [minimal configuration](#configure-mongodb) `/etc/wal-g/mongod-minimal.conf`. Its storage settings must match `/etc/mongocfg.conf` and the original cluster.
1. Make sure `mongod` is stopped and run the recovery:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
     <backup_name_or_LATEST> /etc/mongocfg.conf <major_version> \
     --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
     --mongo-rs-name mongocfg \
     --mongo-rs-members "$(hostname -f):27019" \
     --mongo-shard-conn-str "shard01/shard01-1.example.net:27017" \
     --mongo-shard-conn-str "shard02/shard02-1.example.net:27017" \
     --pitr-since LATEST_ON_REPLICA \
     --pitr-until <target_moment> \
     2>&1 | sudo tee /var/log/wal-g/restore.log
   ```

   Where `<target_moment>` is the time point you need to restore the cluster to, in `<Unix_seconds>.<increment>` format, e.g., `1760086800.1`. Specify the same value for the configuration server and all shards.

   Specify `--mongo-shard-conn-str` for each shard in `<original_shard_ID>/<new_hosts_comma_separated>` format. WAL-G will clear `config.mongos`, `config.lockpings`, and `config.shards`, then populate `config.shards` with the IDs and addresses you specified. The rest of the routing metadata is taken from the backup.

1. [Correct the file owner](#start-mongodb) in `dbPath` to the user and group you are going to use to run `mongod`.

### Restore the shards {#restore-shards}

On each shard's server:

1. Prepare the [main and minimum configurations](#configure-mongodb). In `/etc/mongod.conf` add:

   ```yaml
   replication:
     replSetName: <shard_ID>

   sharding:
     clusterRole: shardsvr
   ```

1. Make sure `mongod` is stopped and restore the backup of the shard in question:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
     <shard_backup_name> /etc/mongod.conf <major_version> \
     --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
     --mongo-rs-name <shard_ID> \
     --mongo-rs-members "<shard_host_name>:27017" \
     --mongo-sh-name <shard_ID> \
     --mongo-cfg-conn-str "mongocfg/cfg1.example.net:27019" \
     --pitr-since LATEST_ON_REPLICA \
     --pitr-until <target_moment> \
     2>&1 | sudo tee /var/log/wal-g/restore.log
   ```

   Where `<target_moment>` is the time point you need to restore the cluster to, in `<Unix_seconds>.<increment>` format, e.g., `1760086800.1`. Specify the same value for the configuration server and all shards.

   The shard ID and host address values must match those specified in `--mongo-shard-conn-str` when restoring the configuration server.

1. [Correct the file owner](#start-mongodb) in `dbPath`.

### Start the cluster and check the data {#start-sharded-cluster}

1. On the configuration server, run `mongod` with the file you prepared:

   ```bash
   sudo mongod --config /etc/mongocfg.conf
   ```

   The command starts the process in the current terminal. Check the replica set status in the other terminal:

   ```bash
   mongosh --host "$(hostname -f)" --port 27019 \
       --eval 'rs.status().members.map(m => [m.name, m.stateStr])'
   ```

1. [Start MongoDB](#start-mongodb) on each shard. Wait for the `PRIMARY` status on the configuration server and each shard. Do not run `rs.initiate()`: WAL-G has already recorded the configuration of the replica sets.
1. Create `/etc/mongos.conf` on the configuration server:

   ```yaml
   sharding:
     configDB: mongocfg/cfg1.example.net:27019

   net:
     port: 27017
     bindIp: 127.0.0.1
   ```

   `mongos` does not store its own data; therefore, it should not be restored from a backup. Start the router:

   ```bash
   sudo mongos --config /etc/mongos.conf
   ```

1. In the other terminal on the router server, connect to it using the `mongosh --host "$(hostname -f)" --port 27017` command and check the metadata:

   ```javascript
   db.adminCommand({listShards: 1})
   sh.status()
   db.getSiblingDB("config").shards.find()
   db.getSiblingDB("config").databases.find()
   db.getSiblingDB("config").collections.find()
   db.getSiblingDB("config").chunks.countDocuments()
   db.getSiblingDB("config").tags.find()
   ```

   On each shard, connect directly to its `mongod` and check `shardIdentity`:

   ```javascript
   db.getSiblingDB("admin").system.version.findOne({_id: "shardIdentity"})
   ```

   The `shardName` and `configsvrConnectionString` values must match the new configuration.

1. [Configure users and access](#configure-access) taking into account the sharded cluster's features:

   * Create and administer cluster users via `mongos`.
   * Generate `keyfile` once and safely copy the same file to the configuration server, all shards, and the router. On each server, set the owner and access permissions for the file.
   * Add `security.keyFile` to `/etc/mongocfg.conf`, `/etc/mongod.conf` on shards and `/etc/mongos.conf`. For `mongod`, also set `security.authorization: enabled`; for `mongos`, this parameter is not used.
   * Restart all components with their configurations, check authentication via `mongos`, then set up TLS, firewall, and access to apps.

   Check the database list, number of documents in key collections, and test the application via `mongos`.

## Recovering a logical backup (stream_*) {#logical-backup}

Backups with the `stream_` prefix are a logical dump generated by the `mongodump --archive` command. It gets restored to an already run empty MongoDB.

1. [Install MongoDB and WAL-G](#install), [configure WAL-G](#configure-wal-g) and install [MongoDB Database Tools](https://www.mongodb.com/docs/database-tools/installation/) with the `mongorestore` utility.
1. Prepare an empty MongoDB instance and run it. Use only the local interface to set up access.
1. Use the `backup-show` command to get the metadata of the selected backup and add it to `/etc/wal-g/wal-g.yaml`:

   ```yaml
   MONGODB_URI: 'mongodb://localhost:27017/?connect=direct'
   WALG_STREAM_RESTORE_COMMAND: 'mongorestore --archive --oplogReplay --uri="mongodb://localhost:27017"'
   ```

1. Restore the backup:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml backup-fetch <copy_name>
   ```

1. For PITR, apply the `oplog` archive from `MongoMeta.Before.LastMajTS` of the selected backup to the time point you need to restore the cluster to:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml oplog-replay \
     <starting_moment> <target_moment>
   ```

   Where:

   * `<starting_moment>` is the time point from which to apply operations from the `oplog` archive, in `<Unix_seconds>.<increment>` format. Use the `TS` and `Inc` fields from `MongoMeta.Before.LastMajTS` of the selected backup.
   * `<target_moment>` is the time point you need to restore the cluster to, in `<Unix_seconds>.<increment>` format, e.g., `1760086800.1`.

   The start boundary is included, the end boundary is not. The time point you need to restore the cluster to must come later than the end of creating the selected backup. The `oplog` archive must cover the whole recovery interval without interruption.

1. [Configure users and access](#configure-access) and check the restored data. If restoring to a separate MongoDB instance with a replica set, go `security.authorization: enabled` without `security.keyFile`: the internal key is required to authenticate the replica set members.

The restoration time depends on the amount of data, number of documents and indexes. If `mongorestore` ends due to lack of memory, add the `--numParallelCollections=1 --batchSize=100` parameters to `WALG_STREAM_RESTORE_COMMAND`.
