- **Net → Max incoming connections** {#setting-max-incoming-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Maximum number of inbound connections. 

  The minimum value is `10` and the maximum value is equal to the number of MB of RAM on the host. Defaults to `1024`.

  For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/administration/analyzing-mongodb-performance/#number-of-connections).

- **Operation profiling** {#setting-operation-profiling} {{ tag-con }} {{ tag-cli }} {{ tag-api }}
  
  DBMS profiler settings. The profiler collects query data to determine a query optimization strategy.

  - **Mode** {#setting-operation-profiling-mode}

    DBMS profiler mode:
    - `off`: Profiling is disabled.
    - `slowOp` (default): Information is only collected about slow operations (that take longer than the threshold value set by the [Slow op threshold](#settings-slow-op-threshold) setting).
    - `all`: Information about all running queries is collected.

    For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/administration/analyzing-mongodb-performance/#database-profiling).

  - **Slow op threshold** {#setting-slow-op-threshold}

    Sets the operation execution time (in milliseconds). If exceeded, the operation is considered slow. {#settings-slow-op-threshold}

    The minimum value is `0` and the maximum value is `36000000` (10 hours). Defaults to `300`.

    For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/tutorial/manage-the-database-profiler/#specify-the-threshold-for-slow-operations).

- **Storage** {#setting-storage} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Settings for {{ MG }} interaction with the [storage engine](https://docs.mongodb.com/manual/core/storage-engines/).

  - **Journal → Commit interval** {#setting-journal-commit-interval}

    The interval (in milliseconds) between when {{ MG }} [journal data](https://docs.mongodb.com/manual/core/journaling/) is written to disk.

    The minimum value is `1` and the maximum value is `500`. Defaults to `300`.

    For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.journal.commitIntervalMs).

  - **Wired tiger** {#setting-wired-tiger}

    Settings for the [storage engine](https://docs.mongodb.com/manual/core/wiredtiger/):

    - **Connection config → Block compressor** {#setting-block-compressor}

      Data compression option. The value set here only applies to new collections. You can also override it for [individual collections](https://docs.mongodb.com/manual/reference/method/db.createCollection/#create-collection-storage-engine-options) and [indexes](https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/#options).

      - `none`: Compression is disabled.
      - `snappy`: Data is compressed using the [snappy](https://google.github.io/snappy/) library. If you select this setting, data compression and decompression will, in most cases, be faster than if you use the `zlib` library, but the resulting file size will be 20%–100% larger.
      - `zlib`: Data is compressed using the [zlib](http://www.zlib.net/) library. This method is slower than using the `snappy` library, but, in most cases, it compresses data better.

      For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.collectionConfig.blockCompressor).

    - **Engine config → Cache size gb** {#setting-engine-cache-size}

      The maximum size of the internal cache used for data storage (in GB). This setting does not affect the amount of RAM used to create an index.

      The minimum value is `0.25` and the maximum value is 90% of the host's RAM. Defaults to 50% of the host's RAM.

      For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizeGB).

