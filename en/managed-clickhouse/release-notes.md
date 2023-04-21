# {{ mch-full-name }} releases

This section covers the revision history for {{ mch-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## Q4 2022 {#q4-2022}

* New {{ CH }} versions are now available: [22.10](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-2210-2022-10-25) and [22.11](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-2211-2022-11-17).
* You can now create {{ ZK }} hosts with [non-replicated SSD storage](concepts/storage.md).
* You can now set up {{ ZK }} hosts when restoring a cluster from a backup.
* You can now set up hybrid storage when restoring a cluster from a backup. {{ tag-con }} {{ tag-api }}
* You can now run SQL queries from your browser using a [built-in SQL editor](./operations/connect.md#inline-editor).
* Added **Data parts**, **Databases**, **Inode usage**, **Rows of MergeTree tables**, and **Tables** charts on the [cluster monitoring](operations/monitoring.md#monitoring-cluster) page.
* The **Failed insert queries per host**, **Failed queries per host**, and **Failed select queries per host** charts now show the percentage of failed queries rather than their number.
* The **Max replication queue across tables** chart now shows the total replication queue of all tables and is called **Replication queue**.
* Renamed the following charts:
   * **CPU** → **CPU usage**.
   * **Disk bytes** → **Disk read/write bytes**.
   * **Memory** → **Memory usage**.
   * **Read parts per host** → **Read rows per host**.

## Q3 2022 {#q3-2022}

* Made the following parameters optional for the `{{ yc-mdb-ch }} cluster restore` command:

   * `--name`
   * `--description`
   * `--host`
   * `--user`

   Unless these parameters are explicitly given, their values will be taken from the source cluster. At the same time, {{ CH }} and {{ ZK }} hosts will have the same configuration as in the source cluster once restored. {{ CH }} hosts will only be restored for the shards whose backups are selected for restoration.

* Added the `data_cache_enabled`, `data_cache_max_size`, and `move_factor` settings for hybrid storage.

## Q2 2022 {#q2-2022}

* A new version is available: {{ CH }} 22.5 ([revision list](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-225-2022-05-19)).
* Added `SYSTEM UNFREEZE` query support. The query completely clears cluster storage of the cluster backup, including table data that may take up storage space after deletion. For more information, visit [GitHub](https://github.com/ClickHouse/ClickHouse/pull/36424).
* Reduced the time required to recover a cluster from a backup.
* Fixed the bug that caused pre-configured topic access passwords to be deleted when the {{ KF }} topic connection list was edited.
* You can now grant users rights to system tables (`_system`).
* Enabled the [force_remove_data_recursively_on_drop](https://github.com/ClickHouse/ClickHouse/pull/30054) setting to prevent `Directory not empty` errors when deleting databases.

## Q1 2022 {#q1-2022}

* A new version is available: {{ CH }} 22.3 LTS ([revision list](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md)).
* Added the ability to restore a sharded cluster from a backup entirely. {{ tag-cli }} {{ tag-api }}
* Added the ability to change the settings that enable public access to a host. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
