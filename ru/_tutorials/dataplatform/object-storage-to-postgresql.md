# Перенос данных из {{ objstorage-full-name }} в {{ mpg-full-name }} с использованием {{ data-transfer-full-name }}

Вы можете перенести данные из {{ objstorage-full-name }} в таблицу {{ mpg-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Создайте кластер-приемник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-postgresql/concepts/instance-types.md) со следующими настройками:

        * Выделен публичный доступ к хостам кластера.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_пользователя>`.

    
    1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../managed-postgresql/operations/connect.md#configuring-security-groups) и допускают подключение к нему.


    1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-viewer` и ролью `storage.viewer`. Трансфер будет использовать его для доступа к бакету.
    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта `storage-viewer`.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [objstorage-to-postgres.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-postgresql/blob/main/objstorage-to-postgres.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
        * секрет {{ lockbox-name }}, в котором будет храниться статический ключ сервисного аккаунта для настройки эндпоинта-источника;
        * бакет-источник {{ objstorage-name }};
        * кластер-приемник {{ mpg-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `objstorage-to-postgres.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        * `pg_password` — пароль пользователя {{ PG }}.

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

1. Создайте на рабочей машине `demo_data.csv` и наполните его тестовыми данными:

    ```csv
    1,Anna
    2,Robert
    3,Umar
    4,Algul
    5,Viktor
    ```

1. [Загрузите](../../storage/operations/objects/upload.md#simple) подготовленный файл в бакет {{ objstorage-name }}.

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/object-storage.md) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-OBJECT_STORAGE }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}** — имя бакета в {{ objstorage-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}** — открытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}** — закрытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}** — `https://storage.yandexcloud.net`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}** — `{{ region-id }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}** — знак запятой `,`.
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}** — имя CSV-файла в бакете, например `demo_data.csv`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` и укажите имена полей и тип данных:

        * `Id` : `Int64`;
        * `Name` : `UTF8`.

    Остальные параметры оставьте по умолчанию.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — имя кластера-источника {{ PG }} из выпадающего списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}** — `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}** — `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}** — `<пароль_пользователя>`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.

    - {{ TF }} {#tf}

        1. Укажите в файле `objstorage-to-postgres.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. [Подключитесь к базе данных в кластере-приемнике {{ mpg-name }}](../../managed-postgresql/operations/connect.md).
1. Выполните запрос:

    ```sql
    SELECT * FROM public."demo_data.csv";
    ```

    {% cut "Пример ответа" %}

    ```sql
     __file_name  | __row_index | Id |  Name  
    --------------+-------------+----+--------
    demo_data.csv |           1 |  1 | Anna
    demo_data.csv |           2 |  2 | Robert
    demo_data.csv |           3 |  3 | Umar
    demo_data.csv |           4 |  4 | Algul
    demo_data.csv |           5 |  5 | Viktor
    ```

    {% endcut %}

Данные успешно перенесены.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Трансфер](../../data-transfer/operations/transfer.md#delete).
* [Эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#delete).
* Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=resources %}

    - Вручную {#manual}

        * [Эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
        * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        * [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).

    - {{ TF }} {#tf}

        1. Удалите все объекты из бакета.
        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `objstorage-to-postgres.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `objstorage-to-postgres.tf`, будут удалены.

    {% endlist %}
