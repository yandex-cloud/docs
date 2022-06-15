**Cleanup policy**: Select a way to clean up data in the target database before the transfer:

* `DROP`: Fully delete tables included in the transfer (default).

    Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

* `DISABLED`: Do not clean.

    Select this option if only replication without copying data is performed.

* `TRUNCATE`: Delete only the data from the tables included in the transfer but leave the schema.

    Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

