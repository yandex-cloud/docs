#### What causes a replica to lag? {#replica-lagging}

1. Check that the `slave_rows_search_algorithms` parameter is set to `INDEX_SCAN,HASH_SCAN`.
1. For large tables, we recommend using the `pt-online-schema-change` utility from the Percona Toolkit rather than `ALTER TABLE` statements to avoid locking.
1. If the lag persists, enable parallel replication. To do this, configure the following parameters:
   ```text
   slave_parallel_type=LOGICAL_CLOCK
   slave_parallel_workers=8
   ```
1. Run the `SHOW SLAVE STATUS;` command on the replica. If the value of `Executed_Gtid_Set` remains unchanged for a long time, make sure all the tables have indexes.
1. If data is continuously written to the DB, and the host has 8GB RAM or more, we recommend increasing `innodb_log_file_size` up to 1 or 2 GB (parameter updates apply on server restart).
