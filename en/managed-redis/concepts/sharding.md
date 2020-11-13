# Sharding

Sharding in {{mrd-name}} is implemented using [{{ RD }} Cluster](https://redis.io/topics/cluster-tutorial).

## Benefits of sharding {#advantages}

Sharding allows you to distribute loads across database hosts, which lets you overcome the resource restrictions of a single server. This is particularly important when you handle large amounts of data or run compute-intensive jobs.

Horizontal scaling involves distributing datasets and load across multiple nodes. While a single machine may be slow or low-capacity, in a horizontally-scaled cluster, each machine handles only part of the total load and stores only part of the total data. This helps make your system more efficient than with a single high-capacity server.

Read more about {{ RD }} database sharding in the [{{ RD }} documentation](https://redis.io/topics/cluster-spec).

## Redis Cluster structure {#redis-cluster-structure}

{{ RD }} Redis Cluster lets you create a Redis installation with automatic data sharding between the hosts. {{ RD }} Redis Cluster includes a set of hosts for storing your data. {{ RD }} Redis Cluster is divided into shards, each consisting of a master and replica set. Data from clients is written to the master hosts, which are then [replicated](replication.md).

Each cluster has 16,348 *hash slots* evenly distributed between shards. Slots define the dataset stored in the shard.

## Fault tolerant {#failover}

All hosts in the cluster use service connections to exchange data about slots and regularly poll statuses from each other.

If the majority of master hosts fails to get a response from the host polled, they consider the host offline. If the master host is down, one of its replicas is assigned as the master. If all the replicas fail or none of them can be switched to, the host stops receiving queries. However, if a single shard is down, the entire Redis Cluster can stay  functional as long as the other shards are available for reading and writing data.

To ensure stable cluster operation, you need to create at least three master hosts in different availability zones, each with a single replica. Masters and their replicas must be located in different availability zones.

## Scaling {#scaling}

If you need to scale your cluster horizontally, you can [add new shards](../operations/shards.md#add) to it.

New shards are created without hash slots. To redistribute data, you must rebalance your cluster. Afterwards, some of the existing slots move to the new shard.

The cluster doesn't have to stop to move slots between shards. If the client queries the master for data that was moved to another shard, the query is forwarded to the new shard that the data was moved to. Hosts don't proxy queries. Instead, they forward the client to the proper shard.

{{ mrd-name }} lets you create from 3 to 10 shards, each with 1 to 7 hosts.

