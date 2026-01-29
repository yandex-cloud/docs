1. [Go](../../console/operations/select-service.md#select-service) to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** section in **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}** and click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify a name for a connection to {{ yds-full-name }} in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the drop-down list under **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** field, enter the data source location.
1. In the **{{ ui-key.yql.yq-connection-form.database.input-label }}** drop-down list, select the {{ ydb-full-name }} database where the {{ yds-full-name }} stream was created.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select a service account for data reads or create a new one with the [`yds.editor`](../../data-streams/security/index.md#yds-editor) permissions.

   {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}** to create a connection.
