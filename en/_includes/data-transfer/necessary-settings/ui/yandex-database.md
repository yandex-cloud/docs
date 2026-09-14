* Select the **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.on_premise_connection.title }}** or **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.managed_connection.title }}** connection type.
  
  To set up your connection manually, specify the following:

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name-onprem.md) %}

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/ydb-endpoint-settings.md) %}

    
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/ca-sertificate.md) %}
    
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/subnet-id.md) %}
  
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}

  
  To set up a connection to {{ ydb-full-name }}:

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}

    
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.cleanup_policy.title }}**: Select the pre-transfer cleanup policy for the target database:

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Delete all tables included in the transfer. This is the default option.

        Use this option to always transfer the latest table schemas on every transfer activation.

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: No cleanup.

        Use it if you are only replicating data, without copying it.
