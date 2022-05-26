# {{ MG }}

In certain cases, a transfer of type _{{ dt-type-repl }}_ crashes because of the following errors:

* Collection object size exceeds 16 MB.

   ```text
   Warn(replication): Usage of bulk objects in 'collection '<DB name>.<collection name>''
   breaks change event log, transfer is stopping.
   Reason: (BSONObjectTooLarge) BSONObj size: <object size> (<object size in hex>) is invalid.
   Size muse be between 0 and 16793600(16MB).
   ```

* Collection key size exceeds 5 MB.

   ```text
   Warn(replication): Usage of bulk objects in 'database <DB name>'
   breaks change event log, transfer is stopping.
   Reason: (Location<item number>) Tried to create string longer than 16MB.
   ```

These errors result from {{ MG }} [internal restrictions](https://docs.mongodb.com/manual/reference/limits/) on user object size.

To resolve the problem, [exclude](../operations/endpoint/source/mongodb.md) any collections that exceed {{ MG }} limits from the transfer and [reactivate](../operations/transfer.md#activate) it.
