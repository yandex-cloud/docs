

Вы можете настроить перенос данных из базы {{ mmy-name }} в базу {{ mpg-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник {{ mmy-name }}](../../../managed-mysql/operations/cluster-create.md#create-cluster) в любой [зоне доступности](../../../overview/concepts/geo-scope.md), с хостами любой подходящей конфигурации в публичном доступе, и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `mmy_db`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `mmy_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_источника>`.

    1. [Выдайте административные привилегии](../../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` и `REPLICATION SLAVE` пользователю `mmy_user`.

        Подробнее об административных привилегиях см. в [описании настроек](../../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

    1. В той же зоне доступности [создайте кластер-приемник {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `mpg_db`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `mpg_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_приемника>`.

    1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:

        * [{{ mmy-name }}](../../../managed-mysql/operations/connect.md#configuring-security-groups).
        * [{{ mpg-name }}](../../../managed-postgresql/operations/connect.md#configuring-security-groups).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [mysql-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-postgresql/blob/main/mysql-postgresql.tf).

        В этом файле описаны:

        * [сети](../../../vpc/concepts/network.md#network) и [подсети](../../../vpc/concepts/network.md#subnet) для размещения кластеров;
        * [группы безопасности](../../../vpc/concepts/security-groups.md) для подключения к кластерам;
        * кластер-источник {{ mmy-name }};
        * кластер-приемник {{ mpg-name }};
        * эндпоинты для источника и приемника;
        * трансфер.

    1. Укажите в файле `mysql-postgresql.tf`:

        * Версии {{ MY }} и {{ PG }}.
        * Пароли пользователей {{ MY }} и {{ PG }}.

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

1. [Подключитесь к базе данных в кластере-источнике {{ mmy-name }}](../../../managed-mysql/operations/connect.md).

1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию, поступающую от некоторых датчиков автомобиля.

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
    ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
    ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/source/mysql.md) типа `{{ MY }}` и укажите в нем параметры подключения к кластеру:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}** — `<имя_кластера_источника_{{ MY }}>` из выпадающего списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `mmy_db`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — `mmy_user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — `<пароль_пользователя>`.

    1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/target/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — `<имя_кластера_приемника_{{ PG }}>` из выпадающего списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `mpg_db`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — `mpg_user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.
    1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

- {{ TF }} {#tf}

    1. Укажите в файле `mysql-postgresql.tf` значение `1` для параметра `transfer_enabled`.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    1. Трансфер активируется автоматически. Дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

{% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Чтобы убедиться в работоспособности трансфера, проверьте работу копирования и репликации.

### Проверьте работу копирования {#verify-copy}

1. [Подключитесь к базе данных в кластере-приемнике {{ mpg-name }}](../../../managed-postgresql/operations/connect.md).
1. Выполните запрос:

    ```sql
    SELECT * FROM mmy_db.measurements;
    ```

### Проверьте работу репликации {#verify-replication}

1. [Подключитесь к базе данных в кластере-источнике {{ mmy-name }}](../../../managed-mysql/operations/connect.md).
1. Добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO measurements VALUES
    ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что добавленная строка появилась в базе данных приемника:

    1. [Подключитесь к базе данных в кластере-приемнике {{ mpg-name }}](../../../managed-postgresql/operations/connect.md).
    1. Выполните запрос:

        ```sql
        SELECT * FROM mmy_db.measurements;
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Трансфер](../../../data-transfer/operations/transfer.md#delete).
    * [Эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete).
    * [Кластер {{ mmy-name }}](../../../managed-mysql/operations/cluster-delete.md).
    * [Кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).

- {{ TF }} {#tf}

    Если вы создавали ресурсы с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `mysql-postgresql.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `mysql-postgresql.tf`, будут удалены.

{% endlist %}
