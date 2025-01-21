### Unable to get a binary log position {#binlog-position}

Error message:

```text
unable to get binlog position: Storage <source_address> is not master
```

You may get this error when activating _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfers if the data source is a custom {{ MY }} installation and binary log file position based replication is set up incorrectly.

**Solution**:

Run the following checks in {{ MY }}:

* Make sure the master is used as the replication source.

* Make sure the [log_bin]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#option_mysqld_log-bin) parameter specifices the correct path to the binary log file location.

* Enter the binary log information using the [SHOW MASTER STATUS]({{ my.docs }}/refman/8.0/en/show-master-status.html) request (for {{ MY }} 5.7 and 8.0) or the [SHOW BINARY LOG STATUS]({{ my.docs }}/refman/8.4/en/show-binary-log-status.html) request (for {{ MY }} 8.4). The request should return a string with the information, not an empty response.
