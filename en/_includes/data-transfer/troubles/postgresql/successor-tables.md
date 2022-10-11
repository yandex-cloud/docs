### Can't transfer child tables {#successor-tables}

Child tables are either not transferred or transferred without data if a table is partitioned.

**Solution:** set the following source endpoint parameters:

1. Select **Merge inherited tables** in advanced settings.
1. In the **Included tables** field, specify all child tables to transfer data from.
1. Make sure the user has access to the child tables.

To speed up a child table transfer using parallel reading, specify the number of instances and processes in the **Runtime environment** → **{{ yandex-cloud }}** → **Sharded copying parameters** [transfer parameter](../../../../data-transfer/operations/transfer.md#update).
