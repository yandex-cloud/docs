# Загрузка данных из {{ MY }} в {{ objstorage-name }} с помощью {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из кластера-источника {{ mmy-name }} в объектное хранилище {{ objstorage-name }}.

Чтобы перенести данные:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. [Создайте кластер-источник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации.
    1. [Создайте бакет в {{ objstorage-name }}](../../storage/operations/buckets/create.md).

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mmy-objs.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mmy-objs.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mmy-name }};
        * кластер-источник {{ mmy-name }};
        * сервисный аккаунт с ролями `editor`, `storage.editor` и `storage.uploader`;
        * бакет {{ objstorage-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `data-transfer-mmy-objs.tf`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `sa_name` — имя сервисного аккаунта для создания бакета и использования в эндпоинте-приемнике.
        * `bucket_name` — имя бакета в {{ objstorage-name }}.
        * параметры кластера-источника {{ mmy-name }}, которые будут использоваться как [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/mysql.md#managed-service):

            * `source_mysql_version` — версия {{ MY }};
            * `source_db_name` — имя базы данных;
            * `source_user` и `source_password` — имя и пароль пользователя-владельца базы данных.
        * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинта-приемника вручную](#prepare-transfer).

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте кластер-источник {#prepare-source}

1. Если вы создавали инфраструктуру вручную, [подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

1. [Подключитесь к кластеру-источнику {{ mmy-name }}](../../managed-mysql/operations/connect.md).

1. Наполните базу тестовыми данными. В качестве примера используется таблица с информацией, поступающей от датчиков автомобиля.

    Создайте таблицу:

    ```sql
    CREATE TABLE measurements (
        device_id varchar(200) NOT NULL,
        datetime timestamp NOT NULL,
        latitude real NOT NULL,
        longitude real NOT NULL,
        altitude real NOT NULL,
        speed real NOT NULL,
        battery_voltage real,
        cabin_temperature real NOT NULL,
        fuel_level real,
        PRIMARY KEY (device_id)
    );
    ```

    Наполните таблицу данными:

    ```sql
    INSERT INTO measurements VALUES
        ('iv9a94th6rztooxh5ur2', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qmz3sdbrbu', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-OBJECT_STORAGE }}`.
    * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.connection_settings.title }}**:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket.title }}** — укажите имя бакета {{ objstorage-name }}.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `storage.uploader`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket_layout.title }}** — `measurements`.

1. Создайте эндпоинт для источника и трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MYSQL }}`.
            * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**:
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                   Выберите кластер-источник из списка и укажите настройки подключения к нему.

              * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}** — укажите регулярные выражения для переносимых таблиц и таблиц, которые не надо переносить.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    * С помощью {{ TF }}

        1. Укажите в файле `data-transfer-mmy-objs.tf` переменные:

            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера;
            * (опционально) `include_tables_regex`, `exclude_tables_regex` – регулярные выражения для переносимых таблиц и таблиц, которые не надо переносить.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Убедитесь, что данные перенеслись из кластера-источника {{ mmy-name }} в бакет {{ objstorage-name }}:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный бакет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Выберите бакет из списка.
    1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
    1. Проверьте, что бакет {{ objstorage-name }} содержит папку `measurements` с объектом `<имя базы данных кластера-источника>_measurements` с тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs %}

* Вручную

    1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
    1. [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
    1. [Удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
    1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).

* С помощью {{ TF }}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-mmy-objs.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mmy-objs.tf`, будут удалены.

{% endlist %}
