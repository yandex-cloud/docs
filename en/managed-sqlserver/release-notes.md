# {{ mms-full-name }} releases

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.08.2022 {#01.08.2022}

* {{ mms-full-name }} will no longer be provided: as of August 15, a restriction on creating new clusters is in place, and at 23:59 UTC+3 on August 31, 2022, existing clusters will be stopped. For more information, see the [{{ yandex-cloud }} announcement](https://cloud.yandex.ru/blog/posts/2022/07/microsoft-suspension).
* Published a [manual to help migrate data from {{ mms-name }} to a third-party {{ MS }} cluster](tutorials/outbound-migration.md).

## 01.07.2022 {#01.07.2022}

* Added the ability to create a fault-tolerant cluster configuration with two hosts (a minimum of three hosts required previously).
* Added the ability to edit the host public access setting using the CLI and API. {{ tag-cli }} {{ tag-api }}
* In {{ TF }}, added the `sqlcollation` setting. {{ tag-tf }}

## 01.05.2022 {#01.05.2022}

* Improved the backup mechanism: backing up a database no longer affects the backup of WAL-G logs.
* Added the ability to change a master host in the CLI manually using the `{{ yc-mdb-ms }} cluster start-failover` command. {{ tag-cli }}
* Added the ability to [export](operations/cluster-backups.md#objstorage-export) and [import](operations/cluster-backups.md#objstorage-import) a database backup in {{ objstorage-full-name }}. {{ tag-cli }} {{ tag-con }}
* Added the ability to change the public access setting for a host in the management console. {{ tag-con }}

## 01.04.2022 {#01.04.2022}

* Added the [msdb.dbo.mdb_readerrorlog](https://www.sqlshack.com/read-sql-server-error-logs-using-the-xp_readerrorlog-command/) wrapper procedure for reading the error log. The procedure can only be invoked by users with the `db_owner` role in at lest one database. {{ tag-sql }}
