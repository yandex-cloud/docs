# Replication

Data in {{ mpg-name }} clusters is replicated synchronously. A successful response to a write data request
is returned only when the data is written to the disk on both the master host and the priority replica. In the other cluster replicas, data is replicated asynchronously.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

For more information about how replication works in {{ PG }}, see the [DBMS documentation](https://www.postgresql.org/docs/current/static/warm-standby.html).

## Selecting the master and a synchronous replica {#selecting-the-master-and-a-synchronous-replica}

The master host and synchronous replica are selected by priority, which you can [set for a specific host](../operations/hosts.md#update).

In addition, you can configure cascading replication by explicitly assigning a source of replication for each host. The hosts with the set replication source cannot:

* Become synchronous replicas.
* Participate in the selection of a new master host.
* Automatically switch to a new source of replication.

## Write sync and read consistency {#write-sync-and-read-consistency}

By default, the master and replica are kept in sync by syncing the [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) (`synchronous_commit = on`). However, there's a delay between WAL delivery and applying it to the synchronous replica. During that delay, the synchronous replica may have data that's out-of-sync with the master.

If you want to ensure ongoing consistency of data reads between the master and synchronous replica, [specify, in the cluster settings](../operations/update.md#change-postgresql-config), the `synchronous_commit = remote_write` parameter. With this parameter value, a data write is not considered successful until the synchronous replica is ready to read the updated data. However, there is a disadvantage: write operations to the cluster will take longer.

For a detailed description of the `synchronous_commit` parameter, see the [{{ PG }} documentation]((https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT)).

