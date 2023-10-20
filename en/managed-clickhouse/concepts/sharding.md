# Sharding in {{ mch-name }}

_Sharding_ is a horizontal cluster scaling strategy that puts parts of a single {{ CH }} database on different shards. A _shard_ consists of one or more [replica hosts](replication.md). A write or read request for the shard can be sent to any of its replicas, as there is no dedicated master. When data is inserted, it is taken from the replica on which the `INSERT` request was executed and copied to other replicas in the shard in asynchronous mode.

## Advantages of sharding {#advantages}

Sharding is often used in the following cases:
- When you expect very frequent database queries and rapid data growth.
- When your application requires more and more resources, but a [replicated](replication.md) cluster can no longer be scaled using the vertical strategy, i.e., by increasing the computing power of the host resources, such as disks, RAM, and CPU.

Sharding can help you:
- Overcome technical limitations. {#restrictions}

   If you need to work with large datasets, your data storage infrastructure may cause your commercially available hardware to become stressed to the limit (for example, the disk subsystem will demonstrate poor IOPS metrics). If the application is running at hardware performance limits, it may be a good idea to distribute data across shards. In this case, the read operations will be performed concurrently.

- Improve fault tolerance. {#high-availability}

   Sharding allows you to isolate individual host or replica failures. If you do not use sharding, then, when one host or a few replicas fail, you lose access to the entire dataset they contain. Conversely, if one shard out of five fails, 80% of the table data will still be available.

- Improve the query performance. {#processing-speed}

   Queries compete with each other for the computing resources of cluster hosts, which can reduce the rate of query processing. This drop in the rate usually becomes obvious as the number of read operations or CPU time per query grows. However, in a sharded cluster, where queries to the same table can be run in parallel, there is no competition for shared resources, which allows you to reduce the query processing time.

## Use of sharding {#uses}

To distribute data across shards, create a _distributed table_ based on the [Distributed engine]({{ ch.docs }}/engines/table-engines/special/distributed/), which uses these shards. A part of data in such a table will be stored on one shard, and another part, on other shards. Technically, pieces of data are stored in the underlying tables that are located on the hosts of each shard. The distributed table only routes queries to these tables.

When running the `INSERT` query, {{ CH }} uses a _sharding key_ to determine where the data should be placed. Its value determines which shard the query will target. The sharding key is similar to the [partitioning key]({{ ch.docs }}/engines/table-engines/special/distributed/) Ease of use and actual performance improvements when using sharding significantly depend on the sharding key you choose: the right sharding key ensures that the data is logically distributed across shards and is not linked to data in different shards. Unlike the `INSERT` queries, the `SELECT` queries send subqueries to all shards in the cluster, regardless of how data is distributed across the shards.

{{ CH }} offers two different approaches to operating distributed tables with flexible data distribution in a cluster:
- You can create a distributed table that uses [_all shards_](../operations/shards.md) in a cluster (see the example [here](../tutorials/sharding.md#shard-example)).
- You can create a distributed table that uses a [_group of shards_](../operations/shard-groups.md) in a cluster (click [here](../tutorials/sharding.md#shard-groups-example) for a regular sharding example, and [here](../tutorials/sharding.md#shard-groups-advanced-example), for an example of advanced sharding). Such a group includes only some shards in a cluster.

   In this case, you can:
   - Place tables with data on the same cluster shards that are used by the distributed table.
   - Place tables with data in one shard group, and the distributed table that routes queries to these tables with data, in another shard group.

For example, you can set up the following shard configuration within a single {{ CH }} cluster using these methods:
- Group `A` comprised of two shards with hosts of the `s2.small` [class](instance-types.md): Used as the main one for a distributed table with a low load. Data in the distributed table data is stored in the same shard group.
- Group `B` comprised of two shards with `s2.medium` hosts: Used as the main one for a distributed table with a constant high load. The data in the distributed table is stored in another group, `C`, comprised of five shards with high-performance `m2.large` hosts.

To learn more about working with distributed tables, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/special/distributed/).

## Sharding management in {{ mch-name }} {#shard-management}

{{ mch-name }} manages shards as follows:
- When you [create a cluster](../operations/cluster-create.md), a shard named `shard1` is automatically added to it. This shard includes all hosts in the cluster. When you create a cluster with multiple hosts, [replication](./replication.md) support is automatically enabled.

- You can [add](../operations/shards.md#add-shard) the appropriate number of shards to the created cluster.

   To fully [benefit](#uses) from all [advantages of sharding](#advantages), your cluster should have at least two shards. Using a distributed table and a single shard is equivalent to using replication without sharding. It only protects against data loss when one or more shard replica hosts fail; however, it does not provide distributed data storage.

- You can [add hosts](../operations/hosts.md#add-host) to a shard.

   Shards with multiple hosts require running replication. Therefore:

   * Clusters with a multi-host shard have {{ CK }} or {{ ZK }} replication already running, which means you can immediately add hosts to the shard.
   * In clusters with single-host shards, you need to [enable fault tolerance using {{ ZK}}](../operations/zk-hosts.md#add-zk), and only then add hosts to the shard.

   For more information about replication, {{ CK }}, and {{ ZK }}, see [Replication](replication.md).
