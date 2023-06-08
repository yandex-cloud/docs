# Replication in {{ mpg-name }}

{{ mpg-name }} clusters use _quorum-based synchronous replication_:

1. Master host is selected from among cluster hosts, while all other hosts become replicas.
1. _Quorum_ is randomly established from replicas. A transaction is considered successful only if it is confirmed by the master host and all replica members of the quorum (_quorum_ replicas).

Replicas with a manually specified replication source can neither become master hosts nor be part of a quorum.

To establish a quorum, at least 50% of the cluster replicas must be part of it. If there is an odd number of replicas, the value is rounded down. For example, in a cluster with 17 replicas, at least 8 are required for a quorum.

The quorum is established over again when the cluster topology changes, i.e., after [adding](../operations/hosts.md#add) and [deleting](../operations/hosts.md#remove) hosts, their failure, during their maintenance, return to service, etc. The host added to the cluster is first synchronized with the master host and only then can become part of the quorum.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

For more information about how replication works in {{ PG }}, read the [PostgreSQL documentation](https://www.postgresql.org/docs/current/static/warm-standby.html).

## Managing replication {#replication}

To ensure data safety in a cluster, {{ mpg-full-name }} uses streaming replication. Each replica host receives a replication stream from another host (usually, the master host). {{ mpg-name }} manages replication streams in a cluster automatically, but you can [manage them manually](../operations/hosts.md#update), if required.

In a cluster, you can combine automatic and manual management of replication streams.

### Automatic management of replication streams {#replication-auto}

Once a {{ PG }} cluster with multiple hosts is created, it contains one master host and replicas. Replicas use the master host as a replication source.

Specifics of automatic replication in {{ mpg-name }}:

* If the master host fails, its replica becomes a new master.
* When the master changes, the replication source for all replica hosts automatically switches to the new master host.

For more information, see [{#T}](#selecting-the-master).

### Manual management of replication streams {#replication-manual}

When you manually manage replication streams, any host in the cluster may become a replication source for a replica.

In this case, you can:

* Fully manage the replication process in the cluster without using automatic replication.
* Configure replication for {{ PG }} clusters with a complex topology. In this case, some of the replicas will be managed automatically, while others, manually.

For example, this way, you can configure cascading replication when some of the cluster replicas use other hosts in the cluster as the source of the replication stream. The replication thread for such source hosts can be managed both automatically (with the {{ mpg-name }} tools) and manually.

Replicas, for which the replication source is specified manually, cannot:

* Become a master host when the previous one is changed automatically or [manually](../operations/update.md#start-manual-failover) (regardless of the [priority](#selecting-the-master) value).
* Automatically switch to a new replication source when the current replication source fails.
* Be part of quorum replication.
* Be selected as [least lagging](../operations/connect.md#fqdn-replica) replicas when using a special FQDN.

## Selecting a master host {#selecting-the-master}

To modify the process of selecting a master host in a {{ PG }} cluster, [set the appropriate priority values](../operations/hosts.md#update) for hosts in a cluster. The host with the highest priority is selected as a master host. If there are multiple replicas with the same priority, the master host will be selected among them.

You can set the priority for a host:

* When [creating a cluster](../operations/cluster-create.md) with the YC CLI, API, or {{ TF }}.
* When [changing the host settings](../operations/hosts.md#update).

The lowest priority is `0` (default), while the highest one is `100`.

You can disable autofailover [by changing additional cluster settings](../operations/update.md#change-additional-settings). If the current master host fails, you will have to run the selection of a new master or assign this role to one of the replicas [manually](../operations/update.md#start-manual-failover).

## Write sync and read consistency {#write-sync-and-read-consistency}

Synchronization of data writes in {{ PG }} is ensured by syncing the [write-ahead log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) (the `synchronous_commit` [parameter](settings-list.md#setting-synchronous-commit)). The default parameter value is `on`. This means a transaction is committed only if the WAL is written to both the master disk and quorum replica disk.

If you want to ensure the ongoing consistency of data reads between the master and quorum replica, set `synchronous_commit` to `remote_apply` [in the cluster settings](../operations/update.md#change-postgresql-config). With this parameter value, a data write is not considered successful until the quorum replica applies the changes from the WAL. In this case, the read operation performed on the master and the synchronous quorum returns the same result.

The disadvantage of it is that the write operations to the cluster will take longer. If the master and the quorum replica are located in different availability zones, the latency of transaction confirmation cannot be less than the round-trip time (RTT) between data centers. As a result, when writing data to a single thread with the `AUTOCOMMIT` mode enabled, the cluster performance will degrade.

To enhance the performance, write data to multiple threads whenever possible, [disable `AUTOCOMMIT`](https://www.postgresql.org/docs/current/ecpg-sql-set-autocommit.html), and group queries within a transaction.

## Logical decoding {#logical-decoding}

{{ mpg-name }} clusters support [logical decoding](https://www.postgresql.org/docs/current/logicaldecoding.html) to stream DB changes to external services. For instance, it may be used as a way to [change data capture (CDC)](../../data-transfer/concepts/cdc.md).

Information about DB changes is sent to a [replication slot](https://www.postgresql.org/docs/current/logicaldecoding-explanation.html) in WAL format, where it is decoded to a format readable by an external service using an [output plugin](https://www.postgresql.org/docs/current/logicaldecoding-output-plugin.html).

{{ mpg-name }} supports the following WAL plugins:

* [test_decoding](https://www.postgresql.org/docs/current/test-decoding.html): Converts WAL data into text.
* [wal2json](https://github.com/eulerto/wal2json): Converts WAL data into JSON format.
* [pgoutput](https://www.npgsql.org/doc/replication.html#logical-streaming-replication-protocol-pgoutput-plugin): Transforms data read from WAL to the [logical replication protocol](https://www.postgresql.org/docs/current/protocol-logicalrep-message-formats.html).

To [create](../operations/replication-slots.md#create) a replication slot, a user must have the [`mdb_replication` role](./roles.md#mdb-replication).
