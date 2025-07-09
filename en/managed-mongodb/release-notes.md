---
title: '{{ mmg-full-name }} release notes'
description: This section contains {{ mmg-name }} release notes.
---

# {{ mmg-full-name }} release notes

## April 2025 {#apr-2025}

* Added support for {{ MG }} 8.0. To learn how to update a cluster to the latest version, see [{#T}](operations/cluster-version-update.md).
* You can now [restore a cluster with enabled sharding from a backup](operations/cluster-backups.md#restore).


## March 2025 {#mar-2025}

You can now connect to a cluster database via [{{ websql-full-name }}](../websql/operations/create-connection.md).


## December 2024 {#dec-2024}

Creating {{ MG }} 5.0 clusters became unavailable starting December 2, 2024, as the version was [discontinued](https://www.mongodb.com/support-policy) by the vendor.

## October 2024 {#oct-2024}

Now you can [specify a retention period for your automatic backups](operations/cluster-backups.md#set-backup-retain).

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
