---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Replication

{{ mmy-name }} clusters use [semi-sync replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html): by default, the master waits for a transaction to complete in at least one replica. The difference between {{mmy-name}} semi-sync replication and standard replication is that if all semi-sync replicas are down, the cluster doesn't switch to asynchronous replication. Instead, it disables replication altogether until at least one replica is available.

If the replica and the master are located in different availability zones, with semi-sync replication, the latency of transaction confirmation can't be less than the round-trip time (RTT) between data centers that are located in these availability zones. As a result, when writing to a single thread with [AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit) mode enabled, the performance of such a cluster can significantly drop. To achieve maximum performance, it's recommended that you write to multiple threads where possible, [disable AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/commit.html), and group requests into transactions.

Replication in {{ mmy-name }} uses global transaction identifiers ([GTID](https://dev.mysql.com/doc/refman/5.7/en/replication-gtids-concepts.html)), too. They help maintain data consistency across cluster hosts.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

## Specifics of replication in {{mmy-name}}

If a cluster is single-host or if all replicas, except for the master, are completely unavailable (the status of the hosts is `DEAD`), replication doesn't work. As soon as a replica appears or becomes available in the cluster, semi-sync replication is performed in stages:

1. When a replica becomes available, asynchronous replication is immediately enabled from the master. The master remains fully available for reads and writes and replica lag is gradually reduced.
1. As soon as the lag is less than 100 MB, synchronous replication is enabled. The master becomes unavailable for writes until the data is fully synced with the replica: this process can take from one to tens of seconds depending on network performance.
1. Once data on the master and replica is fully synced, the hosts are made fully available again and replicated synchronously.