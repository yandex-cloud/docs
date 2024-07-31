# Поставка данных из {{ mmy-full-name }} в {{ mkf-full-name }} с помощью {{ data-transfer-full-name }}

Вы можете отслеживать изменения данных в _кластере-источнике_ {{ mmy-name }} и отправлять их в _кластер-приемник_ {{ mkf-name }} с помощью технологии [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC).

Чтобы настроить CDC с использованием сервиса {{ data-transfer-name }}:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте кластер-приемник](#prepare-target).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер-источник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * с базой данных `db1`;
    * с пользователем `my-user`;
    * с хостами в публичном доступе.

1. [Создайте кластер-приемник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.


1. Если вы используете группы безопасности, настройте их так, чтобы к кластерам можно было подключаться из интернета:

    * [Инструкция для {{ mmy-name }}](../../managed-mysql/operations/connect.md#configuring-security-groups).
    * [Инструкция для {{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups).


1. Установите на локальный компьютер [утилиту](https://github.com/edenhill/kcat) `kcat` (`kafkacat`) и [утилиту командной строки MySQL](https://www.mysql.com/downloads/). Например, в Ubuntu 20.04 выполните команду:

    ```bash
    sudo apt update && sudo apt install kafkacat mysql-client --yes
    ```

## Подготовьте кластер-источник {#prepare-source}

1. Чтобы сервис {{ data-transfer-name }} мог получать от кластера {{ mmy-name }} уведомления об изменениях в данных, в кластере-источнике необходимо настроить внешнюю репликацию. Чтобы пользователь `my-user` мог выполнять репликацию, [назначьте ему роль](../../managed-mysql/operations/grant.md) `ALL_PRIVILEGES` для базы данных `db1` и [выдайте глобальные привилегии](../../managed-mysql/operations/cluster-users.md#update-settings) `REPLICATION CLIENT` и `REPLICATION SLAVE`.

1. [Подключитесь к базе данных](../../managed-mysql/operations/connect.md) `db1` от имени пользователя `my-user`.

1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию, поступающую от некоторых датчиков автомобиля.

    Создайте таблицу:

    ```sql
    CREATE TABLE db1.measurements (
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
    INSERT INTO db1.measurements VALUES
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Подготовьте кластер-приемник {#prepare-target}

Настройки различаются в зависимости от используемого [способа управления топиками](../../managed-kafka/concepts/topics.md#management). При этом имена топиков для данных формируются по следующему принципу — `<префикс_топика>.<имя_схемы>.<имя_таблицы>`. В этом руководстве в качестве примера будет использоваться префикс `cdc`.

{% list tabs group=topic_management %}

- Интерфейсы {{ yandex-cloud }} {#yc}

    Если управление топиками осуществляется с помощью стандартных интерфейсов {{ yandex-cloud }} (Консоль управления, YC CLI, {{ TF }}, API):

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `cdc.db1.measurements`.

        Для отслеживания изменений в нескольких таблицах создайте для каждой из них отдельный топик.

    1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `kafka-user` и ролями `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER`, действующими для созданных топиков. Чтобы включить все такие топики, укажите в имени топика `cdc.*`.

- Admin API {#api}

    Если для управления топиками используется Kafka Admin API:

    1. Создайте [пользователя-администратора](../../managed-kafka/operations/cluster-accounts.md) с именем `kafka-user`.

    1. Помимо роли `ACCESS_ROLE_ADMIN` назначьте пользователю-администратору роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` для топиков, имена которых начинаются с префикса `cdc`.

        Необходимые топики будут созданы автоматически при первом событии изменения в отслеживаемых таблицах кластера-источника. Такое решение может быть удобным для отслеживания изменений во множестве таблиц, однако, требует запас свободного места в хранилище кластера. Подробнее см. в разделе [{#T}](../../managed-kafka/concepts/storage.md).

{% endlist %}

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для источника {{ MY }} с [настройками](../../data-transfer/operations/endpoint/source/mysql.md):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MySQL`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}** — выберите [созданный ранее](#before-you-begin) кластер {{ mmy-name }}.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.database.title }}** — `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — `my-user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — укажите пароль пользователя `my-user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}** — `db1.measurements`.

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для приемника {{ KF }} с [настройками](../../data-transfer/operations/endpoint/source/kafka.md):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Kafka`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}** — выберите [созданный ранее](#before-you-begin) кластер {{ mkf-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}** — укажите данные созданного ранее пользователя `kafka-user`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}** — `cdc.db1.measurements`.

        Если необходимо отслеживать изменения в нескольких таблицах, заполните поля следующим образом:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}** — укажите префикс `cdc`, использованный при формировании имен топиков.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** с созданными эндпоинтами для источника и приемника.
1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

## Проверьте работоспособность трансфера {#verify-transfer}

1. В отдельном терминале запустите утилиту `kafkacat` в режиме потребителя:

    ```bash
    kafkacat \
        -C \
        -b <FQDN_хоста-брокера_1>:9091,...,<FQDN_хоста-брокера_N>:9091 \
        -t cdc.db1.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<пароль> \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
        -Z \
        -K:
    ```

    FQDN хостов-брокеров можно получить со [списком хостов в кластере {{ mkf-name }}](../../managed-kafka/operations/cluster-hosts.md).

1. Подключитесь к кластеру-источнику и добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO db1.measurements VALUES
        ('iv7b74th678t********', '2022-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL),
        ('iv9a94th678t********', '2022-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

1. Убедитесь, что в терминале с запущенной утилитой `kafkacat` отобразились схема формата данных таблицы `db1.measurements` и сведения о добавленных строках.

    {% cut "Пример фрагмента сообщения" %}

    ```json
    {
        "payload": {
            "device_id": "iv7b74th678t********"
        },
        "schema": {
            "fields": [
                {
                    "field": "device_id",
                    "optional": false,
                    "type": "string"
                }
            ],
            "name": "cdc.db1.measurements.Key",
            "optional": false,
            "type": "struct"
        }
    }: {
        "payload": {
            "after": {
                "altitude": 378,
                "battery_voltage": 5.3,
                "cabin_temperature": 20,
                "datetime": "2020-06-08T17:45:00Z",
                "device_id": "iv7b74th678t********",
                "fuel_level": null,
                "latitude": 53.70987913,
                "longitude": 36.62549834,
                "speed": 20.5
            },
            "before": null,
            "op": "c",
            "source": {
                "connector": "mysql",
                "db": "db1",
                "file": "mysql-log.000016",
                "gtid": "1e46a80b-2e96-11ed-adf7-d00d183780**:*-*****",
                "name": "cdc",
                "pos": 1547357,
                "query": null,
                "row": 0,
                "server_id": 0,
                "snapshot": "false",
                "table": "measurements",
                "thread": null,
                "ts_ms": 1662632515000,
                "version": "1.1.2.Final"
            },
            "transaction": null,
            "ts_ms": 1662632515000
        },
        "schema": {
            "fields": [
                {
                    "field": "before",
                    "fields": [
                        {
                            "field": "device_id",
                            "optional": false,
                            "type": "string"
                        },
                        ...
                    ],
                    "name": "cdc.db1.measurements.Value",
                    "optional": true,
                    "type": "struct"
                },
                {
                    "field": "after",
                    "fields": [
                        ...
                    ],
                    "name": "cdc.db1.measurements.Value",
                    "optional": true,
                    "type": "struct"
                },
                {
                    "field": "source",
                    "fields": [
                        {
                            "field": "version",
                            "optional": false,
                            "type": "string"
                        },
                        ...
                    ],
                    "name": "io.debezium.connector.mysql.Source",
                    "optional": false,
                    "type": "struct"
                },
                {
                    "field": "op",
                    "optional": false,
                    "type": "string"
                },
                ...
            ],
            "name": "cdc.db1.measurements.Envelope",
            "optional": false,
            "type": "struct"
        }
    }
    ```

    {% endcut %}

### Особенности поставки данных с помощью {{ data-transfer-name }} {#features}

* При переносе данных из {{ MY }} в {{ KF }} некоторые типы данных переносятся с изменениями:

  * тип `tinyint(1)` переносится как `boolean`;
  * тип `real` переносится как `double`;
  * тип `bigint unsigned` переносится как `int64`.

* В блоке метаинформации об источнике `payload.source` параметры `server_id` и `thread` не заполняются.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) и [удалите](../../data-transfer/operations/transfer.md#delete) трансфер.

1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).

1. Удалите кластеры:

    * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md);
    * [{{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).

1. Если для доступа к хостам кластеров использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.
