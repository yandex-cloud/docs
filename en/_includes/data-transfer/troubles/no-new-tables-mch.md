### No new tables are added {#no-new-tables}

No new tables are added to _{{ dt-type-copy-repl}}_ transfers.

**Solution**:

1. Create tables in the target database manually. For the transfer to work, do the following when creating a table:

   1. Add the transfer service fields to it:

      ```sql
      __data_transfer_commit_time timestamp,
      __data_transfer_delete_time timestamp
      ```

   1. Use the `ReplacingMergeTree` engine:

      ```sql
      ENGINE = ReplacingMergeTree
      ```

1. [Create](../../../data-transfer/operations/transfer.md#create) a separate transfer of the _{{ dt-type-copy-repl }}_ type and add only new tables to the list of objects to transfer. Deactivating the original _{{ dt-type-copy-repl}}_ transfer is not required. [Activate](../../../data-transfer/operations/transfer.md#activate) the new transfer, and once it switches to the {{ dt-status-repl }} status, [deactivate](../../../data-transfer/operations/transfer.md#deactivate) it.

   To add other tables, put them into the list of objects to transfer in the created separate transfer (replacing other objects in that list), reactivate it, and, once it switches to the {{ dt-status-repl }} status, deactivate it.

   {% note info %}

   Since two transfers were simultaneously migrating data, you will have duplicate records in the new tables on the target. To hide them, run the `SELECT * from TABLE <table_name> FINAL` query; to delete them, `OPTIMIZE TABLE <table_name>`.

   {% endnote %}
