---
title: Sharding in {{ mspqr-name }}
description: '{{ mspqr-name }} supports horizontal scaling of {{ PG }} data through sharding.'
---

# Sharding in {{ mspqr-name }}

_Sharding_ is a horizontal scaling strategy where data from multiple {{ PG }} clusters is combined into a single {{ SPQR }} cluster. The {{ PG }} clusters reside in the same folder and cloud network as the {{ SPQR }} cluster. In the {{ SPQR }} cluster, data is distributed across shards using a _sharding key_. Number of shards per cluster is unlimited.

The {{ SPQR }} cluster contains:

* Hosts that manage sharding in the {{ SPQR }} cluster.
* Hosts of {{ PG }} clusters that act as data hosts (master and replicas).

{{ mspqr-name }} supports the following data sharding strategies:

* [By hash](https://pg-sharding.tech/sharding/hashed)
* [By value range](https://pg-sharding.tech/sharding/ranged)

For more information about data sharding, see the [SPQR documentation](https://pg-sharding.tech/welcome/get_started).

## Advantages of sharding {#advantages}

Sharding is often used in the following cases:

* When you expect very frequent {{ PG }} database queries and rapid data growth.
* When your application requires more resources but increasing the computing power of the {{ PG }} cluster hosts (disks, RAM, and CPUs) is no longer an option.

With sharding, you can:

* Overcome technical limitations.

    If you need to work with large datasets, your data storage infrastructure may reach the maximum capacity of commercially available hardware, e.g., the disk subsystem will indicate low IOPS. If the application is running at hardware performance limits, it may be a good idea to distribute data across shards. In this case, the read operations will be performed concurrently.

* Improve fault tolerance.

    Sharding allows you to isolate individual host or replica failures. If you do not use sharding, then, when one host fails, you lose access to the entire dataset it contains. Conversely, if one shard out of five fails, 80% of the table data will still be available.

* Improve query performance.

    Query performance may degrade due to resource contention. This usually happens as the number of read operations or CPU time per query increases. Shards handle queries to the same table in parallel, thus avoiding resource (CPU and disk subsystem) contention and reducing query processing time.

## Sharding management in {{ mspqr-name }} {#shard-management}

In {{ mspqr-name }}, sharding is managed by the hosts with the `ROUTER` ([routing user queries](https://pg-sharding.tech/sharding/cluster_components/router)) and `COORDINATOR` ([storing shard configuration](https://pg-sharding.tech/sharding/cluster_components/coordinator)) roles.

You can use two types of sharding in {{ mspqr-name }}:

* Standard: Cost-effective sharding for clusters that do not have any special requirements for sharding management hosts. The cluster will be expanded to include the `INFRA` hosts having both the `ROUTER` and `COORDINATOR` roles.

* Advanced: Flexible type of shading. `ROUTER` hosts and optional `COORDINATOR` hosts will be added to the cluster.

`COORDINATOR` or `INFRA` hosts are used to configure sharding.

All queries in a {{ mspqr-name }} cluster must be directed to `ROUTER` or `INFRA` hosts. You cannot fully remove these hosts from the cluster. At least one `ROUTER` or `INFRA` host must remain.
