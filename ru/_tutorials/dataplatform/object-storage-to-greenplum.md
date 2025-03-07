# Загрузка данных из {{ objstorage-full-name }} в {{ mgp-full-name }} с помощью {{ data-transfer-full-name }}


{% note info %}

Функциональность загрузки данных из {{ objstorage-name }} в сервисе {{ data-transfer-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}


Вы можете перенести данные из {{ objstorage-name }} в таблицу {{ mgp-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Создайте базу данных в кластере-приемнике](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}


1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер-приемник {{ mgp-name }}](../../managed-greenplum/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

            * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `user1`.
            * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_пользователя>`.

        
        1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../managed-greenplum/operations/connect.md#configuring-security-groups) и допускают подключение к нему.


        1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md).

        1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-viewer` и ролью `storage.viewer`. Трансфер будет использовать его для доступа к бакету.

        1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `storage-viewer`.

    - С помощью {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [object-storage-to-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-greenplum/blob/main/object-storage-to-greenplum.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
            * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
            * секрет {{ lockbox-name }}, в котором будет храниться статический ключ сервисного аккаунта для настройки эндпоинта-источника;
            * бакет-источник {{ objstorage-name }};
            * кластер-приемник {{ mgp-name }};
            * трансфер.

        1. Укажите в файле `object-storage-to-greenplum.tf` значения переменных:

            * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
            * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
            * `gp_version` — версия {{ GP }}.
            * `gp_password` — пароль пользователя {{ GP }}.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. В кластере-приемнике [включите опцию](../../managed-greenplum/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.forms.additional-field-datatransfer }}**.

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

## Создайте базу данных в кластере-приемнике {#prepare-data}

1. [Подключитесь к служебной базе данных](../../managed-greenplum/operations/connect.md) `postgres` в кластере-приемнике {{ mgp-name }} от имени пользователя `user1`.

1. Создайте базу данных `db1`:

    ```sql
    CREATE DATABASE db1;
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/object-storage.md#objstorage-name) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}** — имя бакета в {{ objstorage-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}** — открытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}** — закрытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}** — `https://storage.yandexcloud.net`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}** — `ru-central1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}** — знак запятой `,`.
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}** — `table1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` и укажите имена полей и тип данных:

        * `Id`: `Int64`;
        * `Name`: `UTF8`.

    Остальные параметры оставьте по умолчанию.

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/greenplum.md#gp) типа `{{ GP }}` и укажите в нем параметры подключения к кластеру:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}** — `<имя_кластера_приемника_{{ GP }}>` из выпадающего списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — `db1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — `user1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — `<пароль_пользователя>`.

1. Создайте и активируйте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - С помощью {{ TF }} {#tf}

        1. Укажите в файле `object-storage-to-greenplum.tf` переменные:

            * `source_endpoint_id` — идентификатор эндпоинта для источника;
            * `target_endpoint_id` — идентификатор эндпоинта для приемника;
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

1. [Подключитесь к базе данных](../../managed-greenplum/operations/connect.md) `db1` в кластере-приемнике {{ mgp-name }}.

1. Выполните запрос:

    ```sql
    SELECT * FROM public.table1;
    ```

    {% cut "Пример ответа" %}

    ```sql
      __file_name  | __row_index | Id |  Name
    ---------------+-------------+----+--------
    demo_data1.csv |           1 |  1 | Anna
    demo_data1.csv |           2 |  2 | Robert
    demo_data1.csv |           3 |  3 | Umar
    demo_data1.csv |           4 |  4 | Algul
    demo_data1.csv |           5 |  5 | Viktor
    ```

    {% endcut %}

### Проверьте работу репликации {#verify-replication}

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `demo_data2.csv` в бакет {{ objstorage-name }}.

1. Убедитесь, что данные из файла `demo_data2.csv` появились в базе данных приемника:

    1. [Подключитесь к базе данных](../../managed-greenplum/operations/connect.md) `db1` в кластере-приемнике {{ mgp-name }}.

    1. Выполните запрос:

        ```sql
        SELECT * FROM public.table1;
        ```

        {% cut "Пример ответа" %}

        ```sql
          __file_name  | __row_index | Id |  Name
        ---------------+-------------+----+--------
        demo_data1.csv |           1 |  1 | Anna
        demo_data1.csv |           2 |  2 | Robert
        demo_data1.csv |           3 |  3 | Umar
        demo_data1.csv |           4 |  4 | Algul
        demo_data1.csv |           5 |  5 | Viktor
        demo_data2.csv |           1 |  6 | Maria
        demo_data2.csv |           2 |  7 | Alex
        ```

        {% endcut %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Трансфер](../../data-transfer/operations/transfer.md#delete).
* [Эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#delete).
* [Эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
* [Объекты](../../storage/operations/objects/delete.md) из бакета.
* Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        * [Кластер {{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).
        * [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).

    - С помощью {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
