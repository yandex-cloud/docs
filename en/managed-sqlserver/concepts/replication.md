# Replication

In multi-host {{ mms-name }} **Enterprise Edition** cluster [versions](./index.md), High Availability Always On _availability groups_ are used to ensure fault tolerance.

In these clusters:

* The _primary replica_ (the `MASTER` role), which accepts all read and write queries, is automatically selected. The other replicas become _secondary_ (the `REPLICA` role).
* _Synchronous replication_ is used: a transaction is confirmed when the change log is written to storage both on the primary replica and all secondary replicas.
    All replicas use [synchronous-commit mode]({{ ms.docs }}/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server?view=sql-server-2016#availability-modes).
    If all replicas except the primary one become unavailable, replication doesn't work. When one of the secondary replicas becomes available, the replication process resumes.
* If the primary replica fails, [failover]({{ ms.docs }}/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server?view=sql-server-2016#types-of-failover) takes place in the cluster: the role of the primary replica is taken over by one of the secondary replicas.

## Readable and unreadable replicas {#readable-and-non-readable-replicas}

By default, when secondary replicas in {{ mms-name }} are created, they are unreadable: you can connect to the cluster only via the primary replica, which processes read and write requests. You can make secondary replicas readable when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md).

Readable replicas significantly reduce the load of read operations on the primary replica, but have certain usage specifics:

* An additional fee is charged for each readable replica because such replicas [require software licenses](../pricing/index.md#license).
* Between the primary and secondary replicas, [latency]({{ ms.docs }}/sql/database-engine/availability-groups/windows/active-secondaries-readable-secondary-replicas-always-on-availability-groups?view=sql-server-2016#data-latency) occurs. This is because applying changes from the change log on the secondary replica takes some time, during which the state of the database on the secondary replica differes from that on the primary replica. If it's important to maintain the consistency of the data being read, [connect](../operations/connect.md) to the cluster only via the primary replica.

For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/database-engine/availability-groups/windows/active-secondaries-readable-secondary-replicas-always-on-availability-groups?view=sql-server-2016#data-latency).

