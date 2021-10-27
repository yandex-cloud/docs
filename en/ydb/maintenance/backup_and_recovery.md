---
title: "Yandex Database (YDB) backups"
description: "This section describes the supported methods for creating backups of Yandex Database (YDB) databases and restoring from previously created backups. YDB allows you to use csv files to create backups on the file system and AWS S3-compatible storages."
---

# Backups

This section describes supported methods for creating YDB database backups and restoring data from previously created backups. {{ ydb-short-name }} lets you use the following destinations to create backups:

* CSV files on the file system.
{% if audience == "internal" %}
* YT.
{% endif %}
* AWS S3-compatible storage.

{% note warning "Effect of backups on performance" %}

Backups may negatively affect the database interaction indicators. Queries may take longer to execute. Before performing a database backup under load in production databases, test the process in the testing environment.

{% endnote %}

## Prerequisites

{% if audience == "external" %}

1. Install the [YDB console client](../quickstart/examples-ydb-cli.md).
1. In the DB properties, on the Overview tab, find and copy the **Endpoint** and **Database** field values.
1. Save the **Endpoint** and **Database** field values to the `$YDB_ENDPOINT` and `$YDB_DB_PATH` environment variables, respectively.

{% endif %}{% if audience != "external" %}

For any backup method described below, you'll need:

* [The YDB console client](../getting_started/ydb_cli.md).
* The DB endpoint (for information about endpoints, see the [Info](https://ydb.yandex-team.ru/db/ydb-ru/tutorial/home/testdb/info) page of your database).
* A user authorized to read and write data from the tables to be backed up.
* [A token to authenticate](../getting_started/start_auth.md) the user on whose behalf the operation will be performed.

{% endif %}

The examples below assume that the DB endpoint and full DB path are stored in the `$YDB_ENDPOINT` and `$YDB_DB_PATH` environment variables, respectively.

{% if audience != "external" %}

{% note info "Authentication" %}

Authentification in the YDB CLI is performed using the token from the __YDB_TOKEN__ environment variable or the `~/.ydb/token` file.

{% endnote %}

{% endif %}

## Limitations {#limitations}

In the current implementation, a maximum of 1000 tables can be backed up in YDB at a time.

## Backups to the file system {#filesystem_backup}

Saving the structure of the `backup` directory in the `$YDB_DB_PATH` database to the `my_backup_of_basic_example` directory in the file system.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools dump -p $YDB_DB_PATH/backup -o my_backup_of_basic_example/
```

For each directory in the database, a file system directory is created. For each table, a directory is created in the file system to place the structure description file in. Table data is saved to one or more `CSV` files, one file line per table row.

{% if audience != "external" %}

Before saving string data, it is converted to a urlencoded representation using the [CGIEscape](https://a.yandex-team.ru/arc/trunk/arcadia/util/string/quote.h?rev=5058568#L6-25) function.

{% endif %}

### Example of listing the contents of a directory with a backup

```
tree my_backup_of_basic_example/
my_backup_of_basic_example/
├── episodes
│   ├── data_00.csv
│   └── scheme.pb
├── seasons
│   ├── data_00.csv
│   └── scheme.pb
└── series
    ├── data_00.csv
    └── scheme.pb

3 directories, 6 files
```

The structure of each table is saved in a file named `scheme.pb`. For example, the `episodes/scheme.pb` file stores the schema of the `episodes` table. The data of each table is saved in one or more files named like `data_xx.csv`, where xx is the file's sequence number. The name of the first file is `data_00.csv`. The file size limit is 100 MB.

### Saving table schemas

Running the `{{ ydb-cli }} tools dump` command with the `--scheme-only` option only saves table schemas. The command below saves all directories and files with the table structure from the `examples` directory in the `$YDB_DB_PATH` database to the `my_backup_of_basic_example` directory. No files with table data are created.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools dump -p $YDB_DB_PATH/examples -o my_backup_of_basic_example/ --scheme-only
```

## Restoring data from backups in the file system {#filesystem_restore}

The command below creates directories and tables from the backup saved in the `my_backup_of_basic_example` directory and uploads data to them.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools restore  -p $YDB_DB_PATH/backup/restored -i my_backup_of_basic_example/
```

### Checking backups

The `{{ ydb-cli }} tools restore` command run with the `--dry-run` option checks if a backup contains all DB tables and if all table structures are the same.

The command below checks that all tables saved in the `my_backup_of_basic_example` directory exist in the `$YDB_DB_PATH` database and their structure (column contents and their order, column data types, and primary key contents) is identical.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools restore  -p $YDB_DB_PATH/restored_basic_example -i my_backup_of_basic_example/ --dry-run
```

## Backups to S3-compatible storage {#s3_backup}

YDB lets you save database backups to storage that supports the [Amazon Simple Storage Service (AWS S3) API](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html).

{% if audience != "external" %}

In this section, the target system is [MDS](https://wiki.yandex-team.ru/mds/), a data storage system provided by Yandex to enable access via an Amazon S3-compatible interface. To learn more about the MDS S3 API, see the [documentation](https://wiki.yandex-team.ru/mds/s3-api/).

{% endif %}

{% if audience == "external" %}

In this section, the target system is [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage).

{% endif %}

### Prerequisites {#s3_prerequisites}

{% if audience != "external" %}

To save a YDB database backup to MDS, you'll need:

* [A quota](https://wiki.yandex-team.ru/mds/s3-api/authorization/#registracijaservisa-klienta) in MDS.
* [A bucket](https://wiki.yandex-team.ru/mds/s3-api/s3-clients/#primery) created in MDS.
* [A user](https://wiki.yandex-team.ru/mds/s3-api/authorization/#vydachapravrobotuilisotrudniku) with permissions to write data to the bucket.

{% endif %}

{% if audience == "external" %}

To save a YDB database backup to [{{ objstorage-full-name }}](../../storage), you'll need an [existing](https://cloud.yandex.ru/docs/storage/concepts/bucket) bucket.

{% endif %}

### Creating access keys {#s3_create_access_keys}

Access keys are used for authentication and authorization in S3-compatible storage.

{% if audience != "external" %}

See the [MDS S3 API documentation](https://wiki.yandex-team.ru/mds/s3-api/authorization/#sozdanieaccesskey) for instructions on how to create and get access keys.

[The YDB console client](../getting_started/ydb_cli.md) provides three ways to pass access keys:

{% endif %}

{% if audience == "external" %}

[The YDB console client](../quickstart/examples-ydb-cli.md) provides three ways to pass access keys:

{% endif %}

* Through the `--access-key` and `--secret-key` command line options.
* Using the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.
* Through the `~/.aws/credentials` file created and used by the [AWS CLI](https://aws.amazon.com/ru/cli/).

The settings apply in the order described above. For example, if you use all three ways to pass the access_key or secret_key value at the same time, the values passed through the command-line options will be used.

### Running an operation to export data to S3 {#s3_export}

The commands given in the examples below are based on the assumption that access key data is saved to the `~/.aws/credentials` file.

Running the operation for exporting data from the `$YDB_DB_PATH/backup/episodes`, `$YDB_DB_PATH/backup/seasons`, and `$YDB_DB_PATH/backup/series` tables in the YDB `$YDB_DB_PATH` database to files prefixed with `20200601/` in the `testdbbackups` bucket in {{ objstorage-name }}.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH export s3 --s3-endpoint {{ s3-storage-host }}  --bucket testdbbackups\
--item source=$YDB_DB_PATH/backup/episodes,destination=20200601/episodes\
--item source=$YDB_DB_PATH/backup/seasons,destination=20200601/seasons\
--item source=$YDB_DB_PATH/backup/series,destination=20200601/series
```

Once the command is executed, the console client displays information about this operation's status.

{% if audience != "external" %}

```
┌───────────────────────────────────────────┬───────┬─────────┬───────────┬───────────────────┬───────────────┐
| id                                        | ready | status  | progress  | endpoint          | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────┼───────────────────┼───────────────┤
| ydb://export/6?id=846776181822113&kind=s3 | false | SUCCESS | Preparing | s3.mds.yandex.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                      |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                                   |
|     destination_prefix: 20200601/episodes                                                                   |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                                    |
|     destination_prefix: 20200601/seasons                                                                    |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                                     |
|     destination_prefix: 20200601/series                                                                     |
| Description:                                                                                                |
| Number of retries: 10                                                                                       |
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

{% endif %}

{% if audience == "external" %}

```
┌───────────────────────────────────────────┬───────┬─────────┬───────────┬─────────────────────────┬────────────────────┐
| id                                        | ready | status  | progress  | endpoint                | bucket             |
├───────────────────────────────────────────┼───────┼─────────┼───────────┼─────────────────────────┼────────────────────┤
| ydb://export/6?id=562950168911361&kind=s3 | false | SUCCESS | Preparing | storage.yandexcloud.net | testdbbackups      |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                                 |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/episodes                                |
|     destination_prefix: 20200601/episodes                                                                              |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/seasons                                 |
|     destination_prefix: 20200601/seasons                                                                               |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/series                                  |
|     destination_prefix: 20200601/series                                                                                |
| Description:                                                                                                           |
| Number of retries: 10                                                                                                  |
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

{% endif %}

As a result of the successfully completed export operation, `CSV` files containing the table data and schema with the prefixes listed below are saved to the `testdbbackups` bucket.

```
20200601/episodes
20200601/seasons
20200601/series
```

The file format is identical to that of the files created after the [backup to the file system](backup_and_recovery.md#filesystem_backup).

As a result of running the command below in the AWS CLI, a list of prefixes created after the backup in the `testdbbackup` bucket is displayed.

```
aws --endpoint-url=https://{{ s3-storage-host }} s3 ls testdbbackups/20200601/
                           PRE episodes/
                           PRE seasons/
                           PRE series/
```

{% note info "Working with directories" %}

To back up all tables in the YDB directory, specify the path to the directory as the source.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH export s3 \
--s3-endpoint {{ s3-storage-host }} \
--bucket testdbbackups \
--item source=$YDB_DB_PATH/backup,destination=20200601/
```

{% endnote %}

{% if audience != "external" %}

You can output the current status of the export operation that was started earlier using the command below.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation get 'ydb://export/6?id=846776181822113&kind=s3'
┌───────────────────────────────────────────┬───────┬─────────┬───────────────┬───────────────────┬───────────────┐
| id                                        | ready | status  | progress      | endpoint          | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────────┼───────────────────┼───────────────┤
| ydb://export/6?id=846776181822113&kind=s3 | false | SUCCESS | TransferData  | s3.mds.yandex.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                          |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                                       |
|     destination_prefix: 20200601/episodes                                                                       |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                                        |
|     destination_prefix: 20200601/seasons                                                                        |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                                         |
|     destination_prefix: 20200601/series                                                                         |
| Description:                                                                                                    |
| Number of retries: 10                                                                                           |
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

If the export operation is completed successfully, the progress column displays `Done`, the status column — `Success`, and the ready column — `true`.

```
┌───────────────────────────────────────────┬───────┬─────────┬──────────┬───────────────────┬───────────────┐
| id                                        | ready | status  | progress | endpoint          | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼──────────┼───────────────────┼───────────────┤
| ydb://export/6?id=846776181822113&kind=s3 | true  | SUCCESS | Done     | s3.mds.yandex.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                     |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                                  |
|     destination_prefix: 20200601/episodes                                                                  |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                                   |
|     destination_prefix: 20200601/seasons                                                                   |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                                    |
|     destination_prefix: 20200601/series                                                                    |
| Description:                                                                                               |
| Number of retries: 10                                                                                      |
└────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

{% endif %}

{% if audience == "external" %}

You can output the current status of the export operation that was started earlier using the command below.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation get 'ydb://export/6?id=562950168911361&kind=s3'
┌───────────────────────────────────────────┬───────┬─────────┬───────────────┬─────────────────────────┬───────────────┐
| id                                        | ready | status  | progress      | endpoint                | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────────┼─────────────────────────┼───────────────┤
| ydb://export/6?id=562950168911361&kind=s3 | false | SUCCESS | TransferData  | storage.yandexcloud.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                                |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/episodes                               |
|     destination_prefix: 20200601/episodes                                                                             |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/seasons                                |
|     destination_prefix: 20200601/seasons                                                                              |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/series                                 |
|     destination_prefix: 20200601/series                                                                               |
| Description:                                                                                                          |
| Number of retries: 10                                                                                                 |
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

If the export operation is completed successfully, the progress column displays `Done`, the status column — `Success`, and the ready column — `true`.

```
┌───────────────────────────────────────────┬───────┬─────────┬───────────────┬─────────────────────────┬───────────────┐
| id                                        | ready | status  | progress      | endpoint                | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────────┼─────────────────────────┼───────────────┤
| ydb://export/6?id=562950168911361&kind=s3 | true  | SUCCESS | Done          | storage.yandexcloud.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                                |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/episodes                               |
|     destination_prefix: 20200601/episodes                                                                             |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/seasons                                |
|     destination_prefix: 20200601/seasons                                                                              |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/series                                 |
|     destination_prefix: 20200601/series                                                                               |
| Description:                                                                                                          |
| Number of retries: 10                                                                                                 |
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

{% endif %}

### Restoring data from S3-compatible storage {#s3_restore}

First, connect the bucket with the YDB database backup files in S3-compatible storage to make the database available through operations on the file system.
{% if audience != "external" %}

You can connect your bucket using one of the [clients](https://wiki.yandex-team.ru/mds/s3-api/s3-clients/), such as s3fs.
{% endif %}

When done, upload the data from the backup in YDB following the instructions described in [Restoring data from backups in the file system](backup_and_recovery.md#filesystem_restore).

### Terminating the backup operation {#s3_forget}

To minimize the impact of the backup process on user load indicators, data is sent from table copies. Before sending data from YDB, the backup process creates consistent copies of all the tables being sent to YDB. As they're made using the copy-on-write technique, there is almost no change in the size of the DB at the time of their creation. Once the data is sent, the created copies remain in the DB.

To delete the table copies from the DB and the completed operation from the list of operations, run the command:

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation forget 'ydb://export/6?id=283824558378666&kind=s3'
```

{% if audience != "external" %}

## Backups to YT {#yt_backup}

### Prerequisites {#yt_preprequisites}

To save a YDB database backup to YT, you'll need an existing folder on one of the YT clusters.

{% note info "Authentication" %}

Authentification in the YT YDB CLI is based on the token from the __YT_TOKEN__ environment variable or the `~/.yt/token` file.

{% endnote %}

### Creating backups in YT {#yt_export}

The actions required to create a consistent copy of tables in the `backup` directory of the `/ru/tutorial/home/testdb` database are listed below.
As tables in [YT](https://yt.yandex-team.ru/docs/).

Starting an operation to export data from the `/ru/tutorial/home/testdb/backup/episodes`, `/ru/tutorial/home/testdb/backup/seasons`, and `/ru/tutorial/home/testdb/backup/series` tables in the `/ru/tutorial/home/testdb` YDB database on the `ydb-ru` cluster to the respective tables in YT on a [hahn](https://hahn.yt.yandex.net/) cluster.

```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb export yt --proxy hahn\
--item source=/ru/tutorial/home/testdb/backup/episodes,destination=//home/kikimr/backup_docs/episodes\
--item source=/ru/tutorial/home/testdb/backup/seasons,destination=//home/kikimr/backup_docs/seasons\
--item source=/ru/tutorial/home/testdb/backup/series,destination=//home/kikimr/backup_docs/series
```

Once the command is executed, the YDB CLI displays information about this operation's status.

```
┌───────────────────────────────────┬───────┬─────────┬───────────┬───────────────────────┐
| id                                | ready | status  | progress  | yt proxy              |
├───────────────────────────────────┼───────┼─────────┼───────────┼───────────────────────┤
| ydb://export/6?id=845646488977644 | false | SUCCESS | Preparing | hahn.yt.yandex.net:80 |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                  |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                               |
|     destination_path: <append=true>//home/kikimr/backup_docs/episodes                   |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                |
|     destination_path: <append=true>//home/kikimr/backup_docs/seasons                    |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                 |
|     destination_path: <append=true>//home/kikimr/backup_docs/series                     |
| Description:                                                                            |
| Number of retries: 5                                                                    |
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

{% note info "Working with directories" %}

To back up all tables in the YDB directory, specify the path to the directory as the source.

```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb export yt --proxy hahn --item source=/ru/tutorial/home/testdb/backup,destination=//home/kikimr/backup_docs/
```

{% endnote %}

You can output the current status of the export operation that was started earlier using the command below.

```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation get ydb://export/6?id=845646488977644
┌───────────────────────────────────┬───────┬─────────┬──────────────┬───────────────────────┐
| id                                | ready | status  | progress     | yt proxy              |
├───────────────────────────────────┼───────┼─────────┼──────────────┼───────────────────────┤
| ydb://export/6?id=845646488977644 | false | SUCCESS | TransferData | hahn.yt.yandex.net:80 |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                     |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                  |
|     destination_path: <append=true>//home/kikimr/backup_docs/episodes                      |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                   |
|     destination_path: <append=true>//home/kikimr/backup_docs/seasons                       |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                    |
|     destination_path: <append=true>//home/kikimr/backup_docs/series                        |
| Description:                                                                               |
| Number of retries: 5                                                                       |
└────────────────────────────────────────────────────────────────────────────────────────────┘
```

If the export operation is completed successfully, the progress column displays 'Done', the status column shows 'Success', and the ready column value is 'true'.

```
┌───────────────────────────────────┬───────┬─────────┬──────────┬───────────────────────┐
| id                                | ready | status  | progress | yt proxy              |
├───────────────────────────────────┼───────┼─────────┼──────────┼───────────────────────┤
| ydb://export/6?id=845646488977644 | true  | SUCCESS | Done     | hahn.yt.yandex.net:80 |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                 |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                              |
|     destination_path: <append=true>//home/kikimr/backup_docs/episodes                  |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                               |
|     destination_path: <append=true>//home/kikimr/backup_docs/seasons                   |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                |
|     destination_path: <append=true>//home/kikimr/backup_docs/series                    |
| Description:                                                                           |
| Number of retries: 5                                                                   |
└────────────────────────────────────────────────────────────────────────────────────────┘
```

### Terminating the backup operation in YT {#yt_forget}

To minimize the impact of the backup process on user load indicators, data is sent from table copies. Before sending data from YDB, the backup process creates consistent copies of all the tables being sent to YDB. As they're made using the copy-on-write technique, there is almost no change in the size of the DB at the time of their creation. Once the data is sent, the created copies remain in the DB.

To delete the table copies from the DB and the completed operation from the list of operations, run the command:

`ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation forget ydb://export/6?id=845646488977644`

### Common errors {#common_errors}

#### Using an inappropriate token to access YT

Authentication and authorization required to access the YT cluster when making backups is performed using the OAuth token from the __YT_TOKEN__ environment variable or the `~/.yt/token` file.

If using an invalid token or the token of a user with no access rights to YT tables or if no token is specified, the operation for exporting data from YDB to YT will start and YDB will try to send the data to YT for some time. After reaching the specified maximum number of send data attempts, the operation is canceled.

When you run the display operation status command, an error message is returned.

```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation get ydb://export/6?id=845646488977644

Status: CANCELLED
Issues:
<main>: Error: shard: 8142613, error: bad http reply status from proxy-broker
```

### Restoring data from backups in YT {#yt_restore}

To restore data from a backup saved in YT, use the [recipe](../best_practices/import_from_yt.md) for importing data from YT to YDB.

{% endif %}

