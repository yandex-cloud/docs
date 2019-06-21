# Adding data to {{ CH }}

To add data to the database on a routine basis, use the INSERT query described in the [documentation on {{ CH }}](https://clickhouse.yandex/docs/en/query_language/queries/#insert).

To load a large amount of data, use the [command-line client {{ CH }}](https://clickhouse.yandex/docs/en/interfaces/cli/) that effectively compresses data during transmission. INSERT queries should be sent no more than once per second.

