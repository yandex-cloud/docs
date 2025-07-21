{% cut "Доступные параметры" %}

* `async` — использовать ли асинхронный режим. Значение: `true` или `false`.

* `buffer_queue_variation` — сколько раз может заполниться буфер, прежде чем его размер будет увеличен.

* `buffer_size` — размер буфера. При переполнении увеличивается до `max_buffer_size`.

* `client_name` — имя клиента.

* `compress` — сжимать ли данные в ответе сервера. Значение: `true` или `false`.

* `compress_algorithm` — какой алгоритм использовать для сжатия данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.

* `compress_level` — уровень сжатия данных.

* `connect_timeout` — максимальное время ожидания подключения к серверу (в миллисекундах).

* `decompress` — распаковывать ли данные в запросе клиента. Значение: `true` или `false`.

* `decompress_algorithm` — какой алгоритм использовать для распаковки данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.

* `decompress_level` — уровень сжатия данных при распаковке.

* `failover` — максимальное число попыток подключения к репликам, если сервер недоступен.

* `load_balancing_policy` — алгоритм выбора реплик для подключения.

    * `firstAlive` — запрос отправляется на первую доступную реплику.
    * `random` — запрос отправляется на любую реплику случайным образом.
    * `roundRobin` — запрос отправляется в соответствии с политикой [Round-robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)).

* `max_buffer_size` — максимальный размер буфера.

* `max_threads_per_client` — максимальное число потоков на один клиент.

* `product_name` — имя продукта в `User-Agent`.

* `read_buffer_size` — размер буфера для чтения данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.

* `request_buffering` — режим буферизации запросов.

    * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
    * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
    * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.

* `request_chunk_size` — размер куска данных в запросе (в байтах).

* `response_buffering` — режим буферизации ответов.

    * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
    * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
    * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.

* `server_time_zone` — часовой пояс.

* `use_server_time_zone` — использовать ли часовой пояс сервера. Значение: `true` или `false`.

* `use_server_time_zone_for_dates` — использовать ли часовой пояс сервера при обработке значений `Date`. Значение: `true` или `false`.

* `use_time_zone` — какой часовой пояс использовать. Пример значения: `Europe/Amsterdam`. Работает, если значение `use_server_time_zone` равно `false`.

* `write_buffer_size` — размер буфера для записи данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.

{% endcut %}