# Replication

{{ mmy-name }} clusters use [semi-sync replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html): by default, the master waits for a transaction to complete in at least one replica. The difference between {{ mmy-name }} semi-sync replication and standard replication is that if all semi-sync replicas are down, the cluster doesn't switch to asynchronous replication. Instead, it disables replication altogether until at least one replica is available.

If the replica and the master are located in different availability zones, with semi-sync replication, the latency of transaction confirmation can't be less than the round-trip time (RTT) between data centers that are located in these availability zones. As a result, when writing to a single thread with [AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit) mode enabled, the performance of this kind of cluster can significantly drop. To achieve maximum performance, we recommend that you write to multiple threads wherever possible, [disable AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/commit.html), and group requests into transactions.

Replication in {{ mmy-name }} uses global transaction identifiers ([GTID](https://dev.mysql.com/doc/refman/5.7/en/replication-gtids-concepts.html)), too. They help maintain data consistency across cluster hosts.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}


## Specifics of replication in {{ mmy-name }} {#features}

If a cluster is single-host or if all replicas, except for the master, are completely unavailable (the status of the hosts is `DEAD`), replication doesn't work. As soon as a replica appears or becomes available in the cluster, semi-sync replication is performed in stages:

1. When a replica becomes available, asynchronous replication is immediately enabled from the master. The master remains fully available for reads and writes and replica lag is gradually reduced.
1. As soon as the lag is less than 100 MB, synchronous replication is enabled. The master becomes unavailable for writes until the data is fully synced with the replica: this process can take from one to tens of seconds depending on network performance.
1. Once data on the master and replica is fully synced, the hosts are made fully available again and replicated synchronously.

### Manual management of replication threads {#manual-source}

When you manually manage replication threads, other hosts in the cluster can be the replication source for any replica in the cluster.

For replicas that have the replication source set manually and explicitly, fully asynchronous replication from the source host is used. These replicas may not become a master when the master host is changed automatically or manually.

Assigning a replication source for the cluster hosts lets you:

- Fully manage the replication process in the cluster without using automatic replication.
- Configure replication for a {{ MY }} cluster with a tree topology, in which some replicas are managed automatically using {{ mmy-name }} tools and others manually. This will reduce the load on the master host's network.
- Allocate some replicas for analytical load, since they won't become a master under any condition.

### Assigning a different master host if the primary master fails {#master-failover}

If the master host fails, any of the cluster hosts available for replication becomes a new master. If the master assignment priority is set for the cluster hosts, the host with the highest priority is selected as a new master.
