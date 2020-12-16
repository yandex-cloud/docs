{% note info %}

  Hybrid storage is at the [Preview](https://cloud.yandex.com/docs/overview/concepts/launch-stages) stage. A fee for using [{{ objstorage-name }}](../../storage) storage is not applied.

  At the Preview stage, you can only use this type of storage in clusters with [fault tolerance disabled](../../managed-clickhouse/operations/zk-hosts.md). {{ ZK }} hosts can't be added to such a cluster, and you can only add one host in each {{ CH }} shard. This restriction will be removed at the General Availability stage.

  {% endnote %}

