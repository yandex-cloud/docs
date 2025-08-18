### The size of a single transaction log exceeds 4 GB {#binlog-size}

Error message:

```text
Last binlog file <file_name>:<file_size> is more than 4GB
```

If the log size of a single transaction exceeds 4 GB, activation of _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfers fails due to {{ MY }} [internal limits](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_max_binlog_cache_size) on the size of a single transaction's log.

**Solution:** [Reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
