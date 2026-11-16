---
title: '[Restoring data from a {{ mch-full-name }} cluster''s `ch-backup`](../managed-spqr/operations/cluster-backups.md#restore)'
description: Follow this guide to restore data from a {{ mch-name }} cluster's `ch-backup` on your server.
noIndex: true
---

# Restoring data from a `ch-backup`

If you have a {{ mch-name }} cluster's backup export, you can recover the data on your {{ CH }} server. For that, you will require the [ch-backup](https://github.com/yandex/ch-backup) utility and access to S3-compatible storage with backups.

## Transmitted data {#data}

#|
|| **Resource** | **Content**: ||
|| Backup folder | Subfolders, each of which matches one backup and has its name. Inside are the following files: `backup_light_struct.json` with open metadata and `backup_struct.json` with encrypted full metadata, `metadata/` folders with database and table schemas, `data/` with table data chunks, and `access_control/` with users and roles. ||
|#

Backups are deduplicated: if a data chunk has not changed, a new backup references it in one of the previous backups. To recover, save the entire export, including the previous backups which the selected one references.

## Getting started {#before-you-begin}

To complete this guide, you will need the following:

* A server with {{ CH }} of the same version as in the original cluster or higher. You can find out the original cluster's version in the [backup metadata](#inspect-backup). The featured examples of installation commands are for Ubuntu and Debian.
* Python 3.10 or higher to install `ch-backup`. Run `ch-backup` on the same server as {{ CH }}: the utility writes data chunks directly to the server's data folder.
* Bucket in S3-compatible storage, e.g., in {{ objstorage-name }} or local MinIO. `ch-backup` only reads backups from S3, and recovery directly from the local folder is not supported.
* Credentials with the permission to read the bucket. If you upload the export into the bucket, you will also require write permissions.
* Backup encryption key. It differs from a static access key for a bucket.
* Free disk space with a margin for the recovered data. Look at the `size` value in the `ch-backup list -v` command output at the [access check](#check-access) stage.

To work with metadata, install `jq`:

```bash
sudo apt install -y jq
```

To upload files to the bucket, install and configure the [AWS CLI](../../storage/tools/aws-cli.md) for the selected S3-compatible storage.

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Restoring data {#restore}

### 1. Check your export {#inspect-backup}

In the examples below, `/data/ch-dump` is a local folder with the backup export. Find the open metadata files in it:

```bash
find /data/ch-dump -name backup_light_struct.json
```

Result example:

```text
/data/ch-dump/ch_backup/c9qabcdefgh/shard1/b1/backup_light_struct.json
/data/ch-dump/ch_backup/c9qabcdefgh/shard1/b2/backup_light_struct.json
```

The folder with the backup subfolders is the backup root. In our example, this is `ch_backup/c9qabcdefgh/shard1`. You will need this path when [configuring `ch-backup`](#configure-ch-backup).

If there are multiple roots, e.g., `shard1` and `shard2`, recover each shard individually. For more information, see [Restoring a sharded cluster](#sharded-cluster).

If the export is already in the bucket, find out the backup root based on the object structure in the bucket. Download the `backup_light_struct.json` file of the selected backup to check its contents.

Look at the selected backup's metadata. If you downloaded the file from the bucket, provide the path to the file. The encryption key is not required for the check:

```bash
jq -c '{name: .meta.name, state: .meta.state, ch_version: .meta.ch_version, start_time: .meta.start_time, s3_disks: .cloud_storage.disks}' \
  /data/ch-dump/<backup_root>/<backup_name>/backup_light_struct.json
```

Result example:

```json
{"name":"b2","state":"created","ch_version":"25.3.6.56","start_time":"2026-10-12 01:58:21.547967 +0000","s3_disks":[]}
```

Check the fields:

* `state`: Should have the `created` value. A different value means that the backup is not complete.
* `ch_version`: The original cluster's {{ CH }} version.
* `s3_disks`: If the list is not empty, the original cluster used hybrid storage. Recovering cold data will also require a copy of the cold storage bucket. For more information, see [Recovering hybrid storage data](#hybrid-storage).

### 2. Upload the export to S3 {#upload-backup}

If the export is already in a bucket you have access to, proceed to [install {{ CH }}](#install-clickhouse).

Upload the entire export to an S3-compatible bucket while saving the folder structure. You can set a random prefix inside the bucket. Example for {{ objstorage-name }}:

```bash
aws s3 mb s3://<bucket_name> --endpoint-url https://{{ s3-storage-host }}
aws s3 sync /data/ch-dump s3://<bucket_name>/<prefix> --endpoint-url https://{{ s3-storage-host }}
```

If the bucket has already been created, run only the `aws s3 sync` command. For a different S3-compatible storage, set its endpoint in the `--endpoint-url` parameter.

### 3. Install {{ CH }} {#install-clickhouse}

Enable the [official {{ CH }} repository](https://clickhouse.com/docs/install) and install the version from the `ch_version` field or a higher one:

```bash
sudo apt install -y clickhouse-server=<version> clickhouse-client=<version> clickhouse-common-static=<version>
sudo systemctl start clickhouse-server
clickhouse-client -q "SELECT version()"
```

Use an empty server: it must not have user databases with names identical to those in the backup.

If you set the `default` user's password during installation, provide it via `clickhouse-client` when connecting and specify it in the [`ch-backup` configuration](#configure-ch-backup).

### 4. Install `ch-backup` {#install-ch-backup}

Build `ch-backup` from the current `main` branch of the [repository](https://github.com/yandex/ch-backup):

```bash
sudo apt install -y curl git make python3-venv
curl -LsSf https://astral.sh/uv/install.sh | sh
. "$HOME/.local/bin/env"

git clone https://github.com/yandex/ch-backup.git
cd ch-backup
make build

sudo python3 -m venv /opt/ch-backup
sudo /opt/ch-backup/bin/pip install dist/ch_backup-*.whl
sudo ln -s /opt/ch-backup/bin/ch-backup /usr/local/bin/ch-backup
ch-backup --help
```

The build employs `uv`. The `make build` command creates the `dist/ch_backup-<version>-py3-none-any.whl` packet that is installed in the Python virtual environment.

In older `ch-backup` versions, references to deduplicated data chunks contained a complete path. Such references may stop working after updating the backup root.

### 5. Configure `ch-backup` {#configure-ch-backup}

Create the configuration folder:

```bash
sudo mkdir -p /etc/yandex/ch-backup
```

Create the `ch-backup.conf` file in it that the utility reads by default:

```yaml
clickhouse:
  host: localhost
  # clickhouse_user: default
  # clickhouse_password: '<user_password>'

backup:
  path_root: <prefix>/<backup_root>

encryption:
  type: nacl
  key: '<encryption_key>'

storage:
  type: s3
  credentials:
    endpoint_url: https://{{ s3-storage-host }}
    bucket: <bucket_name>
    access_key_id: <static_key_ID>
    secret_access_key: '<secret_key>'
  boto_config:
    region_name: {{ region-id }}
    addressing_style: path
```

Where:

* `clickhouse.host`: Address of the local {{ CH }} server. If you need a password for connecting, uncomment `clickhouse_user` and `clickhouse_password` and specify your credentials.
* `backup.path_root`: Path inside the bucket to the folder containing the backup subfolders, without a bucket name or a specific backup's name, e.g., `from-yc/ch_backup/c9qabcdefgh/shard1`. If the export is in the bucket root, do not add a prefix.
* `encryption.key`: Contents of the encryption key file. The key must amount to exactly 32 bytes. Do not add spaces or a line advance from the end of the file. The inverted commas in the example pertain to the YAML syntax and are not part of the key value.
* `storage.credentials`: Endpoint, bucket name, and the credentials to access it. The example features the {{ objstorage-name }} endpoint; for a different storage, replace it.
* `storage.boto_config.region_name`: Region of the S3-compatible storage.
* `storage.boto_config.addressing_style: path`: Addressing style compatible with MinIO and the majority of S3-compatible storages.

Restrict access to the configuration file:

```bash
sudo chmod 600 /etc/yandex/ch-backup/ch-backup.conf
```

### 6. Check the access and encryption key {#check-access}

Get a list of backups:

```bash
sudo ch-backup list -v
```

Result example:

```text
name    state    start_time                        end_time                             size    real_size  ch_version
------  -------  --------------------------------  --------------------------------  -------  -----------  ----------
b2      created  2026-10-12 01:58:21.547967 +0000  2026-10-12 01:58:23.914994 +0000  2149888       417792  25.3.6.56
b1      created  2026-10-12 01:58:16.744487 +0000  2026-10-12 01:58:19.526529 +0000  1732096      1732096  25.3.6.56
```

If the command returned a list, access to the bucket and `backup.path_root` are configured correctly. If `real_size` is less than `size`, some of the data chunks are in previous backups.

The `list` command reads open metadata and does not check the encryption key. To check decryption, run the following:

```bash
sudo ch-backup show <backup_name> | jq -r '.databases | keys[]'
```

The command should output a list of databases for the selected backup.

### 7. Restore the schemas and data {#restore}

If you run recovery anew, e.g., after server cleanup, delete the state file of the previous recovery.

```bash
sudo rm -f /tmp/ch_backup_restore_state.json
```

{% note warning %}

If the recovery was interrupted and you want to resume it, save the `/tmp/ch_backup_restore_state.json` file. In this file, `ch-backup` marks already-recovered data chunks. If the server has been cleared with the state file saved, the utility may skip missing data chunks and leave the tables empty.

{% endnote %}

Run recovery.

```bash
sudo ch-backup restore <backup_name> --force-non-replicated
```

The `--force-non-replicated` parameter transforms `Replicated*MergeTree` tables into matching `*MergeTree` tables, and `Replicated` databases, into `Atomic` databases. This enables recovering data on a separate server without {{ ZK }} or {{ CK }}.

Additional parameters:

* `-d db1,db2`: Save only specified databases.
* `--exclude-databases db3`: Exclude the specified database from the recovery.
* `--table-included-patterns 'db1.orders,db2.*'`: Recover only selected tables.
* `--skip-cloud-storage`: Skip cold data belonging to [hybrid storage](#hybrid-storage).
* `--keep-going`: Resume recovery if the system could not recover some of the tables. Check for errors in the logs and whether the data is complete after the command runs.

The complete recovery log is in the `/var/log/ch-backup/ch-backup.log` file.

### 8. Recover users and roles {#restore-access}

The standard `restore` command does not recover users or roles. Run it separately with the `--access` parameter:

```bash
sudo ch-backup restore <backup_name> --access
```

Users, roles, and access permissions created via SQL are recovered together with password hashes. Existing passwords will still be valid. Users created with {{ mch-name }}, e.g., using the management console or API, do not end up in the backup. Create them anew.

After the restoration:

* Check the list of users with the `SHOW USERS` command and delete or block the original cluster's service users.
* Configure the `default` user's password and access to the server: `listen_host`, firewall, and TLS.

### 9. Check the data {#verify-data}

Get the list of recovered tables:

```bash
clickhouse-client -q "SELECT database, name, engine FROM system.tables WHERE database NOT IN ('system', 'INFORMATION_SCHEMA', 'information_schema')"
```

Number of rows in the key tables:

```bash
clickhouse-client -q "SELECT count() FROM <DB_name>.<table_name>"
```

Run the application and test the application's performance.

`Distributed`-Engine tables saves references to the cluster from the original server's configuration (`remote_servers`). Configure your cluster on a new server or re-create tables based on your topology. If you do not need the tables, delete them. While the configuration is not finished, queries against such tables will result in an error.

## Restoring a sharded cluster {#sharded-cluster}

Each shard uses its own backup root. Recover each shard on a dedicated {{ CH }} server:

1. Install {{ CH }} and `ch-backup` on the server.
1. In the `backup.path_root` parameter, specify the backup root for the shard in question.
1. Repeat the steps from the [verification check](#check-access), [data recovery](#restore-access), [user recovery](#restore-access), and [result check](#verify-data).

As a result, you will get independent servers with data parts. You can combine these in a cluster using `Distributed` tables or transfer data to one server.

## Recovering data in hybrid storage {#hybrid-storage}

If the `s3_disks` field in a backup's open metadata is not empty, part of the original cluster was stored on an S3 disk. The backup export contains the metadata of these chunks, and this cold storage remains in a dedicated hybrid-storage bucket.

Without access to cold data, recovery may result in a `Cloud storage source bucket must be set if backup has data on S3 disks` error.

To recover only data from local disks, use the `--skip-cloud-storage` parameter:

```bash
sudo ch-backup restore <backup_name> \
  --force-non-replicated \
  --skip-cloud-storage
```

{% note warning %}

When using `--skip-cloud-storage`, cold data is not recovered. The result will be incomplete.

{% endnote %}

Recovering cold data will also require a copy of the cold storage bucket. Its location is set by the `--cloud-storage-source-bucket`, `--cloud-storage-source-path`, and `--cloud-storage-source-endpoint` parameters of the `ch-backup restore` command.

## Troubleshooting {#troubleshooting}

#|
|| **Issue** | **What to check** ||
|| The `list` command returns an empty list. | Check the bucket and `backup.path_root`. The path must point to a folder containing the backup subfolders. ||
|| `The key must be exactly 32 bytes long` | Check the encryption key length. The value must contain no additional spaces, inverted commas, or line advance from the end of the file. ||
|| `Failed to download backup metadata .../backup_struct.json` | Check the encryption key: an error may mean that the system failed to decrypt full metadata. Also, check whether the presence of the file and access to it. ||
|| `Connection refused` when connecting to port `8123`. | Check the `clickhouse.host` value and make sure the {{ CH }} server is running. ||
|| `Restore requires ZooKeeper or ClickHouse Keeper because we have replicated tables` | To recover to a dedicated server without a coordination service, add the `--force-non-replicated` parameter. ||
|#

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
