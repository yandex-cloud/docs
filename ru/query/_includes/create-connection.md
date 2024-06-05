1. Перейти в интерфейс {{ yq-full-name }} в раздел **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** и нажать кнопку **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. В открывшемся окне в поле **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** указать название соединения с {{ yds-full-name }}.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** выбрать `{{ ui-key.yql.yq-connection.datastreams.select-item }}`.
1. В поле **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** выберите расположение источника данных.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.database.input-label }}** выбрать базу данных {{ydb-full-name}}, где ранее был создан поток {{yds-full-name}}.
1. В поле **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** выбрать сервисный аккаунт, который будет использоваться для чтения данных, или создать новый, выдав ему права [`yds.editor`](../../data-streams/security/#yds-editor).
1. Создать соединение, нажав кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
