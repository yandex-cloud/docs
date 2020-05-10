# Adding data to {{ CH }}

To regularly add data to the database, use the INSERT query described in the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/queries/#insert).

To upload a large amount of information, use the [{{ CH }} command line client](https://clickhouse.yandex/docs/en/interfaces/cli/), which effectively compresses data during transfers. INSERT queries should be sent no more than once per second.

