---
title: "Replication and fault tolerance in {{ RD }}"
description: "{{ mrd-name }} uses native {{ RD }} replication and provides high availability of cluster data using {{ RD }} Sentinel."
keywords:
  - redis replication
  - redis
  - redis dbms
---

# Replication and fault tolerance

{{ mrd-name }} uses native {{ RD }} replication and provides high availability of cluster data using {{ RD }} Sentinel.

## Replication {#replication}

{{ mrd-name }} clusters use asynchronous replication, i.e., the result of a write request is committed to the master host, which then forwards the data to the cluster replicas. The replication process does not affect the master availability in any way, but it can make replicas temporarily unavailable (for up to a few seconds for large databases) when loading new data into memory.

Since the replication is asynchronous, the data on replicas may be out of date: while a replica is processing updates from the master, it continues sending the existing data in response to requests, as the [replica-serve-stale-data](http://download.redis.io/redis-stable/redis.conf) flag is set to `yes`.


Due to limited resources, **b1**, **b2**, and **b3** class hosts are not replicated.



For more information about how replication works in {{ RD }}, read the [relevant documentation](https://redis.io/topics/replication).

## Fault tolerance {#availability}

A master host can be changed both automatically as a result of a failure and [manually](../operations/failover.md). Manual master switching is available both for a [sharded cluster](./sharding.md#failover) and an unsharded one.

High data availability in an unsharded cluster is implemented using {{ RD }} Sentinel: in a cluster consisting of three or more hosts, Sentinel services automatically manage master selection and replica configurations.

Sentinel requires most of its services to be healthy. As a result, it is more cost-efficient to deploy clusters with an odd number of hosts when using Sentinel. For example, a cluster with three hosts can lose one host and still continue working. At the same time, a cluster with four hosts can also lose only one host: if a second host is lost, the remaining Sentinel instances will not be enough to select a new master.

A cluster consisting of two hosts does not provide full failover for the same reason: one of the two Sentinel instances will not be enough to select one host as a master if the other one fails. In this situation, the cluster can only process read operations.

{{ mrd-name }} cluster owners cannot configure Sentinel services; however, they can read the information the services provide. You can read more about Sentinel in the [relevant documentation](https://redis.io/topics/sentinel).

{% note info %}

Sentinel is only applied for clusters with {{ RD }} version 6.2. The `rdsync` [agent is used](switchover.md) to ensure the fault tolerance of clusters with {{ RD }} 7.0.

{% endnote %}

### Assigning a different host as a master if the primary master fails {#master-failover}

If the master host fails, any of the cluster hosts available for replication may become a new master. If the master assignment priority is set for the cluster hosts, the host with the lowest priority will be selected as a new master. The minimum value is `0`, and the maximum (default) value is `100`. A host with the `0` priority will never be selected as a master.

## Persistence {#persistence}

{{ mrd-name }} clusters use data persistence presets. You can disable persistence, if required, to improve server throughput, as the DBMS will stop writing updates out to disk.

{% note warning %}

Disabling persistence is only fine in case data integrity is not important for your application, e.g., when using {{ mrd-name }} as cache. This is because, in this case, the most recent data captured in {{ RD }} will only be stored in RAM and may be lost if a server crashes.

{% endnote %}

### Persistence settings {#persistence-on}

By default, cluster persistence is enabled and uses the following {{ RD }} settings:

* **save ""**{#setting-save-rdb}

   Regular RDB file saving is disabled. [AOF](#setting-appendonly) mode is used instead.

* **appendonly yes**{#setting-appendonly}

   AOF (Append Only File) mode is enabled. In this mode, {{ RD }} logs every write operation without changing already written data.

* **no-appendfsync-on-rewrite yes**{#setting-no-appendfsync}

   Since the AOF `fsync` policy is set to `everysec`, the AOF log background save process (`BGSAVE`) or the rewrite process (`BGREWRITEAOF`) performs a lot of disk I/O operations. {{ RD }} may block `fsync()` calls for too long in some Linux configurations.

   The setting prevents calling `fsync()` within the main system process when running `BGSAVE` or `BGREWRITEAOF`.

   When `BGREWRITEAOF` is running, `fsync()` is called. {{ RD }} writes the shortest sequence of commands required to restore the current dataset to memory. You can manage data size using the [aof-rewrite-incremental-fsync](#setting-rewrite-incremental) setting.

* **auto-aof-rewrite-percentage 100**{#setting-rewrite-percentage}

   The AOF log size must exceed 100% for the AOF file to be automatically rewritten. This setting depends on the log file's [**auto-aof-rewrite-min-size**](#setting-rewrite-size) setting.

* **auto-aof-rewrite-min-size 64mb**{#setting-rewrite-size}

   Auto-aof-rewrite-min-size 64mb

* **aof-load-truncated yes**{#setting-load-truncated}

   Allows loading a truncated AOF file if the system crashes. The log notifies the user on loading the truncated file.

* **aof-rewrite-incremental-fsync yes**{#setting-rewrite-incremental}

   Enables AOF file synchronization every time 32 MB of data is generated.

* **aof-use-rdb-preamble yes**{#setting-rdb-preamble}

   Enables using the RDB file as a prefix to the AOF file when rewriting or restoring it.

For more information on {{ RD }} persistence mechanisms, refer to the [Redis documentation](https://redis.io/topics/persistence) and the [redis.conf](https://github.com/redis/redis/blob/6.0/redis.conf) config file description.

### Disabling persistence {#persistence-off}

With persistence disabled, the following {{ RD }} settings take effect:

* **save ""**

   Regular RDB file saving is disabled.

* **appendonly no**

   AOF (Append Only File) mode is disabled.
