### Error when accessing a binary log {#binlog-bytes}

The following error may occur during _{{ dt-type-copy-repl}}_ transfers:

```text
Warn(replication): failed to run (abstract1 source):
failed to run canal: failed to start binlog sync:
failed to get canal event: ERROR 1236 (HY000): Could not find first log file name in binary log index file
```

The error occurs when the binary log files required for replication are not available. This is usually due to exceeding the maximum allowed file size after adding new changes to the binary log. In this case, some of the old log data is deleted.

**Solution:**

[Increase](../../../../managed-mysql/operations/update.md#change-mysql-config) the maximum allowed size for the binary log files in the {{ MY }} settings using the [Mdb preserve binlog bytes](../../../../managed-mysql/concepts/settings-list.md#setting-mdb-preserve-binlog-bytes) parameter.

The minimum value is `1073741824` (1 GB), while the maximum one is `107374182400` (100 GB). The default value is `1073741824` (1 GB).
