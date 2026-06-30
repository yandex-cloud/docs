### Error transferring tables with deferrable constraints {#deferrable-constr}

An error occurs in transfers of the {{ dt-type-repl }} or {{ dt-type-copy-repl }} types since {{ data-transfer-name }} does not support updating tables and transactions with `DEFERRABLE` constraints. For more information about deferrable constraints, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/sql-set-constraints.html).

**Solution**: Change the constraint type in such tables to `IMMEDIATE` and [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
