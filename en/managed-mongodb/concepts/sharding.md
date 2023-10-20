---
title: "Sharding in MongoDB"
description: "MongoDB supports sharding to handle large data and increase the DBMS throughput. Sharding is particularly useful when vertical scaling (upgrading server capacity) is either not cost-efficient or impossible. {{ mmg-name }} supports core data sharding strategies: hashed sharding (with a hash-based sharding key) and ranged sharding (by a shard key value range)."
---

# Sharding in Managed Service for MongoDB

_Sharding_ is a horizontal data scaling strategy that distributes parts of {{ MG }} collections across different hosts in a cluster. A shard, which is a group of hosts, is linked to datasets using the _shard key_. {{ MG }} supports sharding to handle large data and increase the DBMS throughput. Sharding is particularly useful when vertical scaling (upgrading server capacity) is either not cost-efficient or impossible.

{{ mmg-name }} supports core data sharding strategies:

* [Hashed sharding](https://docs.mongodb.com/manual/core/hashed-sharding/) (with a hash-based sharding key)
* [Ranged sharding](https://docs.mongodb.com/manual/core/ranged-sharding/) (by a shard key value range)

You can read more about {{ MG }} database sharding in the [{{ MG }} documentation](https://docs.mongodb.com/manual/sharding/#sharded-cluster).

## Advantages of sharding {#advantages}

Sharding helps you distribute loads across database hosts. It is usually used in the following cases:
- When you expect very frequent database queries and rapid data growth.
- When your application requires more and more resources, but a replica cluster can no longer be scaled using the vertical strategy, i.e., by increasing the computing power of the host resources, such as disks, RAM, and CPU.

Horizontal scaling means distributing datasets and workloads across multiple nodes. You can also increase disk space by adding more servers. A single machine may have low capacity or be slow; however, in a horizontally-scaled cluster, each machine handles only part of the total load and stores only part of the total data. This makes the system potentially more efficient than a single server with a large capacity and fast disks.

Sharding can help you:
- Overcome technical limitations. {#restrictions}

   When you need to handle large datasets, your data storage infrastructure might reach the maximum capacity of commercially available hardware, e.g., disk subsystem IOPS.

   If your apps approach the performance limits, it might be handy to split data into shards and distribute read operations.

- Create geographically distributed systems. {#geo-distribution}

   By distributing your cluster shards across regions, you can:
   - Improve availability for regional users.
   - Comply with the local laws, for example, by storing your data in a particular country or region.

- Improve fault tolerance. {#high-availability}

   Sharding allows you to isolate individual host or replica failures. If you do not use sharding, then, when one host fails, you lose access to the entire dataset it contains. Conversely, if one shard out of five fails, 80% of the collection data will still be available.

   To reduce the risk of an entire shard going down, we recommend configuring shards as a group of three replicas. Furthermore, by distributing shard hosts across different {{ yandex-cloud }} availability zones, you can increase data availability.

- Improve the query performance. {#processing-speed}

   Query processing can get slower when the queries start competing for resources. This usually happens as the number of read operations or CPU time per query increases.

   However, in a sharded cluster, where shards query the same collection in parallel, there is no competition for shared resources, such as CPU or disk subsystem, and query processing time decreases.


## Use of sharding {#uses}

To split data into shards:
1. [Enable sharding](../operations/shards.md#enable) at the {{ mmg-name }} cluster level.
1. [Add](../operations/shards.md#add-shard) the required number of shards.
1. [Enable sharding](../tutorials/sharding.md#enable) for the applicable collections.

See [this example of sharding](../tutorials/sharding.md#example).


## Sharding management in {{ mmg-name }} {#shard-management}

{{ mmg-name }} manages shards as follows:

- Due to limited resources, clusters with **b1.medium** and **b2.medium** hosts are not sharded.

- You can [create a sharded](../operations/cluster-create.md#creating-a-sharded-cluster) cluster or [enable sharding](../operations/shards.md#enable) later.

- In {{ mmg-name }}, sharding is managed by the hosts with the `MONGOS` ([routing user queries](https://docs.mongodb.com/manual/core/sharded-cluster-query-router/)) and `MONGOCFG` ([storing the shard configuration](https://docs.mongodb.com/manual/core/sharded-cluster-config-servers/)) roles.

- In {{ mmg-name }}, you can enable two types of sharding:
   - **Standard**: Cost-effective sharding for clusters that do not have any special requirements for sharding management hosts.

      The `MONGOINFRA` hosts that combine the `MONGOS` and `MONGOCFG` roles will be added to the cluster. The minimum number of such hosts is three.

   - **Advanced**: Flexible sharding for clusters that require a certain number of hosts for each role.

      Dedicated `MONGOS` and `MONGOCFG` servers will be added to the cluster. The minimum number of hosts is two for `MONGOS` and three for `MONGOCFG` hosts.

- In a sharded cluster:
   - All queries to {{ mmg-name }} must be redirected to `MONGOS` or `MONGOINFRA` hosts instead of `MONGOD` hosts.
   - You cannot disable sharding or completely remove the hosts that support sharding: the cluster will always support a minimum number of `MONGOS` and `MONGOCFG` or `MONGOINFRA` hosts.