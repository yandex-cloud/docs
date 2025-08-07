{% cut "Available parameters" %}

* `async`: Use of asynchronous mode, `true` or `false`.

* `buffer_queue_variation`: How many times the buffer can be filled up before its size is increased.

* `buffer_size`: Buffer size, increases to `max_buffer_size` on overflow.

* `client_name`: Client name.

* `compress`: Data compression in the server response, `true` or `false`.

* `compress_algorithm`: Data compression algorithm. The possible values are: [BROTLI](https://en.wikipedia.org/wiki/Brotli), [BZ2](https://en.wikipedia.org/wiki/Bzip2), [DEFLATE](https://en.wikipedia.org/wiki/Deflate), [GZIP](https://en.wikipedia.org/wiki/Gzip), [LZ4](https://en.wikipedia.org/wiki/LZ4_(compression_algorithm)), [SNAPPY](https://en.wikipedia.org/wiki/Snappy_(compression)), [XZ](https://en.wikipedia.org/wiki/XZ_Utils), [ZSTD](https://en.wikipedia.org/wiki/Zstd), or `NONE`.

* `compress_level`: Data compression level.

* `connect_timeout`: Maximum server connection timeout, in milliseconds.

* `decompress`: Decompressing data in client request, `true` or `false`.

* `decompress_algorithm`: Data decompression algorithm. The possible values are: [BROTLI](https://en.wikipedia.org/wiki/Brotli), [BZ2](https://en.wikipedia.org/wiki/Bzip2), [DEFLATE](https://en.wikipedia.org/wiki/Deflate), [GZIP](https://en.wikipedia.org/wiki/Gzip), [LZ4](https://en.wikipedia.org/wiki/LZ4_(compression_algorithm)), [SNAPPY](https://en.wikipedia.org/wiki/Snappy_(compression)), [XZ](https://en.wikipedia.org/wiki/XZ_Utils), [ZSTD](https://en.wikipedia.org/wiki/Zstd), or `NONE`.

* `decompress_level`: Data decompression level.

* `failover`: Maximum number of attempts to connect to replicas if the server is unavailable.

* `load_balancing_policy`: Replica selection algorithm for connection.

    * `firstAlive`: Request goes to the first available replica.
    * `random`: Request goes to a random replica.
    * `roundRobin`: Applies the [Round-robin](https://en.wikipedia.org/wiki/Round-robin_scheduling) policy to select a replica.

* `max_buffer_size`: Maximum buffer size.

* `max_threads_per_client`: Maximum number of threads per client.

* `product_name`: Product name in `User-Agent`.

* `read_buffer_size`: Read buffer size, in bytes. The default value is `buffer_size`. When the buffer is full, the size gets increased to `max_buffer_size`.

* `request_buffering`: Request buffering mode.

    * `RESOURCE_EFFICIENT`: Provides moderate performance with minimum use of CPU and RAM. This mode relies only on the buffer size, no queue is used.
    * `PERFORMANCE`: Maximizes performance by actively utilizing CPU and RAM.
    * `CUSTOM`: Allows manual buffering settings to balance out resource utilization and desired performance.

* `request_chunk_size`: Request chunk size, in bytes.

* `response_buffering`: Response buffering mode.

    * `RESOURCE_EFFICIENT`: Provides moderate performance with minimum use of CPU and RAM. This mode relies only on the buffer size, no queue is used.
    * `PERFORMANCE`: Maximizes performance by actively utilizing CPU and RAM.
    * `CUSTOM`: Allows manual buffering settings to balance out resource utilization and desired performance.

* `server_time_zone`: Serve time zone.

* `use_server_time_zone`: Use of the server time zone, `true` or `false`.

* `use_server_time_zone_for_dates`: Use of the server time zone when processing the `Date` values, `true` or `false`.

* `use_time_zone`: What time zone to use, i.e., `Europe/Amsterdam`. Applies if `use_server_time_zone` is `false`.

* `write_buffer_size`: Write buffer size, in bytes. By default, equals `buffer_size`. When the buffer is full, the size gets increased to `max_buffer_size`.

{% endcut %}