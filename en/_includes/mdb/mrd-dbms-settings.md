* **Activedefrag**{#settings-activedefrag} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    This setting enables active memory defragmentation in the cluster. It helps reduce memory fragmentation, which can cause low-memory issues. We do not recommend enabling it if you do not have memory fragmentation issues.

    This setting is disabled by default.

    For more information, see [this {{ VLK }} guide](https://redis.io/docs/latest/operate/rs/references/rest-api/objects/bdb).

* **Client output buffer limit normal**{#settings-limit-normal} {{ tag-all }}

    Limit on the output buffer size for regular clients.

    {{ VLK }} uses an output buffer to temporarily store сommand-generated data before it reaches the client. If the client is sending new commands faster than {{ VLK }} can process pending ones, the buffer size increases.

    This setting includes the following parameters:

    * **Hard limit**: Hard buffer size limit, in bytes. If this limit is crossed, the client connection terminates immediately. The minimum value is `0`, i.e., there is no limit. The default value is `0`. To define the units of measurement in the management console, use the **Hard limit unit** setting.
    * **Soft limit**: Soft buffer size limit, in bytes. The client connection terminates only if this limit is exceeded for the period specified in the **Soft seconds** setting. The minimum value is `0`, i.e., there is no limit. The default value is `0`. To define the units of measurement in the management console, use the **Soft limit unit** setting.
    * **Soft seconds**: Time (in seconds) during which the soft buffer limit may be exceeded. The minimum value is `0`. The default value is `0`.

    For more information about this setting, see [this {{ VLK }} guide](https://redis.io/docs/reference/clients/#output-buffer-limits).

* **Client output buffer limit pubsub**{#settings-limit-pubsub} {{ tag-all }}

    Limit on the output buffer size for clients using the [Pub/Sub](https://redis.io/docs/manual/pubsub/) pattern.

    {{ VLK }} uses an output buffer to temporarily store сommand-generated data before it reaches the client. If the client is sending new commands faster than {{ VLK }} can process pending ones, the buffer size increases.

    This setting includes the following parameters:

    * **Hard limit**: Hard buffer size limit, in bytes. If this limit is crossed, the client connection terminates immediately. The minimum value is `0`, i.e., there is no limit. The default value is `33554432` (32 MB). To define the units of measurement in the management console, use the **Hard limit unit** setting.
    * **Soft limit**: Soft buffer size limit, in bytes. The client connection terminates only if this limit is exceeded for the period specified in the **Soft seconds** setting. The minimum value is `0`, i.e., there is no limit. The default value is `8388608` (8 MB). To define the units of measurement in the management console, use the **Soft limit unit** setting.
    * **Soft seconds**: Time (in seconds) during which the soft buffer limit may be exceeded. The minimum value is `0` and the default is `60`.

    For more about this setting, see [this {{ VLK }} article](https://redis.io/docs/reference/clients/#output-buffer-limits).

* **Databases**{#settings-databases} {{ tag-all }}

    Number of databases.

    {{ VLK }} uses logical databases isolated from one another. Operations with keys and values in one database do not affect data in other databases. Each database has a unique number, from `0` to `Databases − 1`.

    The valid values range from `1` to `2147483647`. The default value is `16`.

    For more information, see [this {{ VLK }} guide](https://github.com/redis/redis/blob/6.0/redis.conf#L275).

    {% note warning %}

    Updating this parameter will restart all running {{ VLK }} nodes.

    {% endnote %}

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

    For more information, see [this {{ VLK }} guide](https://docs.redislabs.com/latest/rs/administering/database-operations/eviction-policy/).

* **Notify keyspace events**{#settings-notify-keyspace-events} {{ tag-all }}

    Keyspace event notification setting.

    The setting value is a string of modifiers that manage notification behavior. The default value is an empty string, i.e., notification is disabled.

    For a complete list of modifiers, see [this {{ VLK }} article](http://redis.io/topics/notifications).

* **Slowlog log slower than**{#settings-slowlog-slower-than} {{ tag-all }}

    Commands running longer than the specified time (in microseconds) are considered slow. Such commands end up in the slow log. If the value is `0`, all executed commands are logged.

    The valid values range from `-1` (no slow logging) to `9223372036854775807`. The default value is `10000`.

    For more information, see [this {{ VLK }} guide](https://redis.io/commands/slowlog).

* **Slowlog max len**{#settings-slowlog-max-len} {{ tag-all }}

    Maximum number of entries in the slow log. When the log reaches this limit, the oldest entries are removed before adding new ones.

    The valid values range from `0` (no slow logging) to `9223372036854775807`. The default value is `1000`.

    For more information, see [this {{ VLK }} guide](https://redis.io/commands/slowlog).

* **Timeout**{#settings-timeout} {{ tag-all }}

    Time (in seconds) during which connections to inactive clients remain open.

    The valid values range from `0` (connections stay open) to `2147483647`.

    For more information, see [this {{ VLK }} guide](https://redis.io/topics/clients).
