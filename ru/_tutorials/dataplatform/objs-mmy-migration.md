# Миграция данных из {{ objstorage-name }} в кластер {{ mmy-full-name }} с помощью {{ data-transfer-full-name }}


С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из объектного хранилища {{ objstorage-name }} в кластер-приемник {{ mmy-name }}.

Чтобы перенести данные:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-viewer` и ролью `storage.viewer`. Трансфер будет использовать его для доступа к бакету.
    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта `storage-viewer`.

    1. [Создайте кластер-приемник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `mmy-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_пользователя>`.

    1. [Назначьте пользователю {{ MY }} роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-приемника.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-objs-mmy.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-mysql/tree/master/data-transfer-objs-mmy.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mmy-name }};
        * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
        * секрет {{ lockbox-name }}, в котором будет храниться статический ключ сервисного аккаунта для настройки эндпоинта-источника;
        * бакет-источник {{ objstorage-name }};
        * кластер-приемник {{ mmy-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-objs-mmy.tf`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        * `mmy_password` — пароль пользователя {{ MY }}.

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

1. Создайте на рабочей машине текстовый файл `data.csv` и наполните его тестовыми данными. В качестве примера используются показатели датчиков автомобиля:

    ```csv
    1;99101;2022-06-05 17:27:00;55.70329032;37.65472196;427.5;52.3;23.5;17.;52.
    2;95106;2022-06-06 09:49:54;55.71294467;37.66542005;429.13;55.5;21.;18.;32.
    3;117890;2023-06-07 06:21:29;55.71294467;37.66542005;429.13;56.2;20.;18.7;45.
    4;99101;2022-06-07 08:15:32;55.29194467;37.66542005;429.13;59.1;21.;18.;20.
    ```

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл в созданный ранее бакет {{ objstorage-name }}.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create) со следующими настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-OBJECT_STORAGE }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}** — имя бакета в {{ objstorage-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}** — открытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}** — закрытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}** — `https://{{ s3-storage-host }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}** — `ru-central1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}** — знак точки с запятой `;`.
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}** — `measurements`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageResultTable.add_system_cols.title }}** — выключите опцию.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` и укажите имена полей и тип данных:

        * `id`: `INT64`, признак **Ключ**;
        * `device_id`: `INT32`;
        * `datetime`: `DATETIME`;
  
           {% note info %}

           Эндпоинт-приемник записывает данные с типом `DATETIME` в часовом поясе UTC+0.

           {% endnote %}

        * `latitude`: `DOUBLE`;
        * `longitude`: `DOUBLE`;
        * `altitude`: `DOUBLE`;
        * `speed`: `DOUBLE`;
        * `battery_voltage`: `DOUBLE`;
        * `cabin_temperature`: `DOUBLE`;
        * `fuel_level`: `DOUBLE`.

    Остальные параметры оставьте по умолчанию.

1. Создайте эндпоинт для приемника и трансфер:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/target/postgresql.md):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MYSQL }}`.
            * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**:
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                   Выберите кластер-источник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Укажите в файле `data-transfer-objs-mmy.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру для трансфера:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. [Подключитесь к базе данных в кластере-приемнике {{ mmy-name }}](../../managed-mysql/operations/connect.md).
1. Чтобы убедиться что данные успешно перенесены, выполните запрос:

    ```sql
    SELECT * FROM db1.measurements;
    ```

    {% cut "Пример ответа" %}

    ```text
     id | device_id |     datetime        |  latitude | longitude | altitude | speed | battery_voltage | cabin_temperature | fuel_level
    ----------------+---------------------+-----------+-----------+----------+-------+-----------------+-------------------+----------+
      1 |     99101 | 2022-06-05T17:27:00 | 55.703289 |  37.66542 |   427.50 | 52.29 |            23.5 |              17.0 |     52.0 |
      2 |     95106 | 2022-06-06T09:49:54 | 55.712944 |  37.66542 |   429.13 | 55.50 |            21.0 |              18.0 |     32.0 |
      3 |    117890 | 2023-06-07T06:21:29 | 55.712944 |  37.66542 |   429.13 | 56.20 |            20.0 |              18.7 |     45.0 |
      4 |     99101 | 2022-06-05 17:27:00 | 55.291944 |  37.66542 |   429.13 | 59.09 |            21.0 |              18.0 |     20.0 |
    ```

    {% endcut %}

1. Создайте текстовый файл `data2.csv`, в котором содержатся новые данные:

    ```csv
    7;95106;2022-06-07 09:54:32;47.71294467;37.66542005;429.13;62.2;21.;20.4;27.
    9;117890;2022-06-07 11:56:27;52.71294467;37.66542005;429.13;65.5;19.;19.;38.
    10;117890;2022-06-07 12:36:27;57.71294467;37.66542005;429.13;72.1;19.;20.;25.
    11;99101;2022-06-07 15:22:27;59.71294467;37.66542005;429.13;35.5;19.;18.;12.
    ```

1. Загрузите файл в бакет {{ objstorage-name }} для трансфера.
1. Убедитесь, что в таблицу `db1.measurements` базы-приемника {{ MY }} добавились новые данные.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
    1. [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
    1. [Удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
    1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-objs-mmy.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-objs-mmy.tf`, будут удалены.

{% endlist %}
