# {{ mms-full-name }} releases

This section covers the revision history for {{ mms-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## Q3 2022 {#q3-2022}

* {{ mms-full-name }} will no longer be provided: as of August 15, a restriction on creating new clusters is in place, and at 23:59 UTC+3 on August 31, 2022, existing clusters will be stopped. For more information, see the [{{ yandex-cloud }} announcement](https://cloud.yandex.ru/blog/posts/2022/07/microsoft-suspension).
* Published a [manual to help migrate data from {{ mms-name }} to a third-party {{ MS }} cluster](tutorials/outbound-migration.md).

## Q2 2022 {#q2-2022}

* Added the ability to create a fault-tolerant cluster configuration with two hosts (a minimum of three hosts required previously).
* Added the ability to change the settings that enable public access to a host. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
* In {{ TF }}, added the `sqlcollation` setting. {{ tag-tf }}
* Improved the backup mechanism: backing up a database no longer affects the backup of WAL-G logs.
* Added the ability to change a master host in the CLI manually using the `{{ yc-mdb-ms }} cluster start-failover` command. {{ tag-cli }}
* Added the ability to [export](operations/cluster-backups.md#objstorage-export) and [import](operations/cluster-backups.md#objstorage-import) a database backup in {{ objstorage-full-name }}. {{ tag-cli }} {{ tag-con }}

## Q1 2022 {#q1-2022}

* Added the [msdb.dbo.mdb_readerrorlog](https://www.sqlshack.com/read-sql-server-error-logs-using-the-xp_readerrorlog-command/) wrapper procedure for reading the error log. The procedure can only be invoked by users with the `db_owner` role in at lest one database. {{ tag-sql }}
