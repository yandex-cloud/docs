---
title: "Sharding in MongoDB"
description: "MongoDB supports sharding to handle large data volumes and increase DBMS throughput. Sharding is particularly useful when vertical scaling (upgrading server capacity) is neither cost-efficient nor possible. {{ mmg-name }} supports core data sharding strategies: hashed sharding (with a hash-based sharding key) and ranged sharding (by a shard key value range)."
---

# Sharding in Managed Service for MongoDB

_Sharding_ is a horizontal data scaling strategy that distributes parts of {{ MG }} collections across different hosts in the cluster. Shards (sets of hosts) are linked to data sets using the _shard key_. {{ MG }} supports sharding to handle large data volumes and increase DBMS throughput. Sharding is particularly useful when vertical scaling (upgrading server capacity) is neither cost-efficient nor possible.

{{ mmg-name }} supports core data sharding strategies:

* [hashed sharding](https://docs.mongodb.com/manual/core/hashed-sharding/) (with a hash-based sharding key).
* [ranged sharding](https://docs.mongodb.com/manual/core/ranged-sharding/) (by a shard key value range).

Read more about {{ MG }} database sharding in the [{{ MG }} documentation](https://docs.mongodb.com/manual/sharding/#sharded-cluster).

## Benefits of sharding {#advantages}

Sharding helps you distribute loads across database hosts. It's usually used in the following cases:
- When very frequent database queries and rapid data growth are expected.
- The application requires more and more resources, but a solution with a replica cluster can no longer be scaled using the vertical strategy (by increasing the computing power of the hosts in the cluster: disks, RAM, and CPU).

Horizontal scaling is the distribution of data sets and workloads across multiple nodes. You can also increase disk space by adding more servers. Although a single machine may be low capacity or slow, in a horizontally-scaled cluster, each machine handles only part of the total load and stores only part of the total data. This makes the system potentially more efficient than a single server with a large capacity and fast disks.

Sharding can help you:
- Overcome technical limitations. {#restrictions}

   When you need to handle large data sets, your data storage infrastructure might reach the maximum capacity of commercially available hardware (for example, disk subsystem IOPS).

   If your apps approach the performance limits, it's a good idea to split data into shards and distribute read operations.

- Create geographically distributed systems. {#geo-distribution}

   By distributing your cluster shards across regions, you can:
   - Improve availability for regional users.
   - Comply with the local laws, for example, by storing your data in a particular country or region.

- Improve fault tolerance. {#high-availability}

   Sharding lets you isolate individual host or replica set failures. If you don't use sharding, then when one host fails, access to the entire data set it contains is lost completely. But if one shard out of five fails, for example, then 80% of the collection data is still available.

   To reduce the risk of a whole shard going offline, we recommend configuring shards as a set of three replicas. Moreover, if you distribute shard hosts across different {{ yandex-cloud }} availability zones, you increase data availability.

- To improve the query performance. {#processing-speed}

   Query processing can slow down when they begin to compete for resources. This usually happens as the number of read operations or CPU time per query grows.

   However, in a sharded cluster, where shards query the same collection in parallel, competition for shared resources (CPU, disk subsystem) is eliminated and query processing time decreases.


## Use of sharding {#uses}

To split data into shards:
1. [Enable sharding](../operations/shards.md#enable) at the cluster level {{ mmg-name }}.
1. [Add](../operations/shards.md#add-shard) the required number of shards.
1. [Enable sharding](../tutorials/sharding.md#enable) for the applicable collections.

See also [Example of sharding](../tutorials/sharding.md#example).

## Specifics of sharding management in {{ mmg-name }} {#shard-management}

{{ mmg-name }} manages shards as follows:

- Due to limited resources, clusters with the **b1.medium** and **b2.medium** hosts can't be sharded.

- Clusters are unsharded at [creation](../operations/cluster-create.md).

- In {{ mmg-name }}, sharding is managed by the hosts with the roles `MONGOS` ([routing user queries](https://docs.mongodb.com/manual/core/sharded-cluster-query-router/)) and `MONGOCFG` ([storing the shard configuration](https://docs.mongodb.com/manual/core/sharded-cluster-config-servers/)).

- In {{ mmg-name }}, you can enable two types of sharding:
   - **Standard**: Cost-effective sharding for clusters that don't have any special requirements for sharding management hosts.

      The `MONGOINFRA` hosts that combine the `MONGOS` and `MONGOCFG` roles will be added to the cluster. The minimum number of such hosts is three.

   - **Advanced**: Flexible sharding for clusters that require a certain number of hosts for each role.

      Dedicated `MONGOS` and `MONGOCFG` servers will be added to the cluster. The minimum number of hosts is two for `MONGOS` and three for `MONGOCFG` hosts.

- In a sharded cluster:
   - All queries to {{ mmg-name }} must be redirected to `MONGOS` or `MONGOINFRA` hosts instead of `MONGOD` hosts.
   - You can't disable sharding or completely remove the hosts that support sharding: the cluster will always support a minimum number of `MONGOS` and `MONGOCFG` or `MONGOINFRA` hosts.
