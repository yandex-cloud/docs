---
title: '{{ mmg-full-name }} release notes'
description: This section contains the {{ mmg-name }} release notes.
---

# {{ mmg-full-name }} release notes

## March 2026 {#mar-2026}

* Added the `--redactClientLogData` option to mask client request data before it is written to logs. This option hides the content of messages associated with events but keeps technical metadata (error codes, line numbers, file names).
* If a {{ SD }} replica is far behind, the service can now use [backup](./concepts/backup.md) recovery tools to update its data faster and without placing additional load on the master host.
* Added separate [roles](./security/index.md) to view and edit (reschedule) [maintenance](./concepts/maintenance.md) without access to the cluster.

## January 2026 {#jan-2026}

* Added the **{{ ui-key.yacloud.mdb.cluster.switch_shards }}** tab to **{{ ui-key.yacloud.mdb.cluster.monitoring.label_title }}**. From this tab, you can track metrics for each individual shard and promptly detect problematic nodes.
* Added the option of partial {{ SD }} cluster recovery from a backup. You can restore specific databases or collections by adding them to include or exclude lists.
  
## December 2025 {#dec-2025}

* Added [detailed metrics](operations/monitoring.md#hosts) for disk usage on cluster hosts.
* Added execution details for [operations on the cluster](operations/cluster-list.md#list-operations).
* All new clusters are created with a [{{ connection-manager-name }} connection](../metadata-hub/concepts/connection-manager.md) by default.

## November 2025 {#nov-2025}

Added the `managed-mongodb.restorer` role for restoring clusters from backups. To learn more, see [Access management](security/index.md#managed-mongodb-restorer).

## October 2025 {#oct-2025}

* Added integration with {{ connection-manager-name }}. This tool allows you to connect to databases without exposing your password, reducing the risk of it being compromised.
* Added support for configuring the maximum number of connections and other cluster settings via [API](api-ref/grpc/Cluster/index.md).
* Simplified resetting values to defaults via API: now you can update settings by passing just the field name, without specifying a value.
* Added a new status in the management console for cluster hosts being restored from a backup.
* Added support for manually [configuring](https://mongodb.prakticum-team.ru/docs/manual/tutorial/modify-chunk-size-in-sharded-cluster/#std-label-tutorial-modifying-range-size) the chunk size in sharded clusters.
* Added support for managing data migration during shard addition or removal via `rangeDeleterBatchSize`, `rangeDeleterBatchDelayMS`, and `migrateCloneInsertionBatchSize` settings.
* Added SRV records for improved host FQDN stability. Connections now use the following format: `mongodb+srv://[username: password@]<cluster_ID>.{{ dns-zone }}[/[defaultauthdb][? options]]`.
* Complete replica configuration details are now displayed in the management console and in the `{{ yc-mdb-mg }} host list` CLI command output.
* Added new [host classes](concepts/instance-types.md) on AMD Zen 4 and AMD Zen 4 HighFreq platforms.

## July 2025 {#jul-2025}


* Added support for [encrypting storage disks](concepts/storage.md#disk-encryption) with a custom KMS key during cluster creation or when restoring it from a backup.
* Switched to the {{ SD }} DBMS compatible with the relevant {{ MG }} versions.


## April 2025 {#apr-2025}

* Added support for {{ MG }} 8.0. To learn how to update your cluster to the latest version, see [{#T}](operations/cluster-version-update.md).
* Added support for [restoring sharded clusters from backups](operations/cluster-backups.md#restore).


## March 2025 {#mar-2025}

Added support for connecting to a cluster database via [{{ websql-full-name }}](../websql/operations/create-connection.md).


## December 2024 {#dec-2024}

Starting December 2, 2024, you can no longer create clusters with {{ MG }} version 5.0, as support for this version was discontinued by the vendor.

## October 2024 {#oct-2024}

Added support for [setting a retention period for automatic backups](operations/cluster-backups.md#set-backup-retain).

## September 2024 {#sep-2024}

Added support for {{ MG }} version 7.0. To learn how to update your cluster to the latest version, see [{#T}](operations/cluster-version-update.md).

## February 2024 {#feb-2024}

Added support for the `flowControl`, `changeStreamOptions`, `net.compression.compressors`, and `storage.wiredTiger.indexConfig.prefixCompression` settings.

## Q1 2023 {#q1-2023}

Added support for creating sharded clusters directly, without having to create an unsharded cluster first and then shard it.

## Q4 2022 {#q4-2022}

* Added support for {{ MG }} version 6.0. To learn how to update a cluster to the latest version, see [{#T}](operations/cluster-version-update.md).
* Increased the [maximum storage capacity](concepts/limits.md#mmg-limits) for clusters:
    * Based on network HDDs and SSDs: 1024 GB → 2048 GB
    * Based on non-replicated SSDs: 1024 GB → 2232 GB
    * Based on local SSDs: 1024 GB → 1500 GB

## Q3 2022 {#q3-2022}

Added access to the `oplog` collection for users with the `mdbReplication` role.

## Q2 2022 {#q2-2022}

* Existing {{ MG }} 4.0 clusters have been upgraded to version 4.2.
* The storage resizing process has been accelerated by accounting for {{ ZK }} lock specifics.
* Identified an [issue](https://jira.mongodb.org/browse/SERVER-63201) when restoring a version 5.0 cluster from a backup. A fix is expected in future {{ MG }} 5.0 releases.

## Q1 2022 {#q1-2022}

Support for {{ MG }} version 4.0 has ended. You can no longer create clusters with this version. Existing {{ MG }} 4.0 clusters will be automatically upgraded to version 4.2.
