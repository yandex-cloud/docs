---
title: Sharding in {{ mch-full-name }}
description: In this article, you will learn about sharding, its benefits, use cases, and how sharding is managed in {{ mch-name }}.
---

# Sharding in {{ mch-name }}

_Sharding_ is a horizontal cluster scaling strategy that spreads parts of a single {{ CH }} database across different shards. A _shard_ consists of one or more [replica hosts](replication.md). A write or read request for the shard can be sent to any of its replicas, as there is no dedicated master. For inserts, data is copied from the replica that ran the `INSERT` request to other replicas in the shard in asynchronous mode.

## Advantages of sharding {#advantages}

Sharding is often used in the following cases:
- When you expect very frequent database queries and rapid data growth.
- When your application requires more and more resources, but a [replicated](replication.md) cluster can no longer be scaled vertically, i.e., by increasing the computing power of the host resources, such as disks, RAM, and CPU.

With sharding, you can:

- Overcome technical limitations. {#restrictions}

  If you need to work with large datasets, your data storage infrastructure may reach the maximum capacity of commercially available hardware, e.g., the disk subsystem will indicate low IOPS. If your application is running close to the hardware limits, sharding may help. In this case, data reads will be concurrent.

- Increase availability. {#high-availability}

  Sharding allows you to isolate individual host or replica failures. Without sharding, if a single host or a few replicas fail, you may lose access to the entire dataset they contain. Conversely, if one shard out of five fails, 80% of the table data will still be available.

- Improve query performance. {#processing-speed}

  Queries compete for computing resources of cluster hosts, which may reduce query processing rate. This rate drop usually becomes obvious as the number of reads or CPU time per query increases. However, in a sharded cluster, queries to the same table can run in parallel without competing for shared resources, which reduces the query processing time.

## Use of sharding {#uses}

To distribute data across shards, create a _distributed table_ on the [Distributed engine]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) that uses these shards. Table data will be stored in parts on multiple shards. Technically, data parts are stored in the underlying tables that are located on the hosts of each shard. The distributed table only routes queries to these tables.

When running the `INSERT` query, {{ CH }} uses a _sharding key_ to determine the target shard. Its value determines which shard will be queried. The sharding key is similar to the [partitioning key]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key). The sharding key practically determines if sharding will help streamlining your workflow and improve actual performance. Choose the sharding key so that data is logically distributed across shards and data in different shards is not interrelated. Unlike the `INSERT` queries, the `SELECT` queries send subqueries to all shards in the cluster, regardless of how data is distributed across the shards.

{{ CH }} offers two different approaches to operating distributed tables with flexible data distribution in a cluster:
- You can create a distributed table that uses [_all shards_](../operations/shards.md) in a cluster (see the example [here](../tutorials/sharding.md#shard-example)).
- You can create a distributed table that uses a [_group of shards_](../operations/shard-groups.md) in a cluster (see the example [here](../tutorials/sharding.md#shard-groups-example) and also [here](../tutorials/sharding.md#shard-groups-advanced-example) for the advanced sharding example). Such a group includes only some shards in a cluster.

  In this case, you can:
  - Place data tables on the same cluster shards the distributed table uses.
  - Place data tables in one shard group, and the distributed table that routes queries to these data tables, in another shard group.

For example, you can set up the following shard configuration within a single {{ CH }} cluster using these methods:
- Group `A` comprised of two shards with `s2.small` [hosts](instance-types.md): Used as the main one for a distributed table with a low load. Data in the distributed table is stored in the same shard group.
- Group `B` comprised of two shards with `s2.medium` hosts: Used as the main one for a distributed table with a constant high load. Data in the distributed table is stored in another group, `C`, comprised of five shards with high-performance `m2.large` hosts.

To learn more about using distributed tables, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed).

## Sharding specifics in {{ mch-name }} {#shard-management}

{{ mch-name }} manages shards as follows:
- When you [create a cluster](../operations/cluster-create.md), a shard named `shard1` is automatically added to it. This shard includes all hosts in the cluster. When you create a multi-host cluster, [replication](./replication.md) support is automatically enabled.

- You can [add](../operations/shards.md#add-shard) as many shards as you need to the created cluster.

  To [make the most](#advantages) of [sharding](#uses), your cluster should have at least two shards. Using a distributed table and a single shard is equivalent to using replication without sharding. It only protects you against data loss when one or multiple shard replica hosts fail; however, it does not provide distributed data storage.

- You can [add hosts](../operations/hosts.md#add-host) to a shard.

    Multi-host shards require enabled replication, thus:

    * In clusters with a multi-host shard, {{ CK }} or {{ ZK }} replication is already enabled, which means you can immediately add hosts to the shard.
    * In clusters with single-host shards, you should first [turn on the {{ CK }} or {{ ZK }} coordination service](../operations/update.md#enable-coordination) and only then proceed to add hosts to the shard.

    For more information about replication, {{ CK }}, and {{ ZK }}, see [this guide](replication.md).

- Shard IDs in {{ yandex-cloud }} are different from their IDs in {{ CH }}:

    * {{ mch-name }} clusters use shard names.
    * {{ CH }} uses numeric IDs that match the alphabetic order of shard names in {{ mch-name }}, e.g., `A-shard`, `B-shard`, `shard10`, `shard100`.

    Keep this in mind if your application accesses shards by their IDs when writing and reading distributed table data.

    To learn how IDs in {{ yandex-cloud }} and {{ CH }} match, run this query:

    ```sql
    SELECT
     substitution AS shard_name,
     shardNum() AS shard_number
    FROM cluster('{cluster}', system.macros)
    WHERE macro = 'shard'
    ORDER BY shard_name
    ```

    For example, in a cluster with the `shard1`, `shard2`, `shard3`, `shard4`, and `shard100` shards, the matching will look as follows:

    ```text
    ┌─shard_name─┬─shard_number─┐
    │ shard1     │            1 │
    └────────────┴──────────────┘
    ┌─shard_name─┬─shard_number─┐
    │ shard100   │            2 │
    └────────────┴──────────────┘
    ┌─shard_name─┬─shard_number─┐
    │ shard2     │            3 │
    └────────────┴──────────────┘
    ┌─shard_name─┬─shard_number─┐
    │ shard3     │            4 │
    └────────────┴──────────────┘
    ┌─shard_name─┬─shard_number─┐
    │ shard4     │            5 │
    └────────────┴──────────────┘
    ```

## Use cases {#examples}

* [{#T}](../tutorials/sharding.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
