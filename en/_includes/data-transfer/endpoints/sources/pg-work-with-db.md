{% note tip %}

The {{ PG }} replication protocol does not support transferring schema changes. Avoid changing the data schema in the source and target databases during the transfer. If this cannot be avoided, perform explicit checks on the target.

{% endnote %}

For _{{ dt-type-copy }}_ and _{{ dt-type-copy-repl }}_ transfers:

* In the {{ dt-status-copy }} status, changes to the data schema on the source and target are not allowed.
* In the {{ dt-status-repl }} status, any changes to the data schema on the source should be manually applied to the target, otherwise the transfer will not be able to continue.

   For example, suppose we added a new column to the `test_table` table on the source:

   ```sql
   ALTER TABLE test_table ADD COLUMN val2 TEXT;
   ```

   If writing to this table continues, the transfer will not be able to insert data on the target. For replication to continue, run a similar query to change the data schema on the target:

   ```sql
   ALTER TABLE test_table ADD COLUMN val2 TEXT;
   ```

   After that, the transfer can continue.