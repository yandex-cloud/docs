* `DISABLED`: Do not clean up (default).

   Select this option if only replication without copying data is performed.

* `DROP`: Completely delete the tables included in the transfer.

   Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

* `TRUNCATE`: Delete only the data from the tables included in the transfer but keep the schema.

   Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.
