**{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

* `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option only for replication without data copying.

* `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete the tables included in the transfer (default).

   Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

* `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete only the data from the tables included in the transfer but keep the schema.

   Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.
