### Error transferring tables with deferred constraints {#deferrable-constr}

The error arises in the transfers of type {{ dt-type-repl }} or {{ dt-type-copy-repl }} because updating tables and transactions with `DEFERRABLE` constraints isn't supported by {{ data-transfer-name }}. To learn more about deferred constraints, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-set-constraints.html).

**Solution:** Change the constraint type in such tables to `IMMEDIATE` and [activate](../../../../data-transfer/operations/transfer.md#activate) the transfer again.
