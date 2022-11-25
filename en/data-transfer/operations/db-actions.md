# Working with databases during the transfer

When working with data transfers, you must take into account the specific features of databases.
While the transfer with replication is running ([transfer types](../concepts/index.md#transfer-type) _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_), the data on the source and target may differ, so during this time, errors may occur when reading data from the target database. After [deactivating](./transfer.md#deactivate) the transfer, all data on the source and target will be the same (eventual consistency).

## MySQL {#mysql}

* For transfers in the {{ dt-status-copy }} status, any changes to the data schema (`ALTER`) on the source or target will interrupt the transfer.

* For transfers in the {{ dt-status-repl }} status, you can change the data schema on the source. All `ALTER` operations recorded in the binary log (binlog) on the source will be automatically applied to the target. This process takes some time, so the transfer may slow down.

## PostgreSQL {#postgresql}

{% note tip %}

The {{ PG }} replication protocol doesn't support transmitting schema changes. Avoid changing the data schema in the source and target databases during the transfer. If this can't be avoided, perform explicit checks on the target.

{% endnote %}

For _{{ dt-type-copy }}_ and _{{ dt-type-copy-repl }}_ transfers:

* In the {{ dt-status-copy }} status, changes to the data schema on the source and target aren't allowed.
* In the {{ dt-status-repl }} status, any changes to the data schema on the source should be manually applied to the target, otherwise the transfer won't be able to continue.

   For example, suppose we added a new column to the `test_table` table on the source:

   ```sql
   ALTER TABLE test_table ADD COLUMN val2 TEXT;
   ```

   If writing to this table continues, the transfer won't be able to insert data on the target. For replication to continue, run a similar query to change the data schema on the target:

   ```sql
   ALTER TABLE test_table ADD COLUMN val2 TEXT;
   ```

   After that, the transfer can continue.


## MongoDB {#mongodb}

* For a transfer with {{ dt-status-copy }} status, you cannot do anything that would reduce the source's logical _replication log (oplog) time window_. You should not add, remove, or reconfigure shards in any way while the copy operation is in progress, or perform any other actions that result in a shorter logical replication log window.

* In transfers in {{ dt-status-repl }} status, you may encounter the key duplication problem when a sharded {{ MG }} cluster with a sharding index other than `_id` is the target. While a transfer is underway, we caution against creating clusters with sharding indexes other than `_id` on the target.

