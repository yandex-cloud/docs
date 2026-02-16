### Duplicate key violates a unique constraint {#duplicate-key}

Error message:

```text
ERROR: duplicate key value violates unique constraint "<constraint_name>" (SQLSTATE 23505)
```

You may get this error while replicating data from {{ PG }} to {{ PG }}, e.g., when there was not enough memory for all the transaction events and only some transaction rows were transferred from the source database to the target one. In the target database, those rows are applied in a separate transaction by default, which may lead to a constraint violation, such as a duplicate key.

**Solution**: use one of the following options:

* [Enable the advanced](../../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTargetAdvancedSettings.save_tx_boundaries.title }}** setting for the target endpoint.{{ data-transfer-name }} will open the transaction, apply the received events, but will only commit the transaction when it starts receiving next transaction data.

    Using the **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTargetAdvancedSettings.save_tx_boundaries.title }}** setting may slightly reduce transfer performance but will prevent errors related to contraint violations.

* Disable constraints in the target database. Sometimes, constraints may be violated, e.g., when part of a transaction from the source database is applied in the target database. However, {{ data-transfer-name }} ensures eventual consistency, i.e., applying the second part of the transaction when there are no constraint violations.
