### Collection key size exceeds 5 MB {#string-size}

Error message:

```text
Warn(replication): Usage of bulk objects in 'database <DB_name>'
breaks change event log, transfer is stopping.
Reason: (Location<position_number>) Tried to create string longer than 16MB.
```

If collection key size exceeds 5 MB, _{{ dt-type-repl }}_ type transfers get interrupted due to {{ MG }}'s internal user object size limits.

**Solution:** [exclude](../../../../data-transfer/operations/endpoint/source/mongodb.md) any collections that exceed {{ MG }} limits from the transfer and [reactivate](../../../../data-transfer/operations/transfer.md#activate) it.
