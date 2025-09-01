---
title: Sharding in Yandex StoreDoc
description: '{{ SD }} supports sharding to handle large volumes of data and increase DBMS throughput. Sharding can be of particular use when vertical scaling (server capacity upgrade) is either uneconomical or impossible. {{ mmg-name }} supports the main data sharding strategies: hashed sharding (with a hash-based shard key) and ranged sharding (based on a value range).'
---

# Sharding in {{ mmg-name }}

_Sharding_ is a horizontal data scaling strategy that puts parts of {{ SD }} collections on different cluster hosts. A shard (set of hosts) is linked to a dataset with a _shard key_. {{ SD }} supports sharding to handle large volumes of data and increase DBMS throughput. Sharding is particularly useful when vertical scaling (upgrading server capacity) is either not cost-efficient or impossible.

{{ mmg-name }} supports core data sharding strategies:
 
 * [Hashed sharding](https://docs.mongodb.com/manual/core/hashed-sharding/) (with a hash-based sharding key)
 * [Ranged sharding](https://docs.mongodb.com/manual/core/ranged-sharding/) (by a shard key value range)

You can read more about {{ SD }} database sharding in the [{{ MG }} documentation](https://docs.mongodb.com/manual/sharding/#sharded-cluster).

## Advantages of sharding {#advantages}

Sharding enables you to distribute workload between database hosts. It is usually used in the following cases:
- When you expect very frequent database queries and rapid data growth.
- When your application requires more and more resources but increasing the computing power of the cluster hosts (disks, RAM, and CPUs) is no longer an option.

Horizontal scaling involves distributing datasets and workload between multiple nodes. You can also add servers to increase disk capacity. A single machine may underperform in terms of capacity or speed; however, in a horizontally-scaled cluster, each machine processes only a portion of total workload and stores only a portion of total data. This makes the system potentially more efficient than a single high-capacity server with fast disks.

With sharding, you can:
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
  
- Improve query performance. {#processing-speed} 

  Query performance can degrade due to resource contention. This usually happens as the number of read operations or CPU time per query increases.

  Shards handle queries to the same collection in parallel, thus avoiding resource (CPU and disk subsystem) contention and reducing query processing time.


## Use of sharding {#uses}

To split data into shards:
1. [Enable sharding](../operations/shards.md#enable) at the {{ mmg-name }} cluster level.
1. [Add](../operations/shards.md#add-shard) the required number of shards.
1. [Enable sharding](../tutorials/sharding.md#enable) for the applicable collections.

See also [Example of sharding](../tutorials/sharding.md#example).


## Sharding management in {{ mmg-name }} {#shard-management}

{{ mmg-name }} manages shards as follows:

- Due to limited resources, clusters with **b1.medium** and **b2.medium** hosts are not sharded.

- You can [create a sharded](../operations/cluster-create.md#creating-a-sharded-cluster) cluster or [enable sharding](../operations/shards.md#enable) later.

- In {{ mmg-name }}, sharding is managed by the hosts with the `MONGOS` ([routing user queries](https://docs.mongodb.com/manual/core/sharded-cluster-query-router/)) and `MONGOCFG` ([storing shard configuration](https://docs.mongodb.com/manual/core/sharded-cluster-config-servers/)) roles.

- In {{ mmg-name }}, you can enable two types of sharding:
  - **Standard**: Cost-effective sharding for clusters that do not have any special requirements for sharding management hosts.
  
    The cluster will be expanded to include the `MONGOINFRA` hosts having both the `MONGOS` and `MONGOCFG` roles. The minimum number of such hosts is three.
    
  - **Advanced**: Flexible sharding for clusters that require a certain number of hosts for each role.
  
    Dedicated `MONGOS` and `MONGOCFG` servers will be added to the cluster. The cluster must have at least two `MONGOS` and three `MONGOCFG` hosts.
    
- In a sharded cluster:
  - All queries to {{ mmg-name }} must be redirected to `MONGOS` or `MONGOINFRA` hosts instead of `MONGOD`.
  - You cannot disable sharding or completely remove the hosts that support sharding: the cluster will always support a minimum number of `MONGOS` and `MONGOCFG` or `MONGOINFRA` hosts.

## Use cases {#examples}

* [{#T}](../tutorials/storedoc-migration-with-data-transfer)
* [{#T}](../tutorials/storedoc-versions)
* [{#T}](../tutorials/sharding.md)
