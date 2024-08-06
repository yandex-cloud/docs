# Загрузка данных из {{ ydb-full-name }} в {{ objstorage-full-name }} с помощью {{ data-transfer-full-name }}


Вы можете перенести данные из {{ ydb-name }} в объектное хранилище {{ objstorage-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. [Создайте бакет {{ objstorage-name }}](../../../storage/operations/buckets/create.md).
    
    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) с ролями `storage.editor` и `ydb.editor`. Трансфер будет использовать его для доступа к базе данных и бакету.

- С помощью {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [ydb-to-object-storage.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-ydb-to-object-storage/blob/main/ydb-to-object-storage.tf).

        В этом файле описаны:

        * [сеть](../../../vpc/concepts/network.md#network);
        * [подсеть](../../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../../vpc/concepts/security-groups.md);
        * сервисный аккаунт с ролями `storage.editor` и `ydb.editor`;
        * бакет-приемник {{ objstorage-name }};
        * эндпоинты;
        * трансфер.

    1. Укажите в файле `ydb-to-object-storage.tf`:
        * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md);
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. [Создайте](../../../ydb/operations/crud.md/#web-sql) в базе данных {{ ydb-name }} таблицу `seasons`:

    ```sql
    CREATE TABLE seasons
    (
        series_id Uint64,
        season_id Uint64,
        title Utf8,
        first_aired Uint64,
        last_aired Uint64,
        PRIMARY KEY (series_id, season_id)
    );

    COMMIT;
     ```
1. Заполните таблицу данными:

    ```sql
    REPLACE INTO seasons (series_id, season_id, title, first_aired, last_aired)
    VALUES
        (1, 1, "Season 1", CAST(Date("2006-02-03") AS Uint64), CAST(Date("2006-03-03") AS Uint64)),
        (1, 2, "Season 2", CAST(Date("2007-08-24") AS Uint64), CAST(Date("2007-09-28") AS Uint64)),
        (1, 3, "Season 3", CAST(Date("2008-11-21") AS Uint64), CAST(Date("2008-12-26") AS Uint64)),
        (1, 4, "Season 4", CAST(Date("2010-06-25") AS Uint64), CAST(Date("2010-07-30") AS Uint64)),
        (2, 1, "Season 1", CAST(Date("2014-04-06") AS Uint64), CAST(Date("2014-06-01") AS Uint64)),
        (2, 2, "Season 2", CAST(Date("2015-04-12") AS Uint64), CAST(Date("2015-06-14") AS Uint64)),
        (2, 3, "Season 3", CAST(Date("2016-04-24") AS Uint64), CAST(Date("2016-06-26") AS Uint64)),
        (2, 4, "Season 4", CAST(Date("2017-04-23") AS Uint64), CAST(Date("2017-06-25") AS Uint64)),
        (2, 5, "Season 5", CAST(Date("2018-03-25") AS Uint64), CAST(Date("2018-05-13") AS Uint64));

    COMMIT;
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/target/object-storage.md) типа `{{ objstorage-name }}` со следующими настройками:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — `<имя_созданного_ранее_бакета>`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — `<имя_созданного_ранее_сервисного_аккаунта>`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — `UNCOMPRESSED`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}** — `from_YDB`.

    1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/source/ydb.md) типа `{{ ydb-short-name }}` и укажите в нем параметры подключения к базе данных:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных {{ ydb-short-name }} из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите созданный ранее сервисный аккаунт.

    1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}**, использующий созданные эндпоинты.

    1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

- {{ TF }} {#tf}

    1. Укажите в файле `ydb-to-object-storage.tf` переменные:

        * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
        * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
        * `transfer_enabled` – значение `1` для создания трансфера.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

{% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Убедитесь, что данные перенеслись из базы данных {{ ydb-name }} в бакет {{ objstorage-name }}:
    
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный бакет.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Выберите бакет из списка.
1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
1. Проверьте, что бакет {{ objstorage-name }} содержит папку `from_YDB` с объектом `<seasons.csv>` с тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete).

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите бакет {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).
    1. [Удалите базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md/#delete-db).
    1. Если вы создавали сервисный аккаунт, [удалите его](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `ydb-to-object-storage.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, описанные в конфигурационном файле `ydb-to-object-storage.tf`, будут удалены.

{% endlist %}