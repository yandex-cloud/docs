### No tables found {#no-tables}

Error message:

```text
Unable to find any tables
```

This error occurs when the source has no available tables or the specified user has no permissions for the schemas / tables.

**Solution**:

* Check if there are tables. Make sure you specified the source database correctly and that it actually has the tables you want to transfer.

* Check user permissions. For more information about the required permissions and how to assign them, see [{#T}](../../../../data-transfer/operations/endpoint/source/clickhouse.md#prepare).
