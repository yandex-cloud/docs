#### How to remove a host from the master selection process? {#excluded-host}

You can exclude a host from the master selection when replacing the master host automatically or manually. To do this, set up [cascade replication](../../managed-postgresql/concepts/replication.md#replication-manual): [specify](../../managed-postgresql/operations/hosts.md#update) a replication source for the host you want to exclude.

{% note warning %}

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha) during maintenance, your cluster must have at least one replica without a replication source.

{% endnote %}

#### Why do I get an error when setting up cascading replication? {#cascade-error}

Error message:

```text
cluster should have at least 2 HA hosts to use cascade host
```

This error occurs if you specify a replication source for the only non-cascading replica.

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha), your cluster must have at least one replica without a replication source. This replica will be promoted to master if the master host fails during maintenance.

To learn more about replication, see [this article](../../managed-postgresql/concepts/replication.md).

#### How to ensure I am always connecting to the master host? {#connect-to-master-ha}

To connect to the current master host, use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns) in the `c-<cluster_ID>.rw.{{ dns-zone }}` format. This FQDN supports read and write access.

{% cut "Example command for connecting to the master host" %}

  ```bash
  psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
        port={{ port-mpg }} \
        sslmode=verify-full \
        dbname=<DB_name> \
        user=<username>"
  ```

{% endcut %}

#### How to ensure I am always connecting to the most up-to-date replica? {#connect-to-replica-ha}

To connect to the most up-to-date replica, use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns) in the `c-<cluster_ID>.ro.{{ dns-zone }}` format. This FQDN only supports read access. 

{% cut "Example command for connecting to a replica" %}

```bash
psql "host=c-<cluster_ID>.ro.{{ dns-zone }} \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username>"
```

{% endcut %}

If there are no active replicas in the cluster, this FQDN will point to the current master host.

#### Why did the master and replicas swap roles? {#failover}

This means the master has [failed over](../../architecture/fault-tolerance.md#mdb-ha) to the replica. Automatic master failover guarantees cluster availability during maintenance or in the event of the master host failure.

To connect to the current master host, use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns).

{% include [special-fqdns-warning](../../_includes/mdb/special-fqdns-warning.md) %}

#### Can I configure multi-master within a single cluster or between two clusters? {#setting-multimaster}

No, {{ mpg-name }} does not support multi-master configuration.

For more details on high availability cluster configuration, see [{#T}](../../architecture/fault-tolerance.md#mdb-ha).

#### How to configure load balancing so that all read requests are redirected to replicas? {#balancing-replicas}

As {{ mpg-name }} does not provide load balancing, you need to configure it in your application backend. To send read requests to replicas, your application must first identify the master and replica hosts, e.g., by using `libpq`. For more information, see [this {{ PG }} article](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNECT-TARGET-SESSION-ATTRS).

Alternatively, use a [special FQDN](../../managed-postgresql/operations/connect.md#fqdn-replica) pointing to the most up-to-date replica.

For more information, see [High availability](../../managed-postgresql/concepts/high-availability.md).

#### When does automatic failover occur? {#auto-failover}

The master host can automatically fail over to another host:

* During [cluster updates](../../managed-postgresql/operations/update.md).
* On master host failure.
* Upon cluster recovery.
* During [maintenance](../../managed-postgresql/concepts/high-availability.md#maintenance-settings).

Master failover ensures the cluster works correctly under the listed conditions.

{% note info %}

To ensure [high availability](../../managed-postgresql/concepts/high-availability.md), the cluster always has at least one replica without an explicitly defined [replication source](../../managed-postgresql/concepts/replication.md#replication-manual). This replica can take over as master when needed.

{% endnote %}
