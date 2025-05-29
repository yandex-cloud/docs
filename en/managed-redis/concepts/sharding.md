---
title: Sharding in {{ VLK }}
description: In {{ mrd-name }}, sharding is implemented based on {{ VLK }} Cluster. {{ VLK }} Cluster allows you to create a {{ VLK }} installation with automatic data sharding between the hosts. Sharding allows you to distribute loads across database hosts, which helps bypass the resource restrictions of a single server. This is particularly important when you handle large amounts of data or run compute-intensive jobs.
---

# Sharding in {{ mrd-name }}

Sharding in {{ mrd-name }} works based on [{{ VLK }} Cluster](https://valkey.io/topics/cluster-tutorial).

## Advantages of sharding {#advantages}

Sharding allows you to distribute loads across database hosts, which helps bypass the resource restrictions of a single server. This is particularly important when you handle large amounts of data or run compute-intensive jobs.

Horizontal scaling involves distributing datasets and load across multiple nodes. A single machine may underperform in terms of capacity or speed; however, in a horizontally-scaled cluster, each machine processes only a portion of total workload and stores only a portion of total data. This helps make your system more efficient compared to a single high-capacity server.

You can read more about {{ VLK }} database sharding in the [{{ VLK }} documentation](https://valkey.io/topics/cluster-spec/).

## {{ VLK }} Cluster structure {#redis-cluster-structure}

{{ VLK }} Cluster allows you to create a {{ VLK }} installation with automatic data sharding between the hosts. {{ VLK }} Cluster comprises multiple hosts for storing your data. {{ VLK }} Cluster is divided into shards, each consisting of a master and a set of replicas. Data from clients is written to the master hosts and then [replicated](replication.md).

Each cluster has 16,348 *hash slots* evenly distributed across the shards. Slots define the dataset stored in the shard.

## Fault tolerance {#failover}


All hosts in the cluster use service connections to exchange data about slots and regularly request statuses from each other.

If the majority of master hosts fails to get a response from the host being polled, the host is considered to be down. If it is the master host that is down, one of its replicas becomes master. If all replicas fail or none of them can become master, the shard stops receiving queries. In a cluster with two or more shards, if a single shard is down, the {{ VLK }} Cluster itself will continue to work. The remaining shards will still be available for reading and writing data.

To make sure your cluster is stable, create at least one master host with a single replica. Masters and their replicas must reside in different availability zones, regardless of their number.

Sharded clusters with the **local-ssd** disk type and only one host per shard are not considered fault-tolerant. You cannot create such a cluster.

## Scalability {#scaling}

If you need to scale your cluster horizontally, you can [add new shards](../operations/shards.md#add) to it.

New shards are created without hash slots. To redistribute data, you must rebalance your cluster. Afterwards, some of the existing slots will move to the new shard.

You do not need to stop the cluster to move slots between shards. If the client queries the master for data that was moved to another shard, the query is forwarded to the new shard where the data was moved to. Hosts do not proxy queries; instead, they forward the client to the proper shard.

{{ mrd-name }} can contain between 1 and 10 shards, each comprising a different number of hosts. The minimum number of hosts per shard depends on the [selected disk type](./storage.md#storage-type-selection).

You can [create a cluster](../operations/cluster-create.md) with either a single shard or three or more shards. You cannot create a cluster with two shards, but you can [change the number of shards](../operations/shards.md) in an existing cluster.

For more information about limits on the number of hosts per shard, see [Quotas and limits](./limits.md).

## Use cases {#examples}

* [{#T}](../tutorials/redis-as-php-sessions-storage.md)
* [{#T}](../tutorials/data-migration.md)