`cleanup_policy`: Select a way to clean up data in the target database before the transfer:

* `YDB_CLEANUP_POLICY_DROP`: Completely delete the tables included in the transfer (default). This will delete all tables in the target before transferring new tables.

  Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

* `YDB_CLEANUP_POLICY_DISABLED`: Do not clean up.

  Select this option if you are only going to do replication without copying data.
