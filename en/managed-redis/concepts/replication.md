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

## Redis persistence settings {#persistence-settings}

{{ mrd-name }} clusters use the preset persistence settings that you cannot change:

* **save ""**{#setting-save-rdb}

  Regular RDB file saving is disabled. Instead, [AOF](#setting-appendonly) mode is used.

* **appendonly yes**{#setting-appendonly}

  AOF (Append Only File) mode is enabled. In this mode, Redis logs every write operation without changing the data written before.

* **no-appendfsync-on-rewrite yes**{#setting-no-appendfsync}

  Since the AOF `fsync` policy is set to `everysec`, the AOF log's background save (`BGSAVE`) or rewrite (`BGREWRITEAOF`) process performs many disk I/O operations. {{ RD }} may block calling `fsync()` for too long in some Linux configurations.

  The setting prevents calling `fsync()` within the main system process when running `BGSAVE` or `BGREWRITEAOF`.

  When you run `BGREWRITEAOF`, `fsync()` is in progress. {{ RD }} writes the shortest sequence of commands needed to rebuild the current dataset in memory. You can adjust the data size using the [aof-rewrite-incremental-fsync](#setting-rewrite-incremental) setting.

* **auto-aof-rewrite-percentage 100**{#setting-rewrite-percentage}

  The AOF log size must exceed 100% for the AOF file to be automatically rewritten. Depends on the log file's [**auto-aof-rewrite-min-size**](#setting-rewrite-size) setting value.

* **auto-aof-rewrite-min-size 64mb**{#setting-rewrite-size}

  The minimum size that triggers the AOF file rewrite process is 64 MB.

* **aof-load-truncated yes**{#setting-load-truncated}

  Allows loading a truncated AOF file if the system crashes. A notice of loading the truncated file is logged.

* **aof-rewrite-incremental-fsync yes**{#setting-rewrite-incremental}

  Enables AOF file synchronization every time 32 MB of data is generated.

* **aof-use-rdb-preamble yes**{#setting-rdb-preamble}

  Enables using the RDB file as a preamble to the AOF file when rewriting or restoring it.

For more information about {{ RD }} persistence options, see the [DBMS documentation](https://redis.io/topics/persistence) and the [redis.conf](https://github.com/redis/redis/blob/6.0/redis.conf) file description.

