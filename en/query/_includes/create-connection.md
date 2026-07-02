1. [Navigate](../../console/operations/select-service.md#select-service) to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** section of the **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}** interface and click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify the {{ yds-full-name }} connection name in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** dropdown, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** field, specify the data source location.
1. In the **{{ ui-key.yql.yq-connection-form.database.input-label }}** dropdown, select the {{ ydb-full-name }} database where you created the {{ yds-full-name }} stream.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select an existing service account or create a new one. Assign it the [`yds.editor`](../../data-streams/security/index.md#yds-editor) permissions required to read data.

   {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}** to create a connection.
