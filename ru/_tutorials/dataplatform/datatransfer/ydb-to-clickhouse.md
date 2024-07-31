# Загрузка данных из {{ ydb-full-name }} в {{ mch-full-name }} с помощью {{ data-transfer-full-name }}


С помощью сервиса {{ data-transfer-name }} вы можете загружать данные из базы данных {{ ydb-name }} в кластер {{ mch-name }}.

Чтобы загрузить данные:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

* Вручную {#manual}

    1. [Создайте базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md) `ydb1` любой подходящей конфигурации.
    1. [Создайте кластер {{ mch-name }}](../../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `user1`.

    1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [{{ mch-name }}](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) с именем `ydb-account` и ролью `ydb.editor`. Трансфер будет использовать его для доступа к базе данных.

* С помощью {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [ydb-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-ydb-to-clickhouse/blob/main/ydb-to-clickhouse.tf).

        В этом файле описаны:

        * [сеть](../../../vpc/concepts/network.md#network);
        * [подсеть](../../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mch-name }} из интернета;
        * база данных {{ ydb-name }};
        * кластер-приемник {{ mch-name }};
        * эндпоинт для источника;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `ydb-to-clickhouse.tf` параметры:

        * `mch_version` — версия {{ CH }}.
        * `mch_password` — пароль пользователя-владельца базы данных {{ CH }}.

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

1. [Подключитесь к базе данных {{ ydb-name }}](../../../ydb/operations/connection.md).
1. [Создайте строковую таблицу](../../../ydb/operations/schema.md#create-table) `table1` со следующими колонками:

    | {{ ui-key.yacloud.ydb.browse.info.column_name }} | {{ ui-key.yacloud.ydb.browse.info.column_type }} | {{ ui-key.yacloud.ydb.table.form.column_primary-key }} |
    |:-------|:--------|:-------|
    | `Id`   | `Int64` | Да     |
    | `Name` | `Utf8`  |        |

    Вы также можете создать таблицу [с помощью SQL-запроса](../../../ydb/operations/crud.md#web-sql):

    ```sql
    CREATE TABLE table1 (
        Id Int64,
        Name Utf8, 
        PRIMARY KEY (Id)
    )
    ```

1. [Заполните таблицу данными](../../../ydb/operations/crud.md#change-data) с помощью SQL-запроса:

    ```sql
    INSERT INTO table1 (Id, Name)
    VALUES
        (1, "Anna"),
        (2, "Robert"),
        (3, "Umar"),
        (4, "Algul"),
        (5, "Viktor");
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

* Вручную {#manual}

    1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/source/ydb.md#endpoint-settings) типа `{{ ydb-short-name }}` и укажите в нем параметры подключения к базе данных:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных {{ ydb-name }} из списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите сервисный аккаунт `ydb-account`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}** — укажите таблицу `table1`.

    1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/target/clickhouse.md#endpoint-settings) типа `{{ CH }}` и укажите в нем параметры подключения к кластеру:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — `<имя_кластера_приемника_{{ CH }}>` из выпадающего списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** — `user1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.

    1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

* С помощью {{ TF }} {#tf}

    1. Укажите в файле `ydb-to-clickhouse.tf` значение `1` для параметра `transfer_enabled`.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Трансфер активируется автоматически после создания.

{% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Чтобы убедиться в работоспособности трансфера, проверьте работу копирования и репликации.

### Проверьте работу копирования {#verify-copy}

1. [Подключитесь к базе данных](../../../managed-clickhouse/operations/connect/clients.md) `db1` в кластере-приемнике {{ mch-name }}.

1. Выполните запрос:

    ```sql
    SELECT * FROM db1.table1;
    ```

    {% cut "Пример ответа" %}

    ```sql
    # | Id  | Name     | __data_transfer_commit_time | __data_transfer_delete_time
    --+-----+----------+-----------------------------+----------------------------
    1 | "1" | "Anna"   | "1722023098109014844"       | "0"
    2 | "2" | "Robert" | "1722023098109014844"       | "0"
    3 | "3" | "Umar"   | "1722023098109014844"       | "0"
    4 | "4" | "Algul"  | "1722023098109014844"       | "0"
    5 | "5" | "Viktor" | "1722023098109014844"       | "0"
    ```

    {% endcut %}

### Проверьте работу репликации {#verify-replication}

1. [Подключитесь к базе данных {{ ydb-name }}](../../../ydb/operations/connection.md).

1. [Добавьте данные в таблицу](../../../ydb/operations/crud.md#change-data) `table1`:

    ```sql
    INSERT INTO table1 (Id, Name)
    VALUES
        (6, "Maria"),
        (7, "Alex");
    ```

1. Убедитесь, что новые данные появились в базе данных приемника:

    1. [Подключитесь к базе данных](../../../managed-clickhouse/operations/connect/clients.md) `db1` в кластере-приемнике {{ mch-name }}.

    1. Выполните запрос:

        ```sql
        SELECT * FROM db1.table1;
        ```

        {% cut "Пример ответа" %}

        ```sql
        # | Id  | Name     | __data_transfer_commit_time | __data_transfer_delete_time
        --+-----+----------+-----------------------------+----------------------------
        1 | "1" | "Anna"   | "1722023098109014844"       | "0"
        2 | "2" | "Robert" | "1722023098109014844"       | "0"
        3 | "3" | "Umar"   | "1722023098109014844"       | "0"
        4 | "4" | "Algul"  | "1722023098109014844"       | "0"
        5 | "5" | "Viktor" | "1722023098109014844"       | "0"
        6 | "6" | "Maria"  | "1722023655224000000"       | "0"
        7 | "7" | "Alex"   | "1722023655225000000"       | "0"
        ```

        {% endcut %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

* Вручную {#manual}

    * [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
    * [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
    * [Удалите базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md#delete-db).
    * [Удалите кластер {{ mch-name }}](../../../managed-clickhouse/operations/cluster-delete.md).
    * [Удалите сервисный аккаунт](../../../iam/operations/sa/delete.md).

* С помощью {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `ydb-to-clickhouse.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `ydb-to-clickhouse.tf`, будут удалены.

{% endlist %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}