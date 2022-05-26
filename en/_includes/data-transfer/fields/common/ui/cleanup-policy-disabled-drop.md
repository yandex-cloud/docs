**Cleanup policy**: Select a way to clean up data in the target database before the transfer:

* `Drop`: Fully delete tables included in the transfer (default).

    Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

* `Disabled`: Do not clean.

    Select this option if only replication without copying data is performed.
