### WAL lacks records to continue replication after changing the master host {#no-wal-story}.

When you change the master host in the source cluster, _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfers may throw this error:

```text
ERROR: requested WAL segment pg_wal/0000000E0000022700000087 has already been removed (SQLSTATE 58P01)
```

The error occurs if [WAL](https://www.postgresql.org/docs/current/wal-intro.html) does not have enough records on the new master to resume replication from the same place.

**Solution**: Increase the `Wal keep size` [setting](../../../../managed-postgresql/concepts/settings-list.md#setting-wal-keep-size) value in the source cluster. As the minimum value, use the average value from the **Source Buffer Size** chart in the [{{ data-transfer-name }} monitoring dashboard](../../../../data-transfer/operations/monitoring.md). If disk has enough capacity, specify a value with some margin.
