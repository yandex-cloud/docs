---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Replication

Data in {{ mpg-name }} clusters is replicated synchronously: the transaction is confirmed only when the data is written to the disk on both the master host and the synchronous replica (the highest priority host replica). In the other cluster replicas, data is replicated asynchronously.

Due to the specifics of the replication mechanism, there may be a small delay during which the synchronous replica may have the data that's out-of-sync with the master. For more information, see [Write sync and read consistency](#write-sync-and-read-consistency).

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

For more information about how replication works in {{ PG }}, see the [DBMS documentation](https://www.postgresql.org/docs/current/static/warm-standby.html).

## Managing replication {#replication}

Stream replication is used to ensure data safety in the cluster. Each replica host receives a replication thread from another host (as a rule, the master host). {{ mpg-name }} manages replication threads in the cluster automatically, but you can manage them manually if you need to control the replication process.

In a cluster, you can combine automatic and manual management of replication threads.

### Automatic management of replication threads {#replication-auto}

Once a {{ PG }} cluster with multiple hosts is created, it contains one master host and one synchronous replica. The other hosts, if any, are asynchronous replicas. All replicas use the host master as the replication source.

Features of automatic replication in {{ mpg-name }}:

- When the master host fails, its synchronous replica becomes the new master. The new synchronous replica is selected from asynchronous replicas.
- When a synchronous replica fails, one of the asynchronous replicas becomes a synchronous replica.
- When the master is changed, the replication source for all replica hosts automatically switches to the new master host. The master can be changed not only automatically as a result of a failure, but also manually.

For more information about selecting a synchronous replica, see [Selecting a synchronous replica](#selecting-the-master-and-a-synchronous-replica).

### Manual management of replication threads {#replication-manual}

When you manually manage replication threads, the replication source for any replica in the cluster can be other hosts in the cluster.

Assigning a replication source for the cluster hosts lets you:

- Fully manage the replication process in the cluster without using automatic replication.
- Configure replication for {{ PG }} clusters with a complex topology, in which some of the replicas are managed automatically and the others are managed manually.

For example, in this way you can configure cascading replication when some of the cluster replicas use other hosts in the cluster as the source of the replication thread. In this case, the replication thread for such source hosts can be managed both automatically with the {{ mpg-name }} tools and manually.

Replicas that have the replication source set manually and explicitly cannot:

- Become synchronous replicas and master when the master host is changed automatically or manually (regardless of the [priority](#selecting-the-master-and-a-synchronous-replica) value).
- Automatically switch to a new replication source when the current replication source fails.

## Selecting a synchronous replica {#selecting-the-master-and-a-synchronous-replica}

To modify the process of selecting a synchronous replica in the {{ PG }} cluster, [set the appropriate priority values](../operations/hosts.md#update) for hosts in the cluster: the host with the highest priority set is selected as a synchronous replica, or, if there are several replicas with the same high priority in the cluster, an election is held among these replicas.

If any asynchronous replica in the cluster changes its priority so that it becomes higher than the current synchronous replica, that replica becomes the new synchronous replica.

You can set the priority for the host in the cluster as follows:

- When [creating a cluster](../operations/cluster-create.md) via the CLI.
- When [changing settings](../operations/hosts.md#update) of the host in the cluster.

The lowest priority is `0` (default), the highest is `100`.

## Write sync and read consistency {#write-sync-and-read-consistency}

By default, the master and replica are kept in sync by syncing the [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) (the [parameter](settings-list.md#setting-synchronous-commit) `synchronous_commit = on`). However, there's a delay between WAL delivery and applying it to the synchronous replica. During that delay, the synchronous replica may have data that's out-of-sync with the master.

If you want to ensure ongoing consistency of data reads between the master and synchronous replica, [specify, in the cluster settings](../operations/update.md#change-postgresql-config), the `synchronous_commit = remote_apply` parameter. With this parameter value, a data write is not considered successful until the synchronous replica applies the changes from the delivered WAL. At this sync level, the read operation performed on the master and on the synchronous replica after confirming the transaction returns the same result.

The downside of this solution is that write operations to the cluster will take more time: if the master and the synchronous replica are located in different availability zones, the latency of transaction confirmation can't be less than the round-trip time (RTT) between data centers that are located in these availability zones. As a result, when writing to a single thread with `AUTOCOMMIT` mode enabled, the performance of such a cluster can significantly drop. To achieve maximum performance, we recommended that you write to multiple threads where possible, [disable AUTOCOMMIT](https://www.postgresql.org/docs/current/ecpg-sql-set-autocommit.html), and group requests into transactions.

