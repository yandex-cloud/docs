# {{ mmg-full-name }} releases

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.12.2022 {#01.12.2022}

* Added support for {{ MG }} version 6.0.

## 01.08.2022 {#01.08.2022}

* Added access to the `oplog` collection for users with the `mdbReplication` role.

## 01.06.2022 {#01.06.2022}

* Updated existing {{ MG }} 4.0 clusters to version 4.2.

## 01.05.2022 {#01.05.2022}

* Accelerated the process of changing storage size considering {{ ZK }} lock specifics.
* Detected an [issue](https://jira.mongodb.org/browse/SERVER-63201) when restoring a version 5.0 cluster from a backup. A fix is expected in the new {{ MG }} 5.0 releases.

## 01.04.2022 {#01.04.2022}

* {{ MG }} 4.0 is no longer supported. Clusters cannot be created with this version. Existing {{ MG }} 4.0 clusters will be automatically updated to version 4.2.
