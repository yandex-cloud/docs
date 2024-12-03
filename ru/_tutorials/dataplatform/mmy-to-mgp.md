# Миграция данных из {{ mmy-full-name }} в {{ mgp-full-name }} с помощью {{ data-transfer-full-name }}

Вы можете настроить перенос данных из базы {{ mmy-name }} в базу {{ mgp-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Создайте базу данных в кластере-приемнике](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

* Вручную {#manual}

    1. [Создайте кластер-источник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md#create-cluster) в любой [зоне доступности](../../overview/concepts/geo-scope.md), с хостами любой подходящей конфигурации в публичном доступе и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `mmy_db`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `mmy_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_источника>`.

    1. [Выдайте административные привилегии](../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` и `REPLICATION SLAVE` пользователю `mmy_user`.

        Подробнее об административных привилегиях см. в [описании настроек](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

    1. В той же зоне доступности [создайте кластер-приемник {{ mgp-name }}](../../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `mgp_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_приемника>`.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-datatransfer }}** — включен.

    1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:

        * [{{ mmy-name }}](../../managed-mysql/operations/connect.md#configure-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).

* С помощью {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [mmy-to-mgp.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-greenplum/blob/main/mmy-to-mgp.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;
        * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;
        * кластер-источник {{ mmy-name }};
        * кластер-приемник {{ mgp-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `mmy-to-mgp.tf`:

        * Версии {{ MY }} и {{ GP }}.
        * Пароли пользователей {{ MY }} и {{ GP }}.

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

1. [Подключитесь к базе данных](../../managed-mysql/operations/connect.md) `mmy_db` в кластере-источнике {{ mmy-name }}.

1. Создайте простую таблицу `table1`:

    ```sql
    CREATE TABLE table1 (
    id int NOT NULL,
    name varchar (10),
    PRIMARY KEY (id)
    );
    ```

1. Наполните таблицу данными:

    ```sql
    INSERT INTO table1 VALUES
    (1, 'Name1'),
    (2, 'Name2'),
    (3, 'Name3');
    ```

## Создайте базу данных в кластере-приемнике {#prepare-data}

1. [Подключитесь к служебной базе данных](../../managed-greenplum/operations/connect.md) `postgres` в кластере-приемнике {{ mgp-name }} от имени пользователя `mgp_user`.

1. Создайте базу данных `mgp_db`:

    ```sql
    CREATE DATABASE mgp_db;
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/greenplum.md) типа `{{ GP }}` и укажите в нем параметры подключения к кластеру:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}** — `<имя_кластера_приемника_{{ GP }}>` из выпадающего списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — `mgp_db`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — `mgp_user`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — `<пароль_пользователя>`.

1. Создайте эндпоинт-источник и трансфер:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/mysql.md) типа `{{ MY }}` и укажите в нем параметры подключения к кластеру:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}** — `<имя_кластера_источника_{{ MY }}>` из выпадающего списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `mmy_db`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — `mmy_user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — `<пароль_пользователя>`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    * С помощью {{ TF }} {#tf}

        1. Укажите в файле `mmy-to-mgp.tf` значения параметров:

            * `target_endpoint_id` — идентификатор эндпоинта для приемника.
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

1. [Подключитесь к базе данных](../../managed-greenplum/operations/connect.md) `mgp_db` в кластере-приемнике {{ mgp-name }}.

1. Выполните запрос:

    ```sql
    SELECT * FROM mmy_db.table1;
    ```

### Проверьте работу репликации {#verify-replication}

1. [Подключитесь к базе данных](../../managed-mysql/operations/connect.md) `mmy_db` в кластере-источнике {{ mmy-name }}.

1. Добавьте данные в таблицу `table1`:

    ```sql
    INSERT INTO table1 VALUES
    (4, 'Name4');
    ```

1. Убедитесь, что добавленная строка появилась в базе данных приемника:

    1. [Подключитесь к базе данных](../../managed-greenplum/operations/connect.md) `mgp_db` в кластере-приемнике {{ mgp-name }}.
    1. Выполните запрос:

        ```sql
        SELECT * FROM mmy_db.table1;
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Трансфер](../../data-transfer/operations/transfer.md#delete).
    * [Эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
    * [Кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
    * [Кластер {{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).

- С помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

