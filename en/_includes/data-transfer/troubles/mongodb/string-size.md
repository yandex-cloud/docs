### Collection key size exceeds 5 MB {#string-size}

Error message:

```text
Warn(replication): Usage of bulk objects in 'database <DB name>'
breaks change event log, transfer is stopping.
Reason: (Location<item number>) Tried to create string longer than 16MB.
```

If the collection key size exceeds 5 MB, transfers of the _{{ dt-type-repl }}_ type crash due to {{ MG }} [internal limits](https://docs.mongodb.com/manual/reference/limits/) on the size of user objects.

**Solution:** [exclude](../../../../data-transfer/operations/endpoint/source/mongodb.md) any collections that exceed {{ MG }} limits from the transfer and [reactivate](../../../../data-transfer/operations/transfer.md#activate) it.
