### Collection object size exceeds 16 MB {#object-size}

Error message:

```text
Warn(replication): Usage of bulk objects in 'collection '<DB_name>.<collection_name>''
breaks change event log, transfer is stopping.
Reason: (BSONObjectTooLarge) BSONObj size: <object_size> (<object_size_in_hex>) is invalid.
Size muse be between 0 and 16793600(16MB).
```

If collection object size exceeds 16 MB, _{{ dt-type-repl }}_ type transfers get interrupted due to {{ MG }}'s internal user object size limits.

**Solution:** [exclude](../../../../data-transfer/operations/endpoint/source/mongodb.md) any collections that exceed {{ MG }} limits from the transfer and [reactivate](../../../../data-transfer/operations/transfer.md#activate) it.
