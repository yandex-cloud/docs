# {{ mch-full-name }} releases

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.08.2022 {#01.08.2022}

* Made the following parameters optional for the `{{ yc-mdb-ch }} cluster restore` command:

   * `--name`
   * `--description`
   * `--host`
   * `--user`

   Unless these parameters are explicitly given, their values will be taken from the source cluster. At the same time, {{ CH }} and {{ ZK }} hosts will have the same configuration as in the source cluster once restored. {{ CH }} hosts will only be restored for the shards whose backups are selected for restoration.

* Added the `data_cache_enabled`, `data_cache_max_size`, and `move_factor` settings for hybrid storage.

## 01.07.2022 {#01.07.2022}

* Added `SYSTEM UNFREEZE` query support. The query completely clears cluster storage of the cluster backup, including table data that may take up storage space after deletion. For more information, visit [GitHub](https://github.com/ClickHouse/ClickHouse/pull/36424).
* Reduced the time required to recover a cluster from a backup.
* Corrected a bug that caused pre-configured topic access passwords to be deleted when the {{ KF }} topic connection list was edited.

## 01.06.2022 {#01.06.2022}

* A new version is available: {{ CH }} 22.5 ([revision list](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md#225)).
* You can now grant users rights to system tables (`_system`).
* Enabled the [force_remove_data_recursively_on_drop](https://github.com/ClickHouse/ClickHouse/pull/30054) setting to prevent `Directory not empty` errors when deleting databases.

## 01.04.2022 {#01.04.2022}

* A new version is available: {{ CH }} 22.3 LTS ([revision list](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md)).
* Added the ability to restore a sharded cluster from a backup entirely. {{ tag-cli }} {{ tag-api }}
* Added the ability to change the settings that enable public access to a host. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
