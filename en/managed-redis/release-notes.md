# {{ mrd-full-name }} revision history

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.06.2022 {#01.06.2022}

* {{ RD }} 5.0 and 6.0 are no longer supported. Clusters cannot be created in these versions. One month after the release of version 7.0, existing {{ RD }} 5.0 and 6.0 clusters will be automatically updated to version 6.2.
* Added the ability to change the `client-output-buffer-limit` normal and pubsub settings. For more information, see the description of the [redis.conf](https://raw.githubusercontent.com/redis/redis/unstable/redis.conf) configuration file. {{ tag-con }} {{ tag-cli }}

## 01.04.2022 {#01.04.2022}

* You can now create clusters with public access. You can enable or update this setting at the host level and only for clusters with TLS support. {{ tag-con }}
* You can now manage persistence settings. If persistence is disabled, a cluster's performance is higher but so is the risk of losing data. For more information, see [Persistence](concepts/replication#persistence). {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
