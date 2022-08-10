# {{ mms-full-name }} revision history

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.05.2022 {#01.05.2022}

* Improved the backup mechanism: backing up a database no longer affects the backup of WAL-G logs.
* Added the ability to change a master host in the CLI manually using the `{{ yc-mdb-ms }} cluster start-failover` command. {{ tag-cli }}
* Added the ability to [export](operations/cluster-backups.md#objstorage-export) and [import](operations/cluster-backups.md#objstorage-import) a database backup in {{ objstorage-full-name }}. {{ tag-cli }} {{ tag-con }}
* Added the ability to change the public access setting for a host in the management console. {{ tag-con }}

## 01.04.2022 {#01.04.2022}

* Added the [msdb.dbo.mdb_readerrorlog](https://www.sqlshack.com/read-sql-server-error-logs-using-the-xp_readerrorlog-command/) wrapper procedure for reading the error log. The procedure can only be invoked by users with the `db_owner` role in at lest one database. {{ tag-sql }}
