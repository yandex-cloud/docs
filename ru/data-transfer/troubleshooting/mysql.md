# {{ MY }}

В некоторых случаях активация трансфера типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ завершается ошибкой `Last binlog file <имя файла:размер файла> is more than 4GB`.

Она обусловлена [внутренним ограничением {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_max_binlog_cache_size) и возникает, когда лог одной транзакции генерирует более 4 ГБ данных.

Для устранения проблемы [активируйте](../operations/transfer.md#activate) трансфер повторно.
