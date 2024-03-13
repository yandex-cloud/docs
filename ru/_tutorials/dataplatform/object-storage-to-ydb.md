# Загрузка данных из {{ objstorage-full-name }} в {{ ydb-full-name }} с помощью {{ data-transfer-full-name }}

Вы можете перенести данные из {{ objstorage-name }} в таблицу {{ ydb-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. Если вы выбрали режим БД {{ dd }}, [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.

    1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md).

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `s3-ydb-account` и ролями `storage.editor` и `ydb.editor`. Трансфер будет использовать его для доступа к бакету и базе данных.

    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта `s3-ydb-account`.

- С помощью {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [object-storage-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-ydb/blob/main/object-storage-to-ydb.tf).

        В этом файле описаны:

        * сервисный аккаунт, который будет использоваться для работы с бакетом и базой данных {{ ydb-name }};
        * секрет {{ lockbox-name }}, в котором будет храниться статический ключ сервисного аккаунта для настройки эндпоинта-источника;
        * бакет-источник {{ objstorage-name }};
        * кластер-приемник {{ ydb-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `object-storage-to-ydb.tf` значения переменных:

        * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. Подготовьте два CSV-файла с тестовыми данными:

    * `demo_data1.csv`:

        ```csv
        1,Anna
        2,Robert
        3,Umar
        4,Algul
        5,Viktor
        ```

    * `demo_data2.csv`:

        ```csv
        6,Maria
        7,Alex
        ```

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `demo_data1.csv` в бакет {{ objstorage-name }}.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/object-storage.md#endpoint-settings) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-OBJECT_STORAGE }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}** — имя бакета в {{ objstorage-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}** — открытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}** — закрытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}** — `https://storage.yandexcloud.net`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}** — `ru-central1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}** — знак запятой `,`.
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}** — `table1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` и укажите имена полей и тип данных:

        * `Id` : `Int64`;
        * `Name` : `UTF8`.

    Остальные параметры оставьте по умолчанию.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/yandex-database.md#endpoint-settings) типа `{{ ydb-short-name }}` и укажите в нем параметры подключения к кластеру:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных {{ ydb-short-name }} из списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите сервисный аккаунт `s3-ydb-account`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - С помощью {{ TF }} {#tf}

        1. Укажите в файле `object-storage-to-ydb.tf` значения параметров:

            * `source_endpoint_id` — идентификатор эндпоинта для источника.
            * `transfer_enabled` — значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Чтобы убедиться в работоспособности трансфера, проверьте работу копирования и репликации.

### Проверьте работу копирования {#verify-copy}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
    1. Выберите базу из списка.
    1. Перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
    1. Проверьте, что база данных {{ ydb-name }} содержит таблицу `table1` с тестовыми данными.

- CLI {#cli}

    1. [Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md).

    1. Выполните запрос:

        ```sql
        SELECT * FROM table1;
        ```

        {% cut "Пример ответа" %}

        ```sql
        Id |   Name   |   __file_name    | __row_index 
        ---+----------+------------------+-------------
         1 | "Anna"   | "demo_data1.csv" | 1 
         2 | "Robert" | "demo_data1.csv" | 2 
         3 | "Umar"   | "demo_data1.csv" | 3 
         4 | "Algul"  | "demo_data1.csv" | 4 
         5 | "Viktor" | "demo_data1.csv" | 5 
        ```

        {% endcut %}

{% endlist %}

### Проверьте работу репликации {#verify-replication}

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `demo_data2.csv` в бакет {{ objstorage-name }}.

1. Убедитесь, что данные из файла `demo_data2.csv` появились в базе данных приемника:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
        1. Проверьте, что в таблицу `table1` добавились новые данные.

    - CLI {#cli}

        1. [Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md).

        1. Выполните запрос:

            ```sql
                SELECT * FROM table1;
            ```

            {% cut "Пример ответа" %}

            ```sql
            Id |   Name   |   __file_name    | __row_index 
            ---+----------+------------------+-------------
             1 | "Anna"   | "demo_data1.csv" | 1 
             2 | "Robert" | "demo_data1.csv" | 2 
             3 | "Umar"   | "demo_data1.csv" | 3 
             4 | "Algul"  | "demo_data1.csv" | 4 
             5 | "Viktor" | "demo_data1.csv" | 5 
             6 | "Maria"  | "demo_data2.csv" | 1 
             7 | "Alex"   | "demo_data2.csv" | 2 
            ```

            {% endcut %}

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Трансфер](../../data-transfer/operations/transfer.md#delete).
* [Эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#delete).
* Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        * [Эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
        * [Базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).
        * [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).

    - С помощью {{ TF }} {#tf}

        Если вы создавали ресурсы с помощью {{ TF }}:

        1. Удалите все объекты из бакета.
        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `object-storage-to-ydb.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `object-storage-to-ydb.tf`, будут удалены.

    {% endlist %}
