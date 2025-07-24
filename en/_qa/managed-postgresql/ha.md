#### How to exclude a host from the master selection? {#excluded-host}

You can exclude a host from the master selection when replacing the master host automatically or manually. To do this, set up [cascade replication](../../managed-postgresql/concepts/replication.md#replication-manual): [specify](../../managed-postgresql/operations/hosts.md#update) a replication source for the host you want to exclude.

{% note warning %}

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha) during maintenance, your cluster must have at least one replica host without a replication source.

{% endnote %}

#### Why do I get an error when setting up cascading replication? {#cascade-error}

Error message:

```text
cluster should have at least 2 HA hosts to use cascade host
```

The error occurs if you specify a replication source for a single non-cascading replica.

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha), your cluster must have at least one replica without a replication source. During maintenance or if the master host fails, this replica will take over as the master.

To learn more about replication, see [this guide](../../managed-postgresql/concepts/replication.md).

#### How do I always connect to the master host? {#connect-to-master-ha}

To connect to the current master host, use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns). It has this format: `c-<cluster_ID>.rw.{{ dns-zone }}`. When connected to this FQDN, you can perform read and write operations.

{% cut "Example of command for connection to a master" %}

  ```bash
  psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
        port={{ port-mpg }} \
        sslmode=verify-full \
        dbname=<DB_name> \
        user=<user_name>"
  ```

{% endcut %}

#### How do I always connect to the most recent replica? {#connect-to-replica-ha}

To connect to the most recent replica, use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns). It has this format: `c-<cluster_ID>.ro.{{ dns-zone }}`. When connected to this FQDN, you can perform only read operations. 

{% cut "Example of command for connection to a replica" %}

```bash
psql "host=c-<cluster_ID>.ro.{{ dns-zone }} \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<user_name>"
```

{% endcut %}

If there are no active replicas in the cluster, this FQDN will point to the current master host.

#### Why did the master and the replicas switch places? {#failover}

This means the master has [failed over](../../architecture/fault-tolerance.md#mdb-ha) to the replica host. Failover ensures cluster availability during maintenance or if the master fails.

Use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns) to always connect to the current master.

{% include [special-fqdns-warning](../../_includes/mdb/special-fqdns-warning.md) %}

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
