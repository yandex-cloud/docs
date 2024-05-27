## Managing database connection parameters using {{ connection-manager-name }} {#connection-manager}

If your cloud or folder has access to [{{ connection-manager-name }}](../../metadata-hub/concepts) public preview, a new _connection_ entity will appear in your folder after you create a cluster. You can use it to manage database connection parameters.

Passwords and other sensitive data will be stored in a _{{ lockbox-name }} secret_. To see which secrets store connection information for your cluster, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** in the list of services in your folder. You will find you cluster's ID on the **{{ ui-key.yacloud.lockbox.label_section-secrets }}** page in the secret dependencies column.

You can also use {{ connection-manager-name }} to configure access to connections.
