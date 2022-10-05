# Replication and fault tolerance

{{ mrd-name }} uses standard Redis replication and provides high availability of cluster data using Redis Sentinel.

## Replication {#replication}

{{ mrd-name }} clusters use asynchronous replication: the result of a write request is reflected on the master host, which then forwards the data to the cluster replicas. The replication process does not affect the master availability in any way, but it can make replicas temporarily unavailable (for up to a few seconds for large databases) when loading new data into memory.

Because of replication's asynchronous nature, data on replicas may be out of date: while a replica is processing updates from the master, it continues sending existing data in response to requests ([replica-serve-stale-data yes](http://download.redis.io/redis-stable/redis.conf) flag is set).

Because of resource limitations, **b1.nano**, **b1.small**, and **b2.nano** hosts are not replicated.

For more information about how replication works in {{ RD }}, read the [DBMS documentation](https://redis.io/topics/replication).

## Fault tolerance {#availability}

A master host can be changed both automatically as a result of a failure and [manually](../operations/failover.md). Manual master switching is available both for a [sharded cluster](./sharding.md#failover) and an unsharded one.

High data availability in an unsharded cluster is implemented using Redis Sentinel: in a cluster consisting of three or more hosts, Sentinel services automatically manage master selection and replica configurations.

In order to make decisions about cluster performance, the majority of Sentinel services need to be healthy. As a result, it's more cost-efficient to deploy clusters with an odd number of hosts when working with {{ mrd-name }}. For example, a cluster with three hosts can lose one host and continue working, while a cluster with four hosts can also lose no more than one host: if a second host is lost, the remaining Sentinel instances will not be enough to select a new master.

A cluster consisting of two hosts does not provide full failover for the same reason: one of the two Sentinel instances will not be enough to assign one host as a master if the other one failed. In this situation, the cluster can only process read operations.

Owners of {{ mrd-name }} clusters can't configure Sentinel services, but they can read the information that the services provide. Read more about Sentinel in the [DBMS documentation](https://redis.io/topics/sentinel).

### Assigning a different host as a master if the primary master fails {#master-failover}

If the master host fails, any of the cluster hosts available for replication becomes a new master. If the master assignment priority is set for the cluster hosts, the host with the lowest priority is selected as a new master. The minimum value is `0` and the maximum (default) value is `100`. A host with the `0` priority will never be selected as a master.

## Persistence {#persistence}

{{ mrd-name }} clusters use data persistence presets. You can disable persistence, if required, to improve server throughput because the DBMS will stop writing updates out to disk.

{% note warning %}

Only disable persistence if data integrity is unimportant to your application, for instance when using {{ mrd-name }} as cache. This will cause the most recent data captured in {{ RD }} to be stored in RAM only and to become lost if a server crashes.

{% endnote %}

### Persistence settings {#persistence-on}

By default, cluster persistence is enabled and uses the following {{ RD }} settings:

* **save ""**{#setting-save-rdb}

   Regular RDB file saving is disabled. [AOF](#setting-appendonly) mode is used instead.

* **appendonly yes**{#setting-appendonly}

   AOF (Append Only File) mode is enabled. In this mode, Redis logs every write operation without changing already written data.

* **no-appendfsync-on-rewrite yes**{#setting-no-appendfsync}

   Since the AOF `fsync` policy is set to `everysec`, the AOF log background`BGSAVE` save or `BGREWRITEAOF` rewrite processes perform a lot of disk I/O. {{ RD }} can block `fsync()` calls for too long in some Linux configurations.

   The setting prevents calling `fsync()` within the main system process when running `BGSAVE` or `BGREWRITEAOF`.

   When `BGREWRITEAOF` is running, `fsync()` is called. {{ RD }} writes the shortest sequence of commands required to restore the current dataset to memory. You can control data size using the [aof-rewrite-incremental-fsync](#setting-rewrite-incremental) setting.

* **auto-aof-rewrite-percentage 100**{#setting-rewrite-percentage}

   The AOF log size must exceed 100% for the AOF file to be automatically rewritten. Depends on the log file's [**auto-aof-rewrite-min-size**](#setting-rewrite-size) setting.

* **auto-aof-rewrite-min-size 64mb**{#setting-rewrite-size}

   Auto-aof-rewrite-min-size 64mb

* **aof-load-truncated yes**{#setting-load-truncated}

   Allows loading a truncated AOF file if the system crashes. A notice of loading the truncated file is logged.

* **aof-rewrite-incremental-fsync yes**{#setting-rewrite-incremental}

   Enables AOF file synchronization every time 32 MB of data is generated.

* **aof-use-rdb-preamble yes**{#setting-rdb-preamble}

   Enables using the RDB file as a preamble to the AOF file when rewriting or restoring it.

For more information on {{ RD }} persistence mechanisms, refer to the [DBMS documentation](https://redis.io/topics/persistence) and the [redis.conf](https://github.com/redis/redis/blob/6.0/redis.conf) config file description.

### Disabling persistence {#persistence-off}

With persistence disabled, the following {{ RD }} settings take effect:

* **save ""**

   Regular RDB file saving is disabled.

* **appendonly no**

   The AOF (Append Only File) is disabled.
