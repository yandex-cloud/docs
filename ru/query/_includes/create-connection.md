1. [Перейдите]({{ link-console-yq }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. В открывшемся окне в поле **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** укажите название соединения с {{ yds-full-name }}.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** выберите `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. В поле **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** выберите расположение источника данных.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.database.input-label }}** выберите базу данных {{ ydb-full-name }}, где ранее был создан поток {{ yds-full-name }}.
1. В поле **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** выберите сервисный аккаунт, который будет использоваться для чтения данных, или создайте новый, выдав ему права [`yds.editor`](../../data-streams/security/index.md#yds-editor).

   {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Нажмите **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
