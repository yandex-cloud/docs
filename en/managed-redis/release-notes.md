---
title: '{{ mrd-full-name }} release notes'
description: This section contains {{ mrd-name }} release notes.
---

# {{ mrd-full-name }} release notes

## May 2025 {#may-2025}

A new version is out: {{ VLK }} 8.1. For more information about revisions, see the [{{ VLK }}](https://github.com/valkey-io/valkey/releases) documentation.

## April 2025 {#apr-2025}

A new version is out: {{ VLK }} 8.0. For more information about revisions, see the [{{ VLK }}](https://github.com/valkey-io/valkey/releases) documentation.

## December 2024 {#dec-2024}

The service switched to [{{ VLK }}](https://valkey.io/) DBMS, an open source Redis project branch.

## September 2024 {#sep-2024}

* A new Redis version is out: 7.2. For more information about revisions, see the [Redis documentation](https://raw.githubusercontent.com/redis/redis/7.2/00-RELEASENOTES).
* Redis versions 6.2 and 7.0 are no longer supported. Clusters cannot be created in these versions. One month after the release of version 7.2, existing Redis 6.2 and 7.0 clusters were automatically upgraded to version 7.2.

## February 2024 {#feb-2024}

[Sharding](./concepts/sharding.md) can now be enabled on existing clusters.

## Q1 2023 {#q1-2023}

* A new Redis version is out: 7.0. For more information about revisions, see the [Redis documentation](https://raw.githubusercontent.com/redis/redis/7.0/00-RELEASENOTES).
* Added the integration of the `rdsync` agent providing improved [fault tolerance](concepts/replication.md#availability) for clusters with Redis version 7.0.

## Q2 2022 {#q2-2022}

* Redis versions 5.0 and 6.0 are no longer supported. Clusters cannot be created in these versions. One month after the release of version 7.0, existing Redis 5.0 and 6.0 clusters were automatically upgraded to version 6.2.
* In {{ TF }}, added the `replica_priority` and `assign_public_ip` settings.
* Fixed the error where you could not use {{ TF }} to manage the maintenance window.
* Added the ability to change the `client-output-buffer-limit` normal and pubsub settings. For more information, see the description of the [redis.conf](https://raw.githubusercontent.com/redis/redis/unstable/redis.conf) configuration file.

## Q1 2022 {#q1-2022}

* You can now create clusters with public access. You can enable or update this setting at the host level and only for clusters with TLS support.
* You can now manage persistence settings. If persistence is disabled, a cluster's performance is higher but so is the risk of losing data. For more information, see the [Persistence](concepts/replication#persistence) section.
