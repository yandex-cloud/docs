### Размер лога одной транзакции превышает 4 ГБ {#binlog-size}

Текст ошибки:

```text
Last binlog file <имя_файла:размер_файла> is more than 4GB
```

Если размер лога одной транзакции превышает 4 ГБ, активация трансферов _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ завершается ошибкой из-за [внутренних ограничений](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_max_binlog_cache_size) {{ MY }} на размер лога одной транзакции.

**Решение:** [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
