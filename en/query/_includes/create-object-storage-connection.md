1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, switch to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: {{ objstorage-short-name }} connection name.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_object-storage }}`.
  
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}**: Select `{{ ui-key.yql.yq-connection-form.public.button-text }}` or `{{ ui-key.yql.yq-connection-form.private.button-text }}` depending on the type of read access to objects in the bucket.

        For a public bucket, specify a name in the **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** field.
        For a private bucket:
        * Select **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
        * Select an existing bucket or create a new one.
        * Select an existing [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`storage.viewer`](../../storage/security/index.md#storage-viewer) role required to access the data.

          {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
