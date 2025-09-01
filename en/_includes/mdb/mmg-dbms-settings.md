

- **Net**{#setting-net} {{ tag-all }}

  Networking settings.

  - **Max incoming connections**{#setting-max-incoming-connections}

    Maximum number of inbound connections.

    The minimum value is `10`. The maximum value [depends on the selected host class](#settings-instance-dependent) and is equal to the host's RAM volume in MB, with a maximum of `16384`. Default value: `1024`.

    For more information, see [Connection limits](../../storedoc/operations/connect/index.md#connection-limits).

  - **Compression → Compressors**{#setting-compressors}

    Lists the compression methods that a host with the `MONGOD` or `MONGOS` role can use to compress network messages. The order of the listing is important.

    The `disabled` value disables compression. Default value: `snappy,zstd,zlib`.

    For more information, see the [{{ MG }} documentation](https://mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-net.compression.compressors).

- **Operation profiling**{#setting-operation-profiling} {{ tag-all }}

  {% note info %}

  These settings are not available for hosts with the `MONGOS` role in a sharded cluster.

  {% endnote %}

  DBMS profiler settings. The profiler collects query data and then uses it to determine a query optimization strategy.

  - **Mode**{#setting-operation-profiling-mode}
  
    DBMS profiler mode:

    - `off`: Profiling disabled.
    - `slowOp` (default): Only collects information about slow operations (that take longer than the threshold value specified in the [Slow op threshold](#setting-slow-op-threshold) setting).
    - `all`: Collects information about all queries in progress.

    For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/administration/analyzing-mongodb-performance/#database-profiling).

  - **Slow op sample rate**{#setting-slow-sample-rate}

    The number of slow operations to profile or log. If enabled, this parameter affects diagnostic logging and the profiler.

    Minimum value: `0`; maximum value: `1`; default: `1`.

    For more information, see the [{{ MG }} documentation](https://mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpSampleRate).

  - **Slow op threshold**{#setting-slow-op-threshold}
  
    Sets the operation execution time (in milliseconds). If exceeded, the operation is considered slow.

    Minimum value: `0`; maximum value: `36000000` (10 hours); default: `300`.

    For more information, see the [{{ MG }}](https://docs.mongodb.com/manual/tutorial/manage-the-database-profiler/#specify-the-threshold-for-slow-operations) documentation.


- **Set parameter**{#setting-set-parameter}

  - **Enable flow control**{#setting-enable-flow-control} {{ tag-all }}

    Decides whether or not to control the rate of primary host's write operations. Enabling this parameter ensures that the "majority commited" metric for replica hosts will not exceed the pre-configured value of 10 seconds.

    Default value: `false` (flow control disabled).

    For more information, see the [{{ MG }} documentation](https://mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.enableFlowControl).

  - **Min snapshot history window in seconds**{#setting-min-snapshot-history-window-in-seconds} {{ tag-all }}

    {% note info %}

    This setting is available for hosts with the `MONGOD` role only.

    {% endnote %}

    Time, in seconds, for snapshot history to be retained.

    Possible values: from zero up. Default value: `60`. Increasing this setting value increases disk usage.

    For more information, see the [{{ MG }} documentation](https://mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.minSnapshotHistoryWindowInSeconds).

- **Storage**{#setting-storage} {{ tag-all }}

  {% note info %}

  This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

  Hosts with the `MONGOCFG` role only have the **Engine config → Cache size gb** setting available.

  {% endnote %}

  Settings that define how {{ SD }} works with the [storage](https://docs.mongodb.com/manual/core/storage-engines/).

  - **Journal → Commit interval**{#setting-journal-commit-interval}
  
    The interval in milliseconds between when {{ SD }} [journal data](https://docs.mongodb.com/manual/core/journaling/) is written to disk.

    Minimum value: `1`; maximum value: `500`; default: `300`.

    For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.journal.commitIntervalMs).

  - **Wired tiger**{#setting-wired-tiger}
  
    Settings for the [storage engine](https://docs.mongodb.com/manual/core/wiredtiger/):
    
    - **Collection config → Block compressor**{#setting-block-compressor}
    
      Data compression option. The value set here only applies to new collections. You can also redefine it for [individual collections](https://docs.mongodb.com/manual/reference/method/db.createCollection/#create-collection-storage-engine-options) and [indexes](https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/#options).

      - `none`: Compression disabled.
      - `snappy`: Use the [snappy](https://google.github.io/snappy/) library for data compression. If you select this setting, data compression/decompression will be, in most cases, faster than if using the `zlib` library; however, the resulting file size will be 20% to 100% larger.
      - `zlib`: Use the [zlib](http://www.zlib.net/) library for data compression. This method is slower than `snappy` but, in most cases, it achieves better data compression.

      For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.collectionConfig.blockCompressor).

    - **Engine config → Cache size gb**{#setting-engine-cache-size}

      Maximum size of the internal cache used for data storage (in GB). This setting does not affect the amount of RAM used to create an index.

      Minimum value: `0.25` (256 MB). The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are determined by these formulas:

      - Maximum value: `0.9 × <host_RAM_amount>`.
      - Default value: `0.5 × <host_RAM_amount>`.

      For example, for {{ s1-medium }} class hosts, the maximum value is `28.8` and the default value is `16`.

      For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizeGB).

    - **Index config → Prefix compression**{#setting-prefix-compression}

      Enables or disables prefix compression for indexes. Changing the parameter only affects new indexes, not the existing ones.

      Default value: `true` (prefix compression enabled).

      For more information, see the [{{ MG }} documentation](https://mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.indexConfig.prefixCompression).
