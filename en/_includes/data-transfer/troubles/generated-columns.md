### Error when transferring tables with generated columns {#generated-columns}

Error message:

```text
ERROR: column "<column_name>" is a generated column (SQLSTATE 42P10)
```

The error may occur if a table containing generated columns is transferred from the source database. For example, if the generated column is an identifier column (`GENERATED ... AS IDENTITY`), the error will occur during data replication. If the generated column is a computable one, the error will occur regardless of the transfer type. For more information on generated columns, see the [relevant {{ PG }} documentation]({{ pg-docs }}/ddl-generated-columns.html).

**Solution**: In the [source endpoint parameters](../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings), exclude from the transfer the tables containing generated columns.
