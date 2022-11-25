# Replication in {{ mpg-name }}

{{ mpg-name }} clusters use _quorum-based synchronous replication_:

1. A master host is selected from among cluster hosts, and the other hosts become replicas.
1. A _quorum_ is randomly established from replicas. A transaction is considered successful only if it is confirmed by the host master and all replica members of the quorum (_quorum_ replicas).

Replicas with a replication source set manually can't be a master host or participate in a quorum.

To establish a quorum, at least half of the cluster replicas must participate. If there's an odd number of replicas, the value is rounded down. For example, in a cluster with 17 replicas, 8 are needed for a quorum.

The quorum is established anew when the cluster topology changes: after [adding](../operations/hosts.md#add) and [deleting](../operations/hosts.md#remove) hosts, their failure, withdrawal for maintenance, return to service, etc. The host added to the cluster is first synchronized with the master host and only then can participate in the quorum.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

For more information about how replication works in {{ PG }}, read the [DBMS documentation](https://www.postgresql.org/docs/current/static/warm-standby.html).

## Managing replication {#replication}

Stream replication is used to ensure data safety in the cluster. Each replica host receives a replication thread from another host (usually the master host). {{ mpg-name }} manages replication threads in the cluster automatically, but you can [manage them manually](../operations/hosts.md#update) if you need to.

In a cluster, you can combine automatic and manual management of replication threads.

### Automatic management of replication threads {#replication-auto}

Once a {{ PG }} cluster with multiple hosts is created, it contains one master host and replicas. Replicas use the host master as the replication source.

Specifics of automatic replication in {{ mpg-name }}:

- If the master host fails, its replica becomes the new master.
- When the master changes, the replication source for all replica hosts automatically switches to the new master host.

For more information about selecting the master host, see [{#T}](#selecting-the-master).

### Manual management of replication threads {#replication-manual}

When you manually manage replication threads, other hosts in the cluster can be the replication source for a replica.

In this case, you can:

* Fully manage the replication process in the cluster without using automatic replication.
* Configure replication for {{ PG }} clusters with a complex topology. In this case, some of the replicas are managed automatically and the others manually.

For example, this way you can configure cascading replication when some of the cluster replicas use other hosts in the cluster as the source of the replication thread. In this case, the replication thread for such source hosts can be managed both automatically (with the {{ mpg-name }} tools) and manually.

Replicas that have the replication source set manually cannot:

* Become the master when the master host is changed automatically or manually (regardless of the [priority](#selecting-the-master) value).
* Automatically switch to a new replication source when the current replication source fails.
* Participate in quorum replication.

## Selecting a master host {#selecting-the-master}

To modify the process of selecting a master host in a {{ PG }} cluster, [set the appropriate priority values](../operations/hosts.md#update) for hosts in the cluster: the host with the highest priority set is selected as a master host, or, if there are several replicas with the same high priority in the cluster, an election is held among these replicas.

You can set the priority for the host in the cluster as follows:

* When [creating a cluster](../operations/cluster-create.md) via the CLI.
* When [changing the settings](../operations/hosts.md#update) of the host in the cluster.

The lowest priority is `0` (default), the highest is `100`.

## Write sync and read consistency {#write-sync-and-read-consistency}

Synchronization of data writes in {{ PG }} is ensured by syncing the [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) (the `synchronous_commit` [parameter](settings-list.md#setting-synchronous-commit)). The default parameter value is `synchronous_commit = on`. It indicates that a transaction is committed only if the WAL is written to both the master disk and quorum replica disk.

If you want to ensure ongoing consistency of data reads between the master and quorum replica, specify `synchronous_commit = remote_apply` [in the cluster settings](../operations/update.md#change-postgresql-config). With this parameter value, a data write is not considered successful until the quorum replica applies the changes from the WAL. In this case, the read operation performed on the master and on the synchronous quorum returns the same result.

However, there is a disadvantage: write operations to the cluster will take longer. If the master and the quorum replica are located in different availability zones, the latency of transaction confirmation can't be less than the round-trip time (RTT) between data centers. As a result, when writing data to a single thread with `AUTOCOMMIT` mode enabled, the cluster performance will degrade.

To enhance the performance, write data to multiple threads whenever possible, [disable `AUTOCOMMIT`](https://www.postgresql.org/docs/current/ecpg-sql-set-autocommit.html), and group queries within a transaction.
