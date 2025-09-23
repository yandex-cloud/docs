При необходимости создайте новый коннектор:

1. Нажмите кнопку ![plug-connection](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud_org.security.workspaces.ConnectorAddField.addNewConnector }}** и в открывшемся окне:

    1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelNameField }}** укажите имя коннектора.
    1. (Опционально) В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelDescriptionField }}** задайте произвольное описание коннектора.
    1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelServiceAccountField }}** выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет осуществляться доступ к облачным ресурсам.

        {% include [workspace-create-step2-create-connector-view-sa-scope](./workspace-create-step2-create-connector-view-sa-scope.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.createConnectorButton }}**.