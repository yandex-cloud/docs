# Поставка данных в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer

# Поставка данных из Yandex Managed Service for MySQL® в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer

Вы можете отслеживать изменения данных в _кластере-источнике_ Managed Service for MySQL® и отправлять их в _кластер-приемник_ Managed Service for Apache Kafka® с помощью технологии [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC).

Чтобы настроить CDC с использованием сервиса Data Transfer:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте кластер-приемник](#prepare-target).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for MySQL®](../pricing.md)).
* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

{% note info %}

Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.

{% endnote %}

1. [Создайте кластер-источник Managed Service for MySQL®](../operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * с базой данных `db1`;
    * с пользователем `my-user`;
    * с хостами в публичном доступе.

1. [Создайте кластер-приемник Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.


1. Если вы используете группы безопасности, настройте их так, чтобы к кластерам можно было подключаться из интернета:

    * [Инструкция для Managed Service for MySQL®](../operations/connect/index.md#configuring-security-groups).
    * [Инструкция для Managed Service for Apache Kafka®](../../managed-kafka/operations/connect/index.md#configuring-security-groups).


1. Установите на локальный компьютер [утилиту](https://github.com/edenhill/kcat) `kcat` (`kafkacat`) и [утилиту командной строки MySQL](https://www.mysql.com/downloads/). Например, в Ubuntu 20.04 выполните команду:

    ```bash
    sudo apt update && sudo apt install kafkacat mysql-client --yes
    ```

    Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Подготовьте кластер-источник {#prepare-source}

1. Чтобы сервис Data Transfer мог получать от кластера Managed Service for MySQL® уведомления об изменениях в данных, в кластере-источнике необходимо настроить внешнюю репликацию. Чтобы пользователь `my-user` мог выполнять репликацию, [назначьте ему роль](../operations/grant.md) `ALL_PRIVILEGES` для базы данных `db1` и [выдайте глобальные привилегии](../operations/cluster-users.md#update-settings) `REPLICATION CLIENT` и `REPLICATION SLAVE`.

1. [Подключитесь к базе данных](../operations/connect/index.md) `db1` от имени пользователя `my-user`.

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

- Интерфейсы Yandex Cloud {#yc}

    Если управление топиками осуществляется с помощью стандартных интерфейсов Yandex Cloud (Консоль управления, CLI, Terraform, API):

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `cdc.db1.measurements`.

        Для отслеживания изменений в нескольких таблицах создайте для каждой из них отдельный топик.

    1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `kafka-user` и ролями `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER`, действующими для созданных топиков. Чтобы включить все такие топики, укажите в имени топика `cdc.*`.

- Admin API {#api}

    Если для управления топиками используется Kafka Admin API:

    1. Создайте [пользователя-администратора](../../managed-kafka/operations/cluster-accounts.md) с именем `kafka-user`.

    1. Помимо роли `ACCESS_ROLE_ADMIN` назначьте пользователю-администратору роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` для топиков, имена которых начинаются с префикса `cdc`.

        Необходимые топики будут созданы автоматически при первом событии изменения в отслеживаемых таблицах кластера-источника. Такое решение может быть удобным для отслеживания изменений во множестве таблиц, однако, требует запас свободного места в хранилище кластера. Подробнее в разделе [Хранилище в Managed Service for Apache Kafka®](../../managed-kafka/concepts/storage.md).

{% endlist %}

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для источника MySQL® с [настройками](../../data-transfer/operations/endpoint/source/mysql.md):

    * **Тип базы данных** — `MySQL`.
    * **Параметры эндпоинта**:
        * **Настройки подключения** — `Кластер Managed Service for MySQL`.
        * **Кластер Managed Service for MySQL** — выберите [созданный ранее](#before-you-begin) кластер Managed Service for MySQL®.
        * **База данных** — `db1`.
        * **Пользователь** — `my-user`.
        * **Пароль** — укажите пароль пользователя `my-user`.
        * **Список включённых таблиц** — `db1.measurements`.

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для приемника Apache Kafka® с [настройками](../../data-transfer/operations/endpoint/source/kafka.md):

    * **Тип базы данных** — `Kafka`.
    * **Параметры эндпоинта**:
        * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.
            * **Кластер Managed Service for Apache Kafka** — выберите [созданный ранее](#before-you-begin) кластер Managed Service for Apache Kafka®.
            * **Аутентификация** — укажите данные созданного ранее пользователя `kafka-user`.

        * **Топик** — `Полное имя топика`.
        * **Полное имя топика** — `cdc.db1.measurements`.

        Если необходимо отслеживать изменения в нескольких таблицах, заполните поля следующим образом:

        * **Топик** — `Префикс топика`.
        * **Префикс топика** — укажите префикс `cdc`, использованный при формировании имен топиков.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_** с созданными эндпоинтами для источника и приемника.
1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

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
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
        -Z \
        -K:
    ```

    FQDN хостов-брокеров можно получить со [списком хостов в кластере Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-hosts.md).

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

### Особенности поставки данных с помощью Data Transfer {#features}

* При переносе данных из MySQL® в Apache Kafka® некоторые типы данных переносятся с изменениями:

  * тип `tinyint(1)` переносится как `boolean`;
  * тип `real` переносится как `double`;
  * тип `bigint unsigned` переносится как `int64`.

* В блоке метаинформации об источнике `payload.source` параметры `server_id` и `thread` не заполняются.

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) и [удалите](../../data-transfer/operations/transfer.md#delete) трансфер.

1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).

1. Удалите кластеры:

    * [Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md);
    * [Managed Service for MySQL®](../operations/cluster-delete.md).

1. Если для доступа к хостам кластеров использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.