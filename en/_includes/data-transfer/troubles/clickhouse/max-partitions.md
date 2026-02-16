### Data blocks limit exceeded {#partition-blocks}

When migrating data to a {{ CH }} target, the transfer is interrupted due to an error. Error message:

```text
ERROR Unable to Activate ... 
unable to upload tables: unable to upload data objects: unable upload part <table name> (): 
unable to start \*clickhouse.HTTPSource event source: failed to push events to destination: 
unable to push http batch: <table name>: failed: INSERT INTO ...
```

Additionally, you can also get this error:

```text
pod instance restarted
```

Errors occur when you try to insert more data blocks than allowed in the `max_partitions_per_insert_block` setting to the {{ CH }} target.

**Solution**: Increase the `max_partitions_per_insert_block` parameter for the account the transfer uses to connect to the target. For the {{ mch-name }} target, you can change this parameter in [user settings](../../../../managed-clickhouse/concepts/settings-list.md#setting-partitions-per-insert-block). For a {{ CH }} custom installation, you can create a settings profile and assign it to the account:

```sql
CREATE SETTINGS PROFILE max_partitions
SETTINGS max_partitions_per_insert_block = <setting_value>

ALTER USER <username> PROFILE 'max_partitions'
```
