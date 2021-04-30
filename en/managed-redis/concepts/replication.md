---
title: Redis replication and fault tolerance
description: {{ mrd-name }} uses standard Redis replication and provides high availability of cluster data using Redis Sentinel.
keywords:
  - replication redis
  - redis
  - DB redis
---

# Replication and fault tolerance

{{ mrd-name }} uses standard Redis replication and provides high availability of cluster data using Redis Sentinel.

## Replication {#replication}

{{ mrd-name }} clusters use asynchronous replication: the result of a write request is reflected on the master host, which then forwards the data to the cluster replicas. The replication process does not affect the master availability in any way, but it can make replicas temporarily unavailable (for up to a few seconds for large databases) when loading new data into memory.

Because of the asynchronous nature of replication, data on replicas might become stale: while a replica is processing updates received from the master, it continues responding to requests using the available data (the [replica-serve-stale-data yes](http://download.redis.io/redis-stable/redis.conf) parameter is set).

Due to limited resources, **b1.nano** and **b1.small** class hosts aren't replicated.

For more information about how replication works in {{ RD }}, see the [DBMS documentation](https://redis.io/topics/replication).

## Fault tolerance {#availability}

High availability of cluster data is provided using Redis Sentinel: in a cluster consisting of three or more three hosts, Sentinel services automatically manage the selection of the master and the configuration of replicas.

In order to make decisions about cluster performance, the majority of Sentinel services need to be healthy. As a result, it's more cost-efficient to deploy clusters with an odd number of hosts when working with {{ mrd-name }}. For example, a cluster with three hosts can lose one host and continue working, while a cluster with four hosts can also lose no more than one host: if a second host is lost, the remaining Sentinel instances will not be enough to select a new master.

A cluster consisting of two hosts does not provide full failover for the same reason: one of the two Sentinel instances will not be enough to assign one host as a master if the other one failed. In this situation, the cluster can only process read operations.

Owners of {{ mrd-name }} clusters can't configure Sentinel services, but they can read the information that the services provide. Read more about Sentinel in the [DBMS documentation](https://redis.io/topics/sentinel).