* {% include [Field Database Name](../../fields/ydb/ui/database-name.md) %}


* {% include [Field Service Account](../../fields/ydb/ui/service-account.md) %}

* {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete the tables included in the transfer (default).

        Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Do not clean up.

        Select this option if you are only going to do replication without copying data.
