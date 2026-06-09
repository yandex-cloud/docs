# Создание источника


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) ресурсов, в котором создан каталог метаданных.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать источник.
    1. На панели слева выберите ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
    1. Задайте уникальное имя источника. После создания источника нельзя будет изменить его имя.
    1. (Опционально) Добавьте описание источника.
    1. Выберите тип бэкенда, из которого будут поставляться метаданные. После создания источника его тип нельзя будет изменить. Доступные бэкенды:
       
       * {{ PG }};
       * {{ MY }};
       * {{ CH }};
       * {{ SD }}/{{ MG }};
       * {{ OS }};
       * {{ GP }};
       * {{ data-transfer-full-name }};
       * {{ websql-name }};
       * {{ datalens-name }}.

    1. Укажите параметры источника для выбранного типа бэкенда:

        * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.ConnectionType.ManagedConnection.connection_id.title }}** — идентификатор управляемого подключения в [{{ connection-manager-full-name }}](../../quickstart/connection-manager.md).
        * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.database_name.title }}** — имя базы данных, из которой будут загружаться метаданные.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}