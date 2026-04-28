* **Activedefrag**{#settings-activedefrag} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    This setting enables active memory defragmentation in the cluster. It helps reduce memory fragmentation, which can cause low-memory issues. We do not recommend enabling it if you do not have memory fragmentation issues.

    This setting is disabled by default.

    For more information, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L2291).

* **Allow data loss**{#settings-allow-data-loss} {{ tag-all }}

    When enabled, if the current master fails, the cluster may fail over to a replica that does not contain the most recent records. This may result in data loss. If most hosts reside in a single availability zone, {{ VLK }} will continue to operate despite the missing records.

    When disabled, master failover will be delayed until the replicas are fully synchronized to prevent data loss. However, if more than 50% of hosts fail simultaneously, a new master will not be selected, and write operations will be unavailable. In this case, you will need to manually select a new master, but all data will be preserved and saved after selecting a master and synchronizing replicas.

    This setting is disabled by default.

* **Aof max size percent**{#settings-aof-max-size} {{ tag-all }}

    Maximum [AOF file](../../managed-valkey/concepts/replication.md#persistence) size as a percentage of the total disk space. When this limit is exceeded, new write requests are blocked to prevent disk overflow.

    The valid values range from `1` to `100`. The default value is `99`.

* **Client output buffer limit normal**{#settings-limit-normal} {{ tag-all }}

    Limit on the output buffer size for regular clients.

    {{ VLK }} uses an output buffer to temporarily store command-generated data before it reaches the client. If the client is sending new commands faster than {{ VLK }} can process pending ones, the buffer size increases.

    This setting includes the following parameters:

    * **Hard limit**: Hard buffer size limit, in bytes. If this limit is crossed, the client connection terminates immediately. The minimum value is `0`, i.e., there is no limit. The default value depends on the network speed limits, which are specific to the VM configuration. To define the units of measurement in the management console, use the **Hard limit unit** setting.
    * **Soft limit**: Soft buffer size limit, in bytes. The client connection terminates only if this limit is exceeded for the period specified in the **Soft seconds** setting. The minimum value is `0`, i.e., there is no limit. The default value is `<Hard_limit_value>/2`. To define the units of measurement in the management console, use the **Soft limit unit** setting.
    * **Soft seconds**: Time (in seconds) during which the soft buffer limit may be exceeded. The minimum value is `0`. The default value is `60`.

    For more information about this setting, see [this {{ VLK }} guide](https://valkey.io/topics/clients/#output-buffer-limits).

* **Client output buffer limit pubsub**{#settings-limit-pubsub} {{ tag-all }}

    Limit on the output buffer size for clients using the [Pub/Sub](https://valkey.io/topics/pubsub/) pattern.

    {{ VLK }} uses an output buffer to temporarily store command-generated data before it reaches the client. If the client is sending new commands faster than {{ VLK }} can process pending ones, the buffer size increases.

    This setting includes the following parameters:

    * **Hard limit**: Hard buffer size limit, in bytes. If this limit is crossed, the client connection terminates immediately. The minimum value is `0`, i.e., there is no limit. The default value is `33554432` (32 MB). To define the units of measurement in the management console, use the **Hard limit unit** setting.
    * **Soft limit**: Soft buffer size limit, in bytes. The client connection terminates only if this limit is exceeded for the period specified in the **Soft seconds** setting. The minimum value is `0`, i.e., there is no limit. The default value is `8388608` (8 MB). To define the units of measurement in the management console, use the **Soft limit unit** setting.
    * **Soft seconds**: Time (in seconds) during which the soft buffer limit may be exceeded. The minimum value is `0` and the default is `60`.

    For more information about this setting, see [this {{ VLK }} guide](https://valkey.io/topics/clients/#output-buffer-limits).

* **Cluster allow pubsubshard when down**{#settings-cluster-allow-pubsub} {{ tag-all }}

    When enabled, hosts are allowed to serve application requests to [sharded Pub/Sub channels](https://valkey.io/topics/pubsub#sharded-pub-sub) and forward them to the dedicated hash slot of the shard even when the cluster is down.

    This setting is disabled by default.

    For more information, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L1762).

* **Cluster allow reads when down**{#settings-cluster-allow-reads} {{ tag-all }}

    When enabled, hosts are allowed to serve read requests while the cluster is down. This setting is useful in the following cases:

    * The client application does not require data consistency during replica failures or network connectivity issues.
    * You need to maintain read access to hosts in one or two shard clusters when the shard's master host is unavailable.

    This setting is disabled by default.

    For more information, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L1746).

* **Cluster require full coverage**{#settings-cluster-require-full-coverage} {{ tag-all }}

     When enabled, hosts stop accepting queries if at least one hash slot is uncovered (i.e., no available host is serving it). This way, if any of the cluster hash slots are unavailable, the entire cluster becomes unavailable.

    This setting is disabled by default. This means available cluster hosts will continue serving requests for those hash slots that remain available.

    For more information, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L1723).

* **Databases**{#settings-databases} {{ tag-all }}

    Number of databases.

    {{ VLK }} uses logical databases isolated from one another. Operations with keys and values in one database do not affect data in other databases. Each database has a unique number, from `0` to `Databases − 1`.

    The valid values range from `1` to `2147483647`. The default value is `16`.

    For more information, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L379).

    {% note warning %}

    Updating this parameter will restart all running {{ VLK }} nodes.

    {% endnote %}

* **Io threads allowed**{#settings-io-threads-allowed} {{ tag-all }}

    When enabled, read and write operations are processed by separate I/O threads to boost performance of non-sharded clusters. We do not recommend enabling this setting in clusters where hosts have fewer than four CPU cores.

    This setting is disabled by default.

    For more information, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L1317).

* **Lfu decay time**{#settings-lfu-decay-time} {{ tag-all }}

    Configures the `volatile-lfu` and `allkeys-lfu` [memory management policies](#settings-maxmemory-policy). This setting defines the time interval in minutes after which a key’s LFU counter (key popularity indicator) decays.

    The minimum value is `0` (LFU counter never decays) and the default is `1`.

    For more information, see [this {{ VLK }} guide](https://valkey.io/topics/lru-cache/#the-lfu-mode).

* **Lfu log factor**{#settings-lfu-log-factor} {{ tag-all }}

    Configures the `volatile-lfu` and `allkeys-lfu` [memory management policies](#settings-maxmemory-policy). It controls how quickly the LFU counter (key popularity indicator) increases as the frequency of use grows. Effectively, each value sets a precision level for distinguishing between the most and least frequently used keys.

    The parameter applies on every key access using the following logic:

    1. A random number R (0 to 1) is generated.
    1. The probability P for incrementing the counter is calculated as follows:

       ```text
       1 / (<current_LFU_counter_value> × lfu_log_factor + 1)
       ```

    1. The counter increments by one if R < P.

    The minimum value is `0` and the default is `10`.

    For more information, see [this {{ VLK }} guide](https://valkey.io/topics/lru-cache/#the-lfu-mode).

* **Lua time limit**{#settings-lua-time-limit} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Maximum Lua script execution time, in milliseconds.

    The valid values range from `0` to `5000`. The default value is `5000`. If `0`, execution time is unlimited.

    Changes do not affect an already running script.

    For more information, see [this {{ RD }} article](https://github.com/redis/redis/blob/6.0/redis.conf#L1203).

* **Maxmemory percent**{#settings-maxmemory-percent} {{ tag-all }}

    Maximum percentage of RAM to allocate for user data on {{ mrd-name }} cluster hosts.

    The valid values range from `1` to `75`. The default value is `75`.

    {% note info %}

    Reducing the maximum percentage decreases the database capacity. This may be helpful if the database experiences OOM Killer issues.

    {% endnote %}

* **Maxmemory policy**{#settings-maxmemory-policy} {{ tag-all }}

    Memory management mode when low on memory.

    * `volatile-lru`: Delete keys with expired TTL starting with the least recently used (LRU) one.
    * `volatile-lfu`: Delete keys with expired TTL starting with the least frequently used (LFU) one.
    * `volatile-ttl`: Delete keys with expired TTL starting with the shortest TTL one.
    * `volatile-random`: Delete keys with expired TTL in random order.
    * `allkeys-lru`: Delete keys regardless of their TTL starting with the least recently used one.
    * `allkeys-lfu`: Delete keys regardless of their TTL starting with the least frequently used one.
    * `allkeys-random`: Delete keys regardless of their TTL in any order.
    * `noeviction`: Do not delete keys and return an error if there is not enough memory to insert data. This is the default setting.

    For more information, see [this {{ VLK }} guide](https://valkey.io/topics/lru-cache).

* **Notify keyspace events**{#settings-notify-keyspace-events} {{ tag-all }}

    Keyspace event notification setting.

    The setting value is a string of modifiers that manage notification behavior. The default value is an empty string, i.e., notification is disabled.

    For a complete list of modifiers, see [this {{ VLK }} article](https://valkey.io/topics/notifications).

* **Repl backlog size percent**{#settings-repl-backlog-size} {{ tag-all }}

    Size of the replication log on the master, as a percentage of disk size. The larger the log size, the longer the replica can remain operational if the master is unavailable over the network.

    For more information, see [this {{ VLK }} article](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L740).

* **Slowlog log slower than**{#settings-slowlog-slower-than} {{ tag-all }}

    Commands running longer than the specified time (in microseconds) are considered slow. Such commands end up in the slow log. If the value is `0`, all executed commands are logged.

    The valid values range from `-1` (no slow logging) to `9223372036854775807`. The default value is `10000`.

    For more information, see [this {{ VLK }} guide](https://valkey.io/commands/slowlog).

* **Slowlog max len**{#settings-slowlog-max-len} {{ tag-all }}

    Maximum number of entries in the slow log. When the log reaches this limit, the oldest entries are removed before adding new ones.

    The valid values range from `0` (no slow logging) to `9223372036854775807`. The default value is `1000`.

    For more information, see [this {{ VLK }} guide](https://valkey.io/commands/slowlog).

* **Timeout**{#settings-timeout} {{ tag-all }}

    Time (in seconds) during which connections to inactive clients remain open.

    The valid values range from `0` (connections stay open) to `2147483647`.

    For more information, see [this {{ VLK }} guide](https://valkey.io/topics/clients).

* **Turn before switchover**{#settings-turn-before-switchover} {{ tag-all }}

    When enabled, the [host state management agent](../../managed-valkey/concepts/replication.md#availability) switches the replica over to the new master’s host before appointing a new master.

    This setting is disabled by default.

* **Use luajit**{#settings-use-luajit} {{ tag-all }}

    When enabled, [LuaJIT](https://luajit.org/) is used to process Lua scripts. This can speed up processing if scripts are used extensively.

    This setting is disabled by default.

* **Zset max listpack entries**{#settings-zset-max-listpack} {{ tag-all }}

    If the number of [sorted set](https://valkey.io/topics/sorted-sets/) elements is below the specified value, a special encoding will apply to the array elements to reduce the occupied space.

    For more information, see [this {{ VLK }} guide](https://github.com/valkey-io/valkey/blob/8.0/valkey.conf#L2047).
