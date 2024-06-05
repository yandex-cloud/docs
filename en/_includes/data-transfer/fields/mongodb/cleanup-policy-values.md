* `DISABLED`: Do not clean up (default).

   Select this option if only replication without copying data is performed.

* `DROP`: Completely delete the collections included in the transfer.

   Use this option so that the latest collection version is always transferred to the target database from the source whenever the transfer is activated.

* `TRUNCATE`: Delete only the data from the collections included in the transfer but keep the collections.

   Use this option if the structure of collections in the target database differs from the one that would have been transferred from the source during the transfer.
