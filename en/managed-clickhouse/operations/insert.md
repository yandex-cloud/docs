# Adding data to [!KEYREF CH]

To add data to the database on a routine basis, use the INSERT query described in the [documentation on [!KEYREF CH]](https://clickhouse.yandex/docs/ru/query_language/queries/#insert).

To load a large amount of data, use the [command-line client [!KEYREF CH]](https://clickhouse.yandex/docs/ru/interfaces/cli/) that effectively compresses data during transmission. INSERT queries should be sent no more than once per second.

