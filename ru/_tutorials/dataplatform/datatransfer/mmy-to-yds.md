

Вы можете отслеживать изменения данных в _кластере-источнике_ {{ mmy-name }} и отправлять их в _кластер-приемник_ {{ yds-name }} с помощью технологии [Change Data Capture](../../../data-transfer/concepts/cdc.md) (CDC).

Чтобы настроить CDC с использованием сервиса {{ data-transfer-name }}:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу репликации](#check-replication).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник {{ mmy-name }}](../../../managed-mysql/operations/cluster-create.md) любой подходящей [конфигурации](../../../managed-mysql/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `mmy-user`.

    1. [Выдайте пользователю административные привилегии](../../../managed-mysql/concepts/settings-list#setting-administrative-privileges) `REPLICATION CLIENT` и `REPLICATION SLAVE`.

    
    1. Настройте [группы безопасности](../../../managed-mysql/operations/connect.md#configure-security-groups) и убедитесь, что они допускают подключение к кластеру.


    1. [Создайте базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md#create-db) с именем `ydb-example` любой подходящей конфигурации.

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) с именем `yds-sa` и ролью `yds.editor`. Трансфер будет использовать его для доступа к {{ yds-name }}.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [mysql-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-mysql-to-yds/blob/main/mysql-yds.tf).

        В этом файле описаны:

        * [сеть](../../../vpc/concepts/network.md#network);
        * [подсеть](../../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * кластер-источник {{ mmy-name }};
        * база данных {{ ydb-name }};
        * сервисный аккаунт, который будет использоваться для доступа к {{ yds-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `mysql-yds.tf` пароль пользователя {{ MY }}.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте поток данных {{ yds-name }}](../../../data-streams/operations/aws-cli/create.md) с именем `mpg-stream`.

1. [Подключитесь к кластеру {{ mmy-name }}](../../../managed-mysql/operations/connect.md), создайте в базе данных `db1` таблицу `measurements` и заполните ее данными:

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
    INSERT INTO measurements VALUES
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/target/data-streams.md) типа `{{ yds-name }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — `ydb-example`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — `mpg-stream`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — `yds-sa`.

1. Создайте эндпоинт-источник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/source/mysql.md) типа `{{ MY }}` и укажите в нем параметры подключения к кластеру:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-источника>` из выпадающего списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — `mmy-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — пароль пользователя `mmy-user`.

        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.

    - {{ TF }} {#tf}

        1. Укажите в файле `mysql-yds.tf` переменные:

            * `yds_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус _{{ dt-status-repl }}_.

{% include [get-yds-data](../../../_includes/data-transfer/get-yds-data.md) %}

## Проверьте работу репликации {#check-replication}

1. Подключитесь к кластеру-источнику.
1. Добавьте в таблицу `measurements` новую строку:

    ```sql
    INSERT INTO measurements VALUES
        ('ad02l5ck6sdt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 19, 45);
    ```

1. Убедитесь, что новая строка отобразилась в потоке данных {{ yds-name }}.

## Удалите созданные ресурсы {#clear-out}

{% include [note before delete resources](../../../_includes/mdb/note-before-delete-resources.md) %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт-приемник](../../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите поток данных {{ yds-name }}](../../../data-streams/operations/manage-streams.md#delete-data-stream).

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Эндпоинт-источник](../../../data-transfer/operations/endpoint/index.md#delete).
    * [{{ mmy-name }}](../../../managed-mysql/operations/cluster-delete.md).
    * [Базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
