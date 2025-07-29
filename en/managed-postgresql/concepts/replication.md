---
title: Replication in {{ mpg-full-name }}
description: In this tutorial, you will learn how cluster host replication works in {{ mpg-full-name }}.
---

# Replication in {{ mpg-name }}

{{ mpg-name }} clusters use _quorum-based synchronous replication_:

1. Master host is selected from among cluster hosts, while all other hosts become replicas.
1. A transaction is considered successful only if it is confirmed by the master host and the quorum of replicas. The quorum is the half of all replicas in a cluster. Replicas for the quorum are selected randomly (_quorum replicas_).

    If there is an odd number of replicas, the value is rounded down, except when there is only one replica. For example, in a cluster with 17 replicas, the quorum requires a minimum of eight replicas, while in a single-replica cluster, the quorum is one.

{% note warning %}

Replicas with a [manually specified replication source](#replication-manual) can neither become master hosts nor be part of a quorum.

{% endnote %}

The number of quorum replicas is updated every time the number of available cluster hosts changes, e.g., when hosts are [added](../operations/hosts.md#add) or [deleted](../operations/hosts.md#remove) as well as during scheduled or unscheduled maintenance. When you add a host, it is first synchronized with the master and only then can become part of the quorum.

For more information on how replication works in {{ PG }}, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/static/warm-standby.html).

## Managing replication {#replication}

To ensure data integrity, the cluster supports automatic replication management, where each replica host receives a replication stream from the master host. If you need to, you can [specify the replication source manually](../operations/hosts.md#update).

In a cluster, you can combine automatic and manual management of replication streams.

### Automatic management of replication streams {#replication-auto}

Once you create a {{ PG }} cluster with multiple hosts, it contains one master host and replicas. Replicas use the master host as a replication source.

Specifics of automatic replication in {{ mpg-name }}:

* When the master host fails, its most recent replica becomes the new master.
* When the master changes, the replication source for all replica hosts automatically switches to the new master host.

You can disable autofailover [by changing additional cluster settings](../operations/update.md#change-additional-settings). If the current master host fails, you will have to run the selection of a new master or assign this role to one of the replicas [manually](../operations/update.md#start-manual-failover).

### Manual management of replication streams {#replication-manual}

When you manage replication streams manually, a cluster host other than the master will serve as the replication source for a replica.

This way, in a {{ PG }} cluster with complex topology, you can configure _cascading replication_ during which some of the replicas use other cluster hosts as the replication stream source. The replication stream for such source hosts can be managed both automatically, using the {{ mpg-name }} tools, and manually.

{% note warning %}

Replicas, for which the replication source is specified manually, cannot:

* Become a master host when the previous one is changed automatically or [manually](../operations/update.md#start-manual-failover).
* Automatically switch to a new replication source when the current replication source fails.
* Be part of quorum replication.
* Be selected as most recent replicas when using a [special FQDN](../operations/connect.md#fqdn-replica).

A replica with a manually specified replication source cannot confirm a write operation. Its data will be regarded as obsolete if the write operation was made to other replicas and the quorum confirmed the transaction. As the replica’s lag grows, its WAL will be automatically overwritten with the new data from the replication source.

{% endnote %}

## Write sync and read consistency {#write-sync-and-read-consistency}

Synchronization of data writes in {{ PG }} is ensured by the `synchronous_commit` [parameter](settings-list.md#setting-synchronous-commit) that manages syncing the [write-ahead log](https://www.postgresql.org/docs/current/wal-intro.html) (WAL). The default value is `synchronous_commit = on`. In this case, a transaction is commited only if the WAL is written to both the master disk and each quorum replica disk.

Depending on the number of replicas in the cluster, the following behavior scenarios are possible:

* In a cluster with one replica, this replica will constitute the quorum, and manual replication stream management is unavailable. If the replica fails, write transactions will await confirmation until it is restored in the cluster.
* In a cluster with two replicas, a transaction is committed if the WAL is written to the disk of the quorum replica. If it fails, the quorum will consists of the remaining replica unless it has a replication source specified. In this case, the results of queries to the master host will not change.
* In a cluster with an odd number of replicas `N > 1`, the quorum consists of `N-1 / 2` replicas. For other replicas, you can set a replication source manually.
* In a cluster with an even number of replicas `N > 2`, the quorum consists of `N / 2` replicas. For other replicas, you can set a replication source manually.

To ensure ongoing consistency of data reads between the master and quorum replica, set `synchronous_commit = remote_apply` [in the cluster settings](../operations/update.md#change-postgresql-config). With this parameter value, a data write is not considered successful until the quorum replica applies the changes from the WAL. In this case, the read operation performed on the master and quorum replica returns the same result.

The downside is that the write operations to the cluster will take longer. If the master and the quorum replica are located in different [availability zones](../../overview/concepts/geo-scope.md), the transaction confirmation latency cannot be less than the round-trip time (RTT) between data centers. This will degrade cluster performance if writing data to a single thread with the `AUTOCOMMIT` mode on.

To enhance performance, write data to multiple threads whenever possible, [disable `AUTOCOMMIT`](https://www.postgresql.org/docs/current/ecpg-sql-set-autocommit.html), and group queries within a transaction.

## Logical decoding {#logical-decoding}

{{ mpg-name }} clusters support [logical decoding](https://www.postgresql.org/docs/current/logicaldecoding.html) to stream DB changes to external services. For instance, it may be used as a way to [change data capture (CDC)](../../data-transfer/concepts/cdc.md).

Information about DB changes is sent to a [replication slot](https://www.postgresql.org/docs/current/logicaldecoding-explanation.html) in WAL format, where it is decoded to a format readable by an external service using an [output plugin](https://www.postgresql.org/docs/current/logicaldecoding-output-plugin.html).

{{ mpg-name }} supports the following WAL plugins:

* [test_decoding](https://www.postgresql.org/docs/current/test-decoding.html): Converts WAL data into text.
* [wal2json](https://github.com/eulerto/wal2json): Converts WAL data into JSON format.
* [pgoutput](https://www.npgsql.org/doc/replication.html#logical-streaming-replication-protocol-pgoutput-plugin): Transforms data read from WAL to the [logical replication protocol](https://www.postgresql.org/docs/current/protocol-logicalrep-message-formats.html).

Replication slots can be [created](../operations/replication-slots.md#create) by users with the [`mdb_replication` role](./roles.md#mdb-replication).

## Use cases {#examples}

* [{#T}](../tutorials/data-migration.md)
* [{#T}](../tutorials/mmy-to-mpg.md)
* [{#T}](../tutorials/mpg-to-mmy.md)
* [{#T}](../tutorials/outbound-replication.md)
* [{#T}](../tutorials/rdbms-to-clickhouse.md)
