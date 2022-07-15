* **Databases**{#settings-databases} {{ tag-all }}

    Number of databases.

    {{ RD }} uses the concept of logical databases that are isolated from each other. Operations with keys and values in one database do not affect data in other databases. Each database is identified by its own number (from `0` to `Databases − 1`).

    The minimum value is `0` and the maximum value is `2147483647`. Defaults to `16`.

    For more information, see the [{{ RD }} documentation](https://github.com/redis/redis/blob/6.0/redis.conf#L275).

    {% note warning %}

    If this parameter is changed, all running {{ RD }} nodes will be restarted.

    {% endnote %}

* **Maxmemory policy**{#settings-maxmemory-policy} {{ tag-all }}

    Memory management mode when there is not enough memory.
    * `volatile-lru`: Delete keys whose TTL has expired, starting with the least recently used (LRU) key.
    * `volatile-lfu`: Delete expired keys, starting with the least frequently used (LFU) key.
    * `volatile-ttl`: Delete expired keys, starting with the key with the lowest TTL.
    * `volatile-random`: Delete expired keys in random order.
    * `allkeys-lru`: Delete keys regardless of their TTL, starting with the least recently used one.
    * `allkeys-lfu`: Delete keys regardless of their TTL, starting with the least frequently used one.
    * `allkeys-random`: Delete keys in any order regardless of their TTL.
    * `noeviction` (default): Do not delete keys. Return an error if there is not enough memory to insert the data.

    For more information, see the [{{ RD }} documentation](https://docs.redislabs.com/latest/rs/administering/database-operations/eviction-policy/).

* **Notify keyspace events**{#settings-notify-keyspace-events} {{ tag-all }}

    Configure notifications about keyspace events.

    The value is a string with modifiers that control the output of notifications. The default value is an empty string (notification output is disabled).

    For a complete list of modifiers, see the [{{ RD }} documentation](http://redis.io/topics/notifications).

* **Slowlog log slower than**{#settings-slowlog-slower-than} {{ tag-all }}

    Queries that run longer than the specified time (in microseconds) are considered slow. These queries are logged to the slow log. If the value is `0`, all queries being run are logged there.

    The minimum value is `-1` (the slow log is not kept) and the maximum value is `9223372036854775807`. Defaults to `10000`.

    For more information, see the [{{ RD }} documentation](https://redis.io/commands/slowlog).

* **Slowlog max len**{#settings-slowlog-max-len} {{ tag-all }}

    Maximum number of entries in the slow queries log. When the log is at its maximum length, before inserting new entries, the oldest ones are removed.

    The minimum value is `0` (the slow log is not kept) and the maximum value is `9223372036854775807`. Defaults to `1000`.

    For more information, see the [{{ RD }} documentation](https://redis.io/commands/slowlog).

* **Timeout**{#settings-timeout} {{ tag-all }}

    The time (in seconds) during which a connection to an inactive client is maintained.

    The minimum and default value is `0` (connections are not terminated) and the maximum value is `2147483647`.

    For more information, see the [{{ RD }} documentation](https://redis.io/topics/clients).

