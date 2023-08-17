### Unable to transfer child tables {#successor-tables}

Child tables are either not transferred or transferred without data if a table is partitioned.

**Solution:** set the following source endpoint parameters:

1. Select **Merge inherited tables** in advanced settings.
1. In the **Included tables** field, specify all child tables to transfer data from.
1. Make sure the user has access to the child tables.

To speed up the transfer of child tables, set up [parallel copy](../../../../data-transfer/concepts/sharded.md).
