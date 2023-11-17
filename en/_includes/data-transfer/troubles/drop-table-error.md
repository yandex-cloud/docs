### Error when dropping a table under the Drop cleanup policy {#drop-table-error}

Error message:

```text
ERROR: cannot drop table <table_name> because other objects depend on it (SQLSTATE 2BP01)
```

With the `Drop` cleanup policy, a transfer drops tables in multiple iterations:

1. The transfer tries to drop all tables one by one. Cascade delete is not used, as it may delete tables that are not included in the transfer. If a table cannot be dropped, for example, due to its links to external keys, an error occurs, but the transfer will continue dropping tables.
1. During the next iteration, the transfer will try to drop the remaining tables. If the blocking child tables were dropped in the previous iteration, the table linked to external keys will also be dropped. In this case, the error is fixed while {{ data-transfer-name }} is running and no other actions are required.
1. If the transfer does not drop any table during another iteration, table dropping stops. In which case:

   * The transfer will continue running if all tables were dropped.
   * The transfer will be aborted with an error if there are any tables left.

**Solution:**

* If child tables are not involved in other transfers and their transfer is not in conflict with the transfer goals, add these tables:

   * To the list of included tables in the source endpoint parameters.
   * To the list of objects to be transferred in the transfer parameters.

* Delete the blocking child tables in the target database manually.
* Use the `Truncate` cleanup policy.
* Recreate the target database.

   {% note warning %}

   This will lead to losing all data in the database.

   {% endnote %}
