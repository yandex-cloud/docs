### VIEW transfer error {#view}

Error message:

```text
[ERROR] "... _view": no key columns found
```

Can't replicate new data from Views. Under {{ PG }} — {{ PG }} transfers, only those views are transferred which are listed in the **Table filter** → **Included tables** source endpoint parameter.

**Solution:** manually exclude all views from the transfer, list them in the **Table filter** → **Included tables** [source endpoint parameter](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings), and then [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
