#### How to exclude a host from the master selection? {#excluded-host}

You can exclude a host from the master selection when replacing the master host automatically or manually. To do this, set up [cascade replication](../../managed-postgresql/concepts/replication.md#replication-manual): [specify](../../managed-postgresql/operations/hosts.md#update) a replication source for the host you want to exclude.

{% note warning %}

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha) during maintenance, your cluster must have at least one replica host without a replication source.

{% endnote %}
