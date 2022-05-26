For _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers, tables without primary keys are not transferred. To make sure the transfer is running properly when migrating a database with such tables:

* Do not transfer tables without primary keys. For this purpose, add them to the list of excluded tables in [source endpoint settings](../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings.md).
* Add the replica ID to tables without `primary keys`:
    * For tables with an index, set `REPLICA IDENTITY` by `unique key`:

        ```sql
        ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
        ```

    * For tables without an index, change `REPLICA IDENTITY`:

        ```sql
        ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
        ```

