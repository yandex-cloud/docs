**Cleanup policy**: Select a way to clean up data in the target database before the transfer:

* `Don't clean up`: Select this option if you are only going to do replication without copying data.

* `Drop`: Fully delete tables included in the transfer (used by default).

   Use this option to transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.
