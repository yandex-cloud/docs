* {% include [Field Database Name](../../fields/ydb/ui/database-name.md) %}


* {% include [Field Service Account](../../fields/ydb/ui/service-account.md) %}


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

   * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Fully delete tables included in the transfer (used by default).

      Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

   * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Do not clean up.

      Select this option if only replication without copying data is performed.