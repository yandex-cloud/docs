# {{ MY }}

In certain cases, activating a transfer of type _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ terminates with the error `Last binlog file <file name:file size> is more than 4GB`.

It results from an [internal {{ MY }} limitation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_max_binlog_cache_size) and arises when a single transaction log generates over 4 GB of data.

To resolve the problem, [reactivate](../operations/transfer.md#activate) the transfer.
