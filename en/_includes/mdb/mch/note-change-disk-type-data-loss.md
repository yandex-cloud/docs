{% note warning %}

When you change the disk type, the cluster hosts get recreated. The system automatically saves the replicated tables data. The non-replicated tables data will be lost. Before changing the disk type, either [convert](../../../managed-clickhouse/operations/zk-hosts.md#replicated-tables) non-replicated tables to replicated ones or [create a backup](../../../managed-clickhouse/operations/cluster-backups.md).

{% endnote %}
