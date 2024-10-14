---
title: '{{ mrd-full-name }} release notes'
description: This section contains {{ mrd-name }} release notes.
---

# {{ mrd-full-name }} release notes

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## September 2024 {#sep-2024}

* A new {{ RD }} version is now available: 7.2. For more information about revisions, see the [{{ RD }}](https://raw.githubusercontent.com/redis/redis/7.2/00-RELEASENOTES) documentation.
* {{ RD }} 6.2 and 7.0 are no longer supported. Clusters cannot be created in these versions. One month after the release of version 7.2, existing {{ RD }} 6.2 and 7.0 clusters will be automatically updated to version 7.2.

## February 2024 {#feb-2024}

[Sharding](./concepts/sharding.md) can now be enabled on existing clusters. {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

## Q1 2023 {#q1-2023}

* The new {{ RD }} 7.0 version is now available. For more information about revisions, see the [{{ RD }} documentation](https://raw.githubusercontent.com/redis/redis/7.0/00-RELEASENOTES).
* Added the integration of the `rdsync` agent used to improve cluster [fault tolerance](concepts/replication.md#availability) with {{ RD }} 7.0.

## Q2 2022 {#q2-2022}

* {{ RD }} 5.0 and 6.0 are no longer supported. Clusters cannot be created in these versions. One month after the release of version 7.0, existing {{ RD }} 5.0 and 6.0 clusters will be automatically updated to version 6.2.
* In {{ TF }}, added the `replica_priority` and `assign_public_ip` settings. {{ tag-tf }}
* Corrected a bug making maintenance window management through {{ TF }} unavailable. {{ tag-tf }}
* Added the ability to change the `client-output-buffer-limit` normal and pubsub settings. For more information, see the description of the [redis.conf](https://raw.githubusercontent.com/redis/redis/unstable/redis.conf) configuration file. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

## Q1 2022 {#q1-2022}

* You can now create clusters with public access. You can enable or update this setting at the host level and only for clusters with TLS support. {{ tag-con }}
* You can now manage persistence settings. If persistence is disabled, a cluster's performance is higher but so is the risk of losing data. For more information, see the [Persistence](concepts/replication#persistence) section. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
