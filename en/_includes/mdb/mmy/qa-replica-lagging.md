#### What causes a replica to lag? {#replica-lagging}

1. Check that `slave_rows_search_algorithms` is set to `INDEX_SCAN,HASH_SCAN`.
1. For large tables, we recommend using `pt-online-schema-change` from the Percona Toolkit rather than `ALTER TABLE` statements to avoid locking.
1. If the lag persists, enable parallel replication. To do this, configure the following settings:
   ```text
   slave_parallel_type=LOGICAL_CLOCK
   slave_parallel_workers=8
   ```
1. Run the `SHOW SLAVE STATUS;` command on the replica. If the `Executed_Gtid_Set` value remains unchanged for a long time, make sure all the tables have indexes.
1. For continuous database writes on a host with 8 GB or more of RAM, we recommend increasing `innodb_log_file_size` up to 1 or 2 GB (changing this setting requires a server restart).
