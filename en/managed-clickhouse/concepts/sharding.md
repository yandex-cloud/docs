# Sharding

_Sharding_ is a horizontal cluster scaling strategy that puts parts of one {{ CH }} database on different shards. A _shard_ consists of one or more [replica hosts](replication.md). A write or read request for the shard can be sent to any of its replicas because there is no dedicated master. When data is inserted, it is taken from the replica on which the `INSERT` request was executed and copied to other replicas in the shard in asynchronous mode.

## Benefits of sharding {#advantages}

Sharding is often used in the following cases:
- When very frequent database queries and rapid data growth are expected.
- The application requires ever more resources, but a solution that uses a cluster with [replication](replication.md) can no longer be scaled using the vertical strategy (by increasing the computing power of the hosts in the cluster: drives, memory and processors).

Sharding can help you:
- Overcome technical limitations. {#restrictions}

   If you need to operate large data sets, your data storage infrastructure may cause your commercially available hardware to become stressed to the limit (for example, the disk subsystem will demonstrate poor IOPS metrics). If the application is running at hardware performance limits, it may be a good idea to distribute data across shards. In this case, the read operations are performed concurrently.

- Improve fault tolerance. {#high-availability}

   Sharding lets you isolate individual host or replica set failures. If you don't use sharding, then when one host or a set of replicas fails, the entire data they contain may become inaccessible. But if 1 shard out of 5 fails, for example, then 80% of the table data is still available.

- To improve the query performance. {#processing-speed}

   Requests compete with each other for the computing resources of cluster hosts, which can reduce the rate of request processing. This drop in the rate usually becomes obvious as the number of read operations or CPU time per query grows. In a sharded cluster where queries to the same table can be executed in parallel, competition for shared resources is eliminated and query processing time is reduced.

## Use of sharding {#uses}

To distribute data across shards, create a _distributed table_ on the [Distributed engine]({{ ch.docs }}/engines/table-engines/special/distributed/), which uses these shards. Some pieces of data in this table are stored on one shard, some on other shards. In fact, pieces of data are stored in the underlying tables that are located on the hosts of each shard. The distributed table only provides routing of queries to these tables.

When executing the `INSERT` query, {{ CH }} uses a _sharding key_ to determine where the data should be placed. Its value determines which shard the query is directed to. The sharding key is similar to the [partitioning key]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/). Ease of use and actual performance improvements with sharding employed significantly depend on the sharding key you choose: the right sharding key ensures that data is logically distributed across shards and isn't linked to data in different shards. Unlike the `INSERT` queries, the `SELECT` queries send subqueries to all shards in the cluster, regardless of how data is distributed across the shards.

{{ CH }} offers two different approaches to operating distributed tables with flexible data distribution in a cluster:
- You can create a distributed table that uses [_all shards_](../operations/shards.md) in a cluster ([example](../tutorials/sharding.md#shard-example)).
- You can also create a distributed table that uses a [_group of shards_](../operations/shard-groups.md) in a cluster ([example](../tutorials/sharding.md#shard-groups-example), [example of advanced sharding](../tutorials/sharding.md#shard-groups-advanced-example)). This group includes only some of the shards in a cluster.

   In this case you can:
   - Place tables with data on the same cluster shards that are used by the distributed table.
   - Place tables with data on one shard group and place a distributed table that routes queries to these tables with data on another shard group.

For example, you can set up the following shard configuration within a single {{ CH }} cluster using these methods:
- Group `A` comprised of two shards with hosts of the `s2.small` [class](instance-types.md): the main one to use for a distributed table with a low load. Data in the distributed table data is stored in the same shard group.
- Group `B` comprised of two shards with `s2.medium` hosts: the main one to use for a distributed table with a constant high load. The data in the distributed table is stored in another group `C` comprised of five shards with high-performance `m2.large` hosts.

To learn more about operating distributed tables, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/special/distributed/).

## Specifics of sharding management in {{ mch-name }} {#shard-management}

{{ mch-name }} manages shards as follows:
- When you [create a cluster](../operations/cluster-create.md), one `shard1` shard is automatically added to it. This shard includes all the hosts in the cluster. When you create a cluster of multiple hosts, [replication](./replication.md) support is automatically enabled.

- You can [add](../operations/shards.md#add-shard) the appropriate number of shards to the created cluster.

   To fully [benefit](#uses) from all the [advantages of sharding](#advantages), you need to have at least two shards in the cluster. Using a distributed table and a single shard is equivalent to using replication without sharding. It only protects against data loss when one or more shard replica hosts fail but doesn't provide distributed data storage.

- You can [add hosts](../operations/hosts.md#add-host) to a shard.

   Shards with multiple hosts require running replication. Therefore:

   * Clusters with a multi-host shard have {{ CK }} or {{ ZK }} replication mechanisms already running, which means you can immediately add hosts to the shard.
   * In clusters with single-host shards, you need to [enable fault tolerance using {{ ZK}}](../operations/zk-hosts.md#add-zk), and only then can you add hosts to the shard.

   For more information about replication, {{ CK }}, and {{ ZK }}, see [{#T}](replication.md).
