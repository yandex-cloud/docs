# {{ mrd-full-name }} release notes

This section contains {{ mrd-name }} release notes.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## February 2024 {#feb-2024}

* Now you can enable [sharding](./concepts/sharding.md) on the existing clusters. {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

## Q1 2023 {#q1-2023}

* A new version is available: {{ RD }} 7.0. For more information about revisions, see the [{{ RD }} documentation](https://raw.githubusercontent.com/redis/redis/7.0/00-RELEASENOTES).
* Added the integration of the `rdsync` agent that enhances cluster [fault tolerance](concepts/replication.md#availability) beginning from {{ RD }} 7.0.

## Q2 2022 {#q2-2022}

* {{ RD }} 5.0 and 6.0 are no longer supported. Clusters cannot be created in these versions. One month after the release of version 7.0, existing {{ RD }} 5.0 and 6.0 clusters will be automatically updated to version 6.2.
* In {{ TF }}, added the `replica_priority` and the `assign_public_ip` settings. {{ tag-tf }}
* Corrected a bug making maintenance window management through {{ TF }} unavailable. {{ tag-tf }}
* Added the ability to change the `client-output-buffer-limit` normal and pubsub settings. For more information, see the description of the [redis.conf](https://raw.githubusercontent.com/redis/redis/unstable/redis.conf) configuration file. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

## Q1 2022 {#q1-2022}

* You can now create clusters with public access. You can enable or update this setting at the host level and only for clusters with TLS support. {{ tag-con }}
* You can now manage persistence settings. If persistence is disabled, a cluster's performance is higher but so is the risk of losing data. For more information, see [Persistence](concepts/replication#persistence). {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
