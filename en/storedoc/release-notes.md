---
title: '{{ mmg-full-name }} release notes'
description: This section contains the {{ mmg-name }} release notes.
---

# {{ mmg-full-name }} release notes

## December 2025 {#dec-2025}

* Added [detailed metrics](operations/monitoring.md#hosts) for disk usage on cluster hosts.
* Added execution details for [operations on the cluster](operations/cluster-list.md#list-operations).
* All new clusters are created with a [{{ connection-manager-name }} connection](../metadata-hub/concepts/connection-manager.md) by default.

## November 2025 {#nov-2025}

Added the `managed-mongodb.restorer` role for restoring clusters from backups. To learn more, see [Access management](security/index.md#managed-mongodb-restorer).

## October 2025 {#oct-2025}

* Added integration with {{ connection-manager-name }}. This tool allows you to connect to databases without directly using a password, thus reducing the risk of it being compromised.
* Added the ability to configure the maximum number of connections and other cluster settings via the [API](api-ref/grpc/Cluster/index.md).
* Simplified restoring the default setting values via the API: when updating settings, you can now provide an empty field without a value.
* In the management console, added a new cluster host health status when the cluster recovery from a backup is in progress.
* Added the ability to manually [set](https://mongodb.prakticum-team.ru/docs/manual/tutorial/modify-chunk-size-in-sharded-cluster/#std-label-tutorial-modifying-range-size) the chunk size for sharded clusters.
* Added the ability to manage data migration when adding or deleting a shard using the `rangeDeleterBatchSize`, `rangeDeleterBatchDelayMS`, and `migrateCloneInsertionBatchSize` settings.
* Added the SRV records improving stability of the host’s fully qualified domain name (FQDN). Now the following format is used for connections: `mongodb+srv://[username: password@]<cluster_ID>.{{ dns-zone }}[/[defaultauthdb][? options]]`.
* You can now view the full replica configuration information in the management console and the `{{ yc-mdb-mg }} host list` CLI command ouptut.
* Added new [host classes](concepts/instance-types.md) on AMD Zen 4 and AMD Zen 4 HighFreq platforms.

## July 2025 {#jul-2025}


* Now you can [encrypt storage disks](concepts/storage.md#disk-encryption) with a custom KMS key when creating a cluster and restoring it from a backup.
* Switched to the {{ SD }} DBMS compatible with the relevant {{ MG }} versions.


## April 2025 {#apr-2025}

* Added support for {{ MG }} 8.0. To learn how to update a cluster to the latest version, see [{#T}](operations/cluster-version-update.md).
* You can now [restore a cluster with enabled sharding from a backup](operations/cluster-backups.md#restore).


## March 2025 {#mar-2025}

You can now connect to a cluster database via [{{ websql-full-name }}](../websql/operations/create-connection.md).


## December 2024 {#dec-2024}

Starting December 2, 2024, you can no longer create {{ MG }} 5.0 clusters: the version was discontinued by the vendor.

## October 2024 {#oct-2024}

You can now [specify a retention period for your automatic backups](operations/cluster-backups.md#set-backup-retain).

## September 2024 {#sep-2024}

Added support for {{ MG }} version 7.0. To learn how to update a cluster to the latest version, see [{#T}](operations/cluster-version-update.md).

## February 2024 {#feb-2024}

The `flowControl`, `changeStreamOptions`, `net.compression.compressors`, and `storage.wiredTiger.indexConfig.prefixCompression` settings are now supported.

## Q1 2023 {#q1-2023}

You can now create a sharded cluster instead of first creating a non-sharded one and then splitting it into shards.

## Q4 2022 {#q4-2022}

* {{ MG }} 6.0 is now supported. To learn how to update a cluster to the latest version, see [{#T}](operations/cluster-version-update.md).
* Increased [maximum storage capacity](concepts/limits.md#mmg-limits) for cluster:
    * Based on network HDDs and SSDs: 1024 GB → 2048 GB
    * Based on non-replicated SSDs: 1024 GB → 2232 GB
    * Based on local SSDs: 1024 GB → 1500 GB

## Q3 2022 {#q3-2022}

Added access to the `oplog` collection for users with the `mdbReplication` role.

## Q2 2022 {#q2-2022}

* Updated existing {{ MG }} 4.0 clusters to version 4.2.
* Accelerated the process of changing storage size considering {{ ZK }} lock specifics.
* Detected an [issue](https://jira.mongodb.org/browse/SERVER-63201) when restoring a version 5.0 cluster from a backup. A fix is expected in the new {{ MG }} 5.0 releases.

## Q1 2022 {#q1-2022}

{{ MG }} 4.0 is no longer supported. Clusters cannot be created with this version. Existing {{ MG }} 4.0 clusters will be automatically updated to version 4.2.
