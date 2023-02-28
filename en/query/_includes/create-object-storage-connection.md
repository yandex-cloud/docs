1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ yq-full-name }}**.
1. In the panel on the left, go to the **Connections** tab.
1. Click ![info](../../_assets/plus.svg) **Create**.
1. Specify the connection parameters:

   1. Under **General parameters**:

      * **Name**: {{ objstorage-short-name }} connection name.
      * **Type**: `Object Storage`.

   1. Under **Connection type parameters**:

      * **Bucket authentication**: Select `Public` or `Private` depending on the type of the bucket object read permissions.
      * For a public bucket, enter a name in the **Bucket** field.

         For a private bucket, select:

         * **Cloud and folder** where the data source is located.
         * Select a bucket or create a new one.
         * Select or create a [service account](../../iam/concepts/users/service-accounts.md) with the [`storage.viewer`](../../storage/security/index.md#storage-viewer) role to be used to access the data.

1. Click **Create**.
