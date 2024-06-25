1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Укажите параметры соединения:

   1. В блоке **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — название соединения с {{ objstorage-short-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ ui-key.yql.yq-connection.object-storage.select-item }}`.
  
   1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** — выберите `{{ ui-key.yql.yq-connection-form.public.button-text }}` или `{{ ui-key.yql.yq-connection-form.private.button-text }}` в зависимости от типа доступа к чтению объектов в бакете.

        Для публичного бакета введите имя в поле **{{ ui-key.yql.yq-connection-form.bucket.input-label }}**.
        Для приватного бакета выберите:
        * **{{ ui-key.yql.yq-connection-form.cloud.input-label }}**, в котором находится источник данных.
        * Выберите или создайте новый бакет.
        * Выберите или создайте новый [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролью [`storage.viewer`](../../storage/security/index.md#storage-viewer), от имени которого будет выполняться доступ к данным.

          {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
