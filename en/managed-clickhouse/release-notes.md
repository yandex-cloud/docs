# {{ mch-full-name }} revision history

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.06.2022 {#01.06.2022}

* A new version is available: {{ CH }} 22.5 ([revision list](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md#225)).
* You can now grant users rights to system tables (`_system`).
* The [force_remove_data_recursively_on_drop](https://github.com/ClickHouse/ClickHouse/pull/30054) setting was enabled to prevent `Directory not empty` errors when deleting databases.

## 01.04.2022 {#01.04.2022}

* A new version is available: {{ CH }} 22.3 LTS ([revision list](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md)).
* Added the ability to restore a sharded cluster from a backup entirely. {{ tag-cli }} {{ tag-api }}
* Added the ability to change the settings that enable public access to a host. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
