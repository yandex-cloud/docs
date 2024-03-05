1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of the connection to {{ objstorage-short-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.object-storage.select-item }}`.

   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}**: Select `{{ ui-key.yql.yq-connection-form.public.button-text }}` or `{{ ui-key.yql.yq-connection-form.private.button-text }}` depending on the type of the bucket object read permissions.

         For a public bucket, enter a name in the **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** field.
         For a private bucket, select:
         * **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
         * Select a bucket or create a new one.
         * Select or create a [service account](../../iam/concepts/users/service-accounts.md) with the [`storage.viewer`](../../storage/security/index.md#storage-viewer) role to be used to access the data.

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
