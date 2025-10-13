If needed, create a new connector:

1. Click ![plug-connection](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud_org.security.workspaces.ConnectorAddField.addNewConnector }}** and in the window that opens:

    1. In the **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelNameField }}** field, enter a name for the connector.
    1. Optionally, give the connector's description in the **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelDescriptionField }}** field.
    1. Select the [service account](../../iam/concepts/users/service-accounts.md) for access to cloud resources in the **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelServiceAccountField }}** field.

        {% include [workspace-create-step2-create-connector-view-sa-scope](./workspace-create-step2-create-connector-view-sa-scope.md) %}

    1. Click **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.createConnectorButton }}**.