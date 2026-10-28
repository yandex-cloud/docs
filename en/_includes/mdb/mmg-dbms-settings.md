- **Storage**{#setting-storage} {{ tag-all }}


  - **Journal → Commit interval**{#setting-journal-commit-interval}

    The interval in milliseconds between the saves of {{ SD }} journal data to the disk.

    The minimum value is `1`, the maximum is `500`, and the default is `300`.

    This setting is not available for hosts with the `MONGOS` and `MONGOCFG` roles in a sharded cluster.


  - **Wired tiger**{#setting-wired-tiger}

    Settings for the storage engine:

    - **Collection config → Block compressor**{#setting-block-compressor}

      Data compression option. The value set here only applies to new collections. You can also redefine it for individual collections and indexes.

      - `none`: Compression disabled.
      - `snappy`: Use the [snappy](https://google.github.io/snappy/) library for data compression. If you select this setting, data compression/decompression will be, in most cases, faster than if using the `zlib` library; however, the resulting file size will be 20% to 100% larger.
      - `zlib`: Use the [zlib](http://www.zlib.net/) library for data compression. This method is slower than `snappy` but, in most cases, it achieves better data compression.

      This setting is not available for hosts with the `MONGOS` and `MONGOCFG` roles in a sharded cluster.


    - **Engine config → Cache size gb**{#setting-engine-cache-size-gb}

      Maximum size of the internal cache used for data storage (in GB). This setting does not affect the amount of RAM used to create an index.

      The default value depends on the RAM of the selected [host class](#settings-instance-dependent):

      * `<host_RAM_amount> ≤ 2 GB`: `0.5`.
      * `2 GB < <host_RAM_amount> ≤ 4 GB`: `1`.
      * `<host_RAM_amount> > 4 GB`: Calculated using this formula: `(RAM − 1) ÷ 2`.

      The **Cache size** setting takes priority over the **Cache size gb** setting. If both settings are specified, the **Cache size** value is taken.

      The **Cache size gb** setting is not available for hosts with the `MONGOS` role in a sharded cluster.


    - **Engine config → Cache size**{#setting-engine-cache-size}

      Maximum size of the internal cache used for data storage, as a percentage.

      The minimum value depends on the RAM of the selected [host class](#settings-instance-dependent). The internal cache size must be not less than 0.25 GB, equivalent.

      The maximum value is `90`.

      This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

    - **Index config → Prefix compression**{#setting-prefix-compression}

      Enables or disables prefix compression for indexes. Changing the parameter only affects new indexes, not the existing ones.

      Default value: `true` (prefix compression enabled).

      This setting is not available for hosts with the `MONGOS` and `MONGOCFG` roles in a sharded cluster.


- **Operation profiling**{#setting-operation-profiling} {{ tag-all }}

  DBMS profiler settings. The profiler collects query data and uses it to generate a query optimization strategy.

  - **Mode**{#setting-operation-profiling-mode}
  
    DBMS profiler mode:

    - `off`: Profiling disabled.
    - `slowOp` (default): Only collects information about slow operations (that take longer than the threshold value specified in the [Slow op threshold](#setting-slow-op-threshold) setting).
    - `all`: Collects information about all queries in progress.

    This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.


  - **Slow op sample rate**{#setting-slow-sample-rate}

    The number of slow operations to profile or log. If enabled, this parameter affects diagnostic logging and the profiler.

    The minimum value is `0`, the maximum is `1`, and the default is `1`.

    This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.


  - **Slow op threshold**{#setting-slow-op-threshold}
  
    Sets the operation execution time (in milliseconds). If exceeded, the operation is considered slow.

    Minimum value: `0`; maximum value: `36000000` (10 hours); default: `300`.

    This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.


- **Net**{#setting-net} {{ tag-all }}

  Networking settings.

  - **Max incoming connections**{#setting-max-incoming-connections}

    Maximum number of inbound connections.

    The minimum value is `10`. The maximum value [depends on the selected host class](#settings-instance-dependent) and is equal to the host's RAM volume in MB, with a maximum of `16384`. The default value is `1024`.

    For more information, see [Limits on the number of connections](../../storedoc/operations/connect/index.md#connection-limits).

  - **Compression → Compressors**{#setting-compressors}

    Lists the compression methods that a host with the `MONGOD` or `MONGOS` role can use to compress network messages. The order of the listing is important.

    The `disabled` value disables compression. The default value is `snappy,zstd,zlib`.


- **Audit Log**{#setting-audit-log} {{ tag-all }}

  audit system log settings.

  - **Filter**{#setting-filter}

    This setting decides which audit events to log. An input parameter is any audit message field in JSON string format.

    For example, to log only audit events related to users named `example-user` and `new-user`, specify the following:

    ```json
    { "user": { $in: [ "example-user", "new-user" ] } }
    ```

  {% note info %}

  You can also [configure](../../audit-trails/operations/create-trail.md) exporting cluster [audit logs](../../storedoc/at-ref.md) to a [trail](../../audit-trails/concepts/trail.md) using [{{ at-full-name }}](../../audit-trails/index.yaml).

  {% endnote %}


- **Set parameter**{#setting-set-parameter}

  - **Audit authorization success**{#setting-audit-authorization-success} {{ tag-all }}

    Determines whether the audit system will log successful authorization operations (authCheck). If set to `true`, the system will log both authorized and unauthorized operations.

    The default value is `false` (only failed authorization attempts are logged).

  - **Enable flow control**{#setting-enable-flow-control} {{ tag-all }}

    Decides whether or not to control the rate of primary host's write operations. Enabling this parameter ensures that the _majority committed_ metric for replica hosts will not exceed the set **Flow control target lag seconds** value.

    The default value is `false` (flow control is disabled).

    This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.


  - **Flow control target lag seconds**{#setting-flow-control-target-lag-seconds} {{ tag-all }}

    With the **Enable flow control** setting enabled, the majority of operations will be implemented within the time limit (in seconds) specified in the **Flow control target lag seconds** setting.

    The default value is `10`.

    This setting is available for hosts with the `MONGOD` role only.

  - **Flow control warn threshold seconds**{#setting-flow-control-warn-threshold-seconds} {{ tag-all }}

    With the **Enable flow control** setting enabled, the flow control monitors the majority commit point. If this point does not change within the time period (in seconds) specified in the **Flow control warn threshold seconds** setting, a warning is logged.

    The default value is `10`. The `0` value disables warnings.

    This setting is available for hosts with the `MONGOD` role only.

  - **Migrate clone insertion batch delay ms**{#setting-migrate-clone-insertion-batch-delay-ms} {{ tag-all }}

    Timeout (in ms) between insertion batches at the cloning stage when migrating chunks across shards.

    The default value is `0` (no delays between insertion batches).

    This setting is available for hosts with the `MONGOD` role only.

  - **Migrate clone insertion batch size**{#setting-migrate-clone-insertion-batch-size} {{ tag-all }}

    Maximum number of documents to insert in one batch at the cloning stage when migrating chunks across shards.

    The default value is `0` (the number is unlimited).

    This setting is available for hosts with the `MONGOD` role only.

  - **Min snapshot history window in seconds**{#setting-min-snapshot-history-window-in-seconds} {{ tag-all }}

    Time, in seconds, for snapshot history to be retained.

    Possible values: from zero up. Default value: `60`. Increasing this setting value increases disk usage.

    This setting is available for hosts with the `MONGOD` role only.


  - **Orphan cleanup delay secs**{#setting-orphan-cleanup-delay-secs} {{ tag-all }}

    Minimum delay, in seconds, before deleting a migrated fragment from the source shard.

    The default value is `900` (15 minutes).

    This setting is available for hosts with the `MONGOD` role only.

  - **Persisted chunk cache update max batch size**{#setting-persisted-chunk-cache-update-max-batch-size} {{ tag-all }}

    Maximum number of documents in a batch when updating data in the persisted chunk cache.

    The default value is `1000`.

    This setting is available for hosts with the `MONGOD` role only.

  - **Range deleter batch delay ms**{#setting-range-deleter-batch-delay-ms} {{ tag-all }}

    Delay, in ms, before the next deletion batch at the cleanup stage when migrating chunks across shards (or when running the `cleanupOrphaned` command).

    The default value is `20`.

    This setting is available for hosts with the `MONGOD` role only.

  - **Range deleter batch size**{#setting-range-deleter-batch-size} {{ tag-all }}

    Maximum number of documents per batch to delete at the cleanup stage when migrating chunks across shards (or when running the `cleanupOrphaned` command).

    The default value is `2147483647`.

    This setting is available for hosts with the `MONGOD` role only.

  - **Mirror reads**{#setting-mirror-read} {{ tag-all }}

      Data mirror reads settings.

      - **Sampling rate**{#setting-sampling-rate}

        The master host's sampling rate of mirroring read operations to available replica hosts.

        The value must be in the range from `0.0` (mirroring is disabled) to `1.0` (the master host duplicates all operations that support mirroring to each available replica host).

        The default value is `0.01`.

        This setting is available for hosts with the `MONGOD` role only.

      - **Max time ms**{#setting-max-time-ms}

        Maximum time, in ms, for mirror reads.

        The default value is `1000`.

        This setting is available for hosts with the `MONGOD` role only.

  - **Read hedging mode**{#setting-read-hedging-mode} {{ tag-all }}

    Shows if the `MONGOS` hosts support hedging for reads with the enabled read hedging option.

    The default value is `on`.

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool max size**{#setting-sharding-task-executor-pool-max-size} {{ tag-all }}

    Maximum number of outbound connections each TaskExecutor connection pool can establish to any `MONGOD` host.

    The default value is `32767`.

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool max connecting**{#setting-sharding-task-executor-pool-max-connecting} {{ tag-all }}

    Maximum number of concurrently initiated connections (including pending connections that are being installed or updated) to a `MONGOD` host each TaskExecutor connection pool can support.

    The default value is `2`.

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool min size**{#setting-sharding-task-executor-pool-min-size} {{ tag-all }}

    Minimum number of outbound connections each TaskExecutor connection pool must establish to any `MONGOD` host.

    The default value is `1`.

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool replica set matching**{#setting-sharding-task-executor-pool-replica-set-matching} {{ tag-all }}

    Policy that sets the minimum size of the `MONGOS` host's connection pools for each replica set.

    The possible values are:

    * `automatic` (default): Equal to `matchPrimaryNode`.
    * `matchPrimaryNode`: The minimum size of the `MONGOS` host's connection pools for each replica host equals its master host connection pool.
    * `matchBusiestNode`: The minimum size of the `MONGOS` host's connection pools for each replica host equals the highest number of active connections to the master host and each replica host.
    * `disabled`: The minimum size of the `MONGOS` host's connection pools for each replica host equals the **ShardingTaskExecutorPoolMinSize** setting value.

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool host timeout ms**{#setting-sharding-task-executor-pool-host-timeout-ms} {{ tag-all }}

    The maximum time period, in ms, the `MONGOS` host waits for connection to the host until it terminates all connections to that host.

    The default value is `300000` (five minutes).

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool refresh requirement ms**{#setting-sharding-task-executor-pool-refresh-requirement-ms} {{ tag-all }}

    The maximum time period, in ms, the `MONGOS` host waits before checking the state of an inactive connection in the pool.

    The default value is `60000` (one minute).

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool refresh timeout ms**{#setting-sharding-task-executor-pool-refresh-timeout-ms} {{ tag-all }}

    The maximum time period, in ms, the `MONGOS` host waits for connection to be confirmed.

    The default value is `20000` (20 seconds).

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Warm min connections in sharding task executor pool on startup**{#setting-warm-min-connections-in-sharding-task-executor-pool-on-startup} {{ tag-all }}

    If this setting is enabled, `MONGOS` attempts to establish the minimum number of network connections to each host before starting to accept client connections.

    The default value is `true`.

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Warm min connections in sharding task executor pool on startup wait ms**{#setting-warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms} {{ tag-all }}

    Sets the time period, in ms, for the `MONGOS` host to wait for establishing a connection to each host. This setting only works if the **Warm min connections in sharding task executor pool on startup** setting is enabled.

    The default value is `2000` (two seconds).

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool max size for config servers**{#setting-sharding-task-executor-pool-max-size-for-config-servers} {{ tag-all }}

    The maximum number of outbound connections each TaskExecutor connection pool can establish to any `MONGOCFG` host. This setting overrides the **Sharding task executor pool max size** setting value when applied to `MONGOCFG` hosts.

    The default value is `-1` (the **Sharding task executor pool max size** setting value is used).

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

  - **Sharding task executor pool min size for config servers**{#setting-sharding-task-executor-pool-min-size-for-config-servers} {{ tag-all }}

    The minimum number of outbound connections each TaskExecutor connection pool can establish to any `MONGOCFG` host. This setting overrides the **Sharding task executor pool min size** setting value when applied to `MONGOCFG` hosts.

    The default value is `-1` (the **Sharding task executor pool min size** setting value is used).

    This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

- **Oplog**{#setting-oplog} {{ tag-all }}

  Oplog (log of all operations that change data in a database) settings.

  - **Max size percent**{#setting-max-size-percent}

    Maximum oplog size as a percentage of the disk size.

    The default value is as follows:

    * For `MONGOD` hosts: `5`.
    * For `MONGOCFG` hosts: `0`.

    The minimum acceptable oplog size in MB is `990`. If the percentage of the disk size is less than 990 MB, the oplog size is considered to be 990 MB. The actual default value for `MONGOCFG` hosts is always 990 MB.

    This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

  - **Min retention hours**{#setting-min-retention-hours}

    Minimum number of hours to retain oplog records. This setting allows storing old oplog records for the specified time period, even if new records increase the collection size beyond the set limit.

    The setting value can be a fractional number. For example, `1.5` means one hour and thirty minutes.

    The default value is as follows:

    * For `MONGOD` hosts: `0` (oplog record retention is disabled).
    * For `MONGOCFG` hosts: `24`.

    This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

- **Chaining allowed**{#setting-chaining-allowed} {{ tag-all }}

  Determines whether chain replication is allowed, whereby replica hosts can replicate data from other replica hosts.

  The default value is `true`.

  This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

- **Chunk Size**{#setting-chunk-size} {{ tag-all }}

  Size of each chunk, in MB.

  The maximum value is `1024`; the default value is `128`.

  This setting is only available for hosts with the `MONGOS` role in a sharded cluster.

