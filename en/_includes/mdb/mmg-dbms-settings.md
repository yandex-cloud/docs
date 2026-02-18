- **Storage**{#setting-storage} {{ tag-all }}

  {% note info %}

  This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

  Hosts with the `MONGOCFG` role only have the **Engine config → Cache size gb** setting available.

  {% endnote %}


  - **Journal → Commit interval**{#setting-journal-commit-interval}
  
    The interval in milliseconds between the saves of {{ SD }} journal data to the disk.

    The valid values range from `1` to `500`. The default value is `300`.


  - **Wired tiger**{#setting-wired-tiger}
  
    Settings for the storage engine:
    
    - **Collection config → Block compressor**{#setting-block-compressor}
    
      Data compression option. The value set here only applies to new collections. You can also redefine it for individual collections and indexes.

      - `none`: Compression disabled.
      - `snappy`: Use the [snappy](https://google.github.io/snappy/) library for data compression. If you select this setting, data compression/decompression will be, in most cases, faster than if using the `zlib` library; however, the resulting file size will be 20% to 100% larger.
      - `zlib`: Use the [zlib](http://www.zlib.net/) library for data compression. This method is slower than `snappy` but, in most cases, it achieves better data compression.


    - **Engine config → Cache size gb**{#setting-engine-cache-size}

      Maximum size of the internal cache used for data storage (in GB). This setting does not affect the amount of RAM used to create an index.

      Minimum value: `0.25` (256 MB). The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are calculated as follows:

      - Maximum value: `0.9 × <host_RAM_amount>`.
      - Default value: `0.5 × <host_RAM_amount>`.

      For example, for {{ s1-medium }} class hosts, the maximum value is `28.8` and the default value is `16`.


    - **Index config → Prefix compression**{#setting-prefix-compression}

      Enables or disables prefix compression for indexes. Changing the parameter only affects new indexes, not the existing ones.

      Default value: `true` (prefix compression enabled).


- **Operation profiling**{#setting-operation-profiling} {{ tag-all }}

  {% note info  %}

  These settings are not available for hosts with the `MONGOS` role in a sharded cluster.

  {% endnote %}

  DBMS profiler settings. The profiler collects query data and uses it to generate a query optimization strategy.

  - **Mode**{#setting-operation-profiling-mode}
  
    DBMS profiler mode:

    - `off`: Profiling disabled.
    - `slowOp` (default): Only collects information about slow operations (that take longer than the threshold value specified in the [Slow op threshold](#setting-slow-op-threshold) setting).
    - `all`: Collects information about all queries in progress.


  - **Slow op sample rate**{#setting-slow-sample-rate}

    The number of slow operations to profile or log. If enabled, this parameter affects diagnostic logging and the profiler.

    Minimum value: `0`; maximum value: `1`; default: `1`.


  - **Slow op threshold**{#setting-slow-op-threshold}
  
    Sets the operation execution time (in milliseconds). If exceeded, the operation is considered slow.

    Minimum value: `0`; maximum value: `36000000` (10 hours); default: `300`.


- **Net**{#setting-net} {{ tag-all }}

  Networking settings.

  - **Max incoming connections**{#setting-max-incoming-connections}

    Maximum number of inbound connections.

    The minimum value is `10`. The maximum value [depends on the selected host class](#settings-instance-dependent) and is equal to the host's RAM volume in MB, with a maximum of `16384`. The default value is `1024`.

    For more information, see [Connection limits](../../storedoc/operations/connect/index.md#connection-limits).

  - **Compression → Compressors**{#setting-compressors}

    Lists the compression methods that a host with the `MONGOD` or `MONGOS` role can use to compress network messages. The order of the listing is important.

    The `disabled` value disables compression. Default value: `snappy,zstd,zlib`.


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

  - **Enable flow control**{#setting-enable-flow-control} {{ tag-all }}

    Decides whether or not to control the rate of primary host's write operations. Enabling this parameter ensures that the "majority commited" metric for replica hosts will not exceed the pre-configured value of 10 seconds.

    Default value: `false` (flow control disabled).


  - **Min snapshot history window in seconds**{#setting-min-snapshot-history-window-in-seconds} {{ tag-all }}

    {% note info %}

    This setting is available for hosts with the `MONGOD` role only.

    {% endnote %}

    Time, in seconds, for snapshot history to be retained.

    Possible values: from zero up. Default value: `60`. Increasing this setting value increases disk usage.


