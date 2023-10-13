Вы можете перенести базу данных из {{ mpg-full-name }} в {{ objstorage-full-name }} с помощью сервиса {{ data-transfer-full-name }}. Для этого:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. Создайте кластер-источник {{ mpg-name }} любой подходящей [конфигурации](../../managed-postgresql/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_источника>`.

    
    1. Если вы используете [группы безопасности](../../managed-postgresql/operations/connect.md#configuring-security-groups) в кластере, убедитесь, что они настроены правильно и допускают подключение к нему.


    1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md).

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-sa` и ролью `storage.uploader`. Трансфер будет использовать его для доступа к бакету.

* С помощью {{ TF }}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-to-objstorage.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/postgresql-to-objstorage.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * кластер-источник {{ mpg-name }};
        * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
        * бакет-приемник {{ objstorage-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `postgresql-to-objstorage.tf`:
        * пароль пользователя {{ PG }};
        * имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

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

## Подготовьте трансфер {#prepare-transfer}

1. [Подключитесь к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect.md), создайте в базе данных `db1` таблицу `x_tab` и заполните ее данными:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC PRIMARY KEY,
         name CHAR(5)
     );
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/object-storage.md) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket.title }}** — `<имя_созданного_ранее_бакета>`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — `storage-sa`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — `UNCOMPRESSED`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket_layout.title }}** — `from_PostgreSQL`.

1. Создайте эндпоинт-источник и трансфер:

{% list tabs %}

* Вручную

    1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-источника_{{ PG }}>` из выпадающего списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}** — `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}** — `pg-user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.

* С помощью {{ TF }}

    1. Укажите в файле `postgresql-to-objstorage.tf` переменные:

        * `objstorage_endpoint_id` — значение идентификатора эндпоинта для приемника;
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

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

1. Убедитесь, что в бакете {{ objstorage-name }} появилась таблица `public_x_tab.csv` с данными из таблицы `x_tab`.

## Проверьте работу копирования при повторной активации {#example-check-copy}

1. [Подключитесь к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect.md), удалите строку с идентификатором `41` и измените строку с идентификатором `42` в таблице `x_tab`:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Повторно [активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
1. Убедитесь, что изменения отобразились в таблице `public_x_tab.csv` на приемнике.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* Убедитесь, что трансфер находится в статусе **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
* [Удалите эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
* Удалите трансфер, эндпоинт-источник, кластер и бакет:

    {% list tabs %}

    * Вручную

        * [Трансфер](../../data-transfer/operations/transfer.md#delete).
        * [Эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#delete).
        * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        * [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).

    * С помощью {{ TF }}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `postgresql-to-objstorage.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `postgresql-to-objstorage.tf`, будут удалены.

    {% endlist %}
