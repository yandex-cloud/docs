1. Go to **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** in the {{ yq-full-name }} interface and click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify a name for a connection to {{ yds-full-name }} in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the drop-down list under **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** field, enter the data source location.
1. In the **{{ ui-key.yql.yq-connection-form.database.input-label }}** drop-down list, select the {{ ydb-full-name }} database where the {{ yds-full-name }} stream was created.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select the service account to use for data reads or create a new one by granting it the [`yds.editor`](../../data-streams/security/#yds-editor) permissions.
1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}** to create a connection.
