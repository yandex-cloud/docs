# Sharding

{% note info %}

Sharding in {{ mmg-name }} is available for clusters running {{ MG }} version 4.0 or higher. If your cluster is deployed with version 3.6, you can [update it](../operations/cluster-version-update.md).

{% endnote %}

_Sharding_ is a horizontal data scaling strategy that puts parts of MongoDB collections on different hosts in the cluster. Shards (sets of hosts) are linked to data sets using the _shard key_. MongoDB supports sharding to handle large data volumes and increase DBMS throughput. Sharding is particularly useful when vertical scaling (upgrading server capacity) isn't cost-efficient or possible.

{{ mmg-name }} supports the core data sharding strategies:

* Hashed sharding (by a range of hashed shard key values)
* Ranged sharding (by a shard key value range)

## Benefits of sharding {#advantages}

Sharding allows you to distribute loads across database hosts, which lets you overcome the resource restrictions of a single server. This is particularly important when you handle large amounts of data or run compute-intensive jobs.

Horizontal scaling is the distribution of data sets and workloads across multiple nodes. You can increase disk space by adding more servers. While a single machine may be slow or low-capacity, in a horizontally-scaled cluster, each machine handles only part of the total load and stores only part of the total data. This makes the system potentially more efficient than a single server with a large capacity and fast disks.

The downside of sharding is the complexity of the infrastructure, deployment, and maintenance.

More information on {{ MG }} database sharding can be found in the [{{ MG }} documentation](https://docs.mongodb.com/v4.0/sharding/#sharded-cluster).

## Use of sharding {#uses}

Sharding is often used in the following cases:

* High frequency of database queries and fast data growth is expected.
* An app requires more and more resources, but the cluster replica solution can't be expanded using higher-capacity and faster disks, server RAM, or more powerful CPUs.

Sharding can help you solve the following problems:

* [Technical restrictions](#restrictions).
* [Geographically distributed data consumers](#geo-distribution).
* [Insufficient fault-tolerance](#high-availability).
* [Low query processing speed](#processing-speed).

### Technical restrictions {#restrictions}

The need to work with fairly large data sets may cause your data storage infrastructure to reach the maximum capacity of commercially available hardware (for example, disk subsystem IOPS).

When your apps approach the performance limits, it's a good idea to split the data into shards and distribute the read operations.

### Geographically distributed consumers {#geo-distribution}

By distributing your cluster shards across regions, you can:

* Improve availability for regional users.
* Comply with the local laws, for example, by storing your data in a particular country or region.

### Insufficient fault-tolerance {#high-availability}

Sharding lets you isolate individual host or replica set malfunctions. If you don't use sharding, then when one host fails, access to the entire data set it contains is lost completely. But if one shard out of five fails, for example, then 80% of the collection data is still available.

To reduce the risk of a whole shard going offline, we recommend configuring shards as a set of three replicas. Moreover, if you distribute shard hosts across different Yandex.Cloud availability zones, you increase data availability.

### Slow query processing {#processing-speed}

Query processing can slow down when they begin to compete for resources. This usually happens as the number of read operations or CPU time per query grows.

However, in a sharded cluster, where shards query the same collection in parallel, competition for shared resources (CPU, disk subsystem) is eliminated and query processing time is reduced.

