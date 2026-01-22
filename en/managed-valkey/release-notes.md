---
title: '{{ mrd-full-name }} release notes'
description: This section contains {{ mrd-name }} release notes.
---

# {{ mrd-full-name }} release notes

## November 2025 {#nov-2025}

Added the `managed-redis.restorer` role, which allows restoring clusters from backups. To learn more, see [Access management](security/index.md#managed-redis-restorer).

## October 2025 {#oct-2025}

* A new version is out: {{ VLK }} 9.0. For more information about the updates, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/releases/tag/9.0.0).
* Added support for:
    * Valkey-Search: Vector and full-text search.
    * Valkey-JSON: Native work with JSON documents.
    * Valkey-Bloom: Probabilistic data structures.
* When [creating](operations/user-create.md) a {{ VLK }} user, you can now immediately specify their permissions. Do it with the help of an [ACL](https://valkey.io/topics/acl/) (Access Control List) which controls the user's permissions to run particular commands.
* Added integration with {{ connection-manager-name }}. This tool allows you to connect to the cluster without directly using a password, thus reducing the risk of it being compromised.
* Added the ability to restore a sharded cluster from a backup.
* Added new [host classes](concepts/instance-types.md) on AMD Zen 4 and AMD Zen 4 HighFreq platforms.

## July 2025 {#jul-2025}


* Now you can [encrypt storage disks](concepts/storage.md#disk-encryption) with a custom KMS key when creating a cluster and restoring it from a backup.
* Added support for persistence [on replicas only](concepts/replication.md#persistence-on-replicas).


## May 2025 {#may-2025}

A new version is out: {{ VLK }} 8.1. For more information about the updates, see [this {{ VLK }} article](https://github.com/valkey-io/valkey/releases).

## April 2025 {#apr-2025}

A new version is out: {{ VLK }} 8.0. For more information about the updates, see [this {{ VLK }} article](https://github.com/valkey-io/valkey/releases).

## December 2024 {#dec-2024}

The service migrated to [{{ VLK }}](https://valkey.io/) DBMS, an open-source fork of Redis.

## September 2024 {#sep-2024}

* A new Redis version is out: 7.2. For more information about the updates, see [this Redis article](https://raw.githubusercontent.com/redis/redis/7.2/00-RELEASENOTES).
* Redis 6.2 and 7.0 are no longer supported. Creating clusters of these versions is no longer available. One month after the release of Redis 7.2, existing Redis 6.2 and Redis 7.0 clusters were automatically upgraded to Redis 7.2.

## February 2024 {#feb-2024}

[Sharding](./concepts/sharding.md) can now be enabled on existing clusters.

## Q1 2023 {#q1-2023}

* A new version is out: Redis 7.0. For more information about the updates, see [this Redis article](https://raw.githubusercontent.com/redis/redis/7.0/00-RELEASENOTES).
* Added the `rdsync` integration for improved [fault tolerance](concepts/replication.md#availability) of Redis 7.0 clusters.

## Q2 2022 {#q2-2022}

* Redis 5.0 and 6.0 are no longer supported. Creating clusters of these versions is no longer available. One month after the release of Redis 7.0, existing Redis 5.0 and Redis 6.0 clusters were automatically upgraded to Redis 6.2.
* In {{ TF }}, added the `replica_priority` and `assign_public_ip` settings.
* Fixed the error where you could not use {{ TF }} to manage the maintenance window.
* You can now change the `client-output-buffer-limit` normal and pub/sub settings. For more information, see the [redis.conf](https://raw.githubusercontent.com/redis/redis/unstable/redis.conf) file description.

## Q1 2022 {#q1-2022}

* You can now create clusters with public access. You can enable or update this setting at the host level and only for clusters with TLS support.
* You can now manage persistence settings. Disabling persistence improves cluster performance but increases the risk of data loss. For more information, see [Persistence](concepts/replication#persistence).
