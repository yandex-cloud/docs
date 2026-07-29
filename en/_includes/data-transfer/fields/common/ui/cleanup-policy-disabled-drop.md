**Cleanup policy**: Select a way to clean up data in the target database before the transfer:

* `Drop`: Completely delete the tables included in the transfer (default). The tables will be deleted when the transfer starts, before the data delivery begins.

    Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

* `Disabled`: Do not clean up. New data will be merged with the data from tables that already exist at the specified paths.

    Select this option if you are only going to do replication without copying data.

* `Replace`: Write data to temporary tables and replace the existing tables with the new ones after delivery is complete. Your old data will remain available until the transfer is complete. If the transfer fails with an error, the old tables will not be deleted.