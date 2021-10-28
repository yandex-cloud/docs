---
title: "Yandex Database (YDB) backups"
description: "This section describes the supported methods for creating backups of Yandex Database (YDB) databases and restoring from previously created backups. YDB allows you to use csv files to create backups on the file system and AWS S3-compatible storages."
---

# Backups

This section describes supported methods for creating YDB database backups and restoring data from previously created backups. {{ ydb-short-name }} lets you use the following destinations to create backups:

* CSV files on the file system.
* AWS S3-compatible storage.

{% note warning "Effect of backups on performance" %}

Backups may negatively affect the database interaction indicators. Queries may take longer to execute. Before performing a database backup under load in production databases, test the process in the testing environment.

{% endnote %}

## Prerequisites


1. Install the [YDB console client](../quickstart/examples-ydb-cli.md).
1. In the DB properties, on the Overview tab, find and copy the **Endpoint** and **Database** field values.
1. Save the **Endpoint** and **Database** field values to the `$YDB_ENDPOINT` and `$YDB_DB_PATH` environment variables, respectively.

The examples below assume that the DB endpoint and full DB path are stored in the `$YDB_ENDPOINT` and `$YDB_DB_PATH` environment variables, respectively.


## Limitations {#limitations}

In the current implementation, a maximum of 1000 tables can be backed up in YDB at a time.

## Backups to the file system {#filesystem_backup}

Saving the structure of the `backup` directory in the `$YDB_DB_PATH` database to the `my_backup_of_basic_example` directory in the file system.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools dump -p $YDB_DB_PATH/backup -o my_backup_of_basic_example/
```

For each directory in the database, a file system directory is created. For each table, a directory is created in the file system to place the structure description file in. Table data is saved to one or more `CSV` files, one file line per table row.


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



In this section, the target system is [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage).

### Prerequisites {#s3_prerequisites}



To save a YDB database backup to [{{ objstorage-full-name }}](../../storage), you'll need an [existing](https://cloud.yandex.ru/docs/storage/concepts/bucket) bucket.

### Creating access keys {#s3_create_access_keys}

Access keys are used for authentication and authorization in S3-compatible storage.



[The YDB console client](../quickstart/examples-ydb-cli.md) provides three ways to pass access keys:

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

### Restoring data from S3-compatible storage {#s3_restore}

First, connect the bucket with the YDB database backup files in S3-compatible storage to make the database available through operations on the file system.

When done, upload the data from the backup in YDB following the instructions described in [Restoring data from backups in the file system](backup_and_recovery.md#filesystem_restore).

### Terminating the backup operation {#s3_forget}

To minimize the impact of the backup process on user load indicators, data is sent from table copies. Before sending data from YDB, the backup process creates consistent copies of all the tables being sent to YDB. As they're made using the copy-on-write technique, there is almost no change in the size of the DB at the time of their creation. Once the data is sent, the created copies remain in the DB.

To delete the table copies from the DB and the completed operation from the list of operations, run the command:

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation forget 'ydb://export/6?id=283824558378666&kind=s3'
```


