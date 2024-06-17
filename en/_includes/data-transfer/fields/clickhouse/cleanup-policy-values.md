* `CLICKHOUSE_CLEANUP_POLICY_DISABLED`: Do not clean up (default).

   Select this option only for replication without data copying.

* `CLICKHOUSE_CLEANUP_POLICY_DROP`: Completely delete the tables included in the transfer.

   Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

* `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE`: Delete only the data from the tables included in the transfer but keep the schema.

   Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.
