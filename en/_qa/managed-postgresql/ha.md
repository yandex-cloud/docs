#### How to exclude a host from the master selection? {#excluded-host}

You can exclude a host from the master selection when replacing the master host automatically or manually. To do this, set up [cascade replication](../../managed-postgresql/concepts/replication.md#replication-manual): [specify](../../managed-postgresql/operations/hosts.md#update) a replication source for the host you want to exclude.

{% note warning %}

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha) during maintenance, your cluster must have at least one replica host without a replication source.

{% endnote %}

#### Can I configure multimaster in a cluster or between two clusters? {#setting-multimaster}

No, {{ mpg-name }} does not support multimaster configuration.

For more information on how to ensure high availability of a cluster, see [{#T}](../../architecture/fault-tolerance.md#mdb-ha).

#### How do I configure load balancing so that read requests only go to replicas? {#balancing-replicas}

As {{ mpg-name }} does not perform any load balancing, you need to configure it in your application backend. To send read requests to replicas, the application must independently recognize master and replica hosts, e.g., using `libpq`. For more information, see [this {{ PG }} article](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNECT-TARGET-SESSION-ATTRS).

Alternatively, use a [special FQDN](../../managed-postgresql/operations/connect.md#fqdn-replica) that points to the most recent replica.

For more information, see [High availability](../../managed-postgresql/concepts/high-availability.md).

#### Why does the master fail over to a randomly selected host when autofailover is off? {#auto-failover-master}

Even with autofailover disabled, the master host may switch to another host during [maintenance](../../managed-postgresql/concepts/maintenance.md) or [cluster updates](../../managed-postgresql/operations/update.md). This helps keep the cluster working correctly during these operations.

{% note info %}

To ensure [high availability](../../managed-postgresql/concepts/high-availability.md), the cluster always has at least one replica without an explicitly defined [replication source](../../managed-postgresql/concepts/replication.md#replication-manual). This replica can take over as master when needed.

{% endnote %}

#### Why does the cluster switch masters after recovery, even though autofailover is disabled? {#auto-failover-restore}

Even with autofailover disabled, the master host may switch to another host after recovery. This helps keep the cluster working correctly under such conditions. For more information, see [{#T}](../../managed-postgresql/concepts/high-availability.md).

#### Why does the master fails over automatically during maintenance operations, even though autofailover is off? {#auto-failover-maintenance}

Even with autofailover disabled, the master host may switch to another host to allow [maintenance](../../managed-postgresql/concepts/high-availability.md#maintenance-settings).
