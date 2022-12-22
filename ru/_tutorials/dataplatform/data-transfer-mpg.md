# Поставка данных из {{ mpg-full-name }} в {{ mkf-full-name }} с помощью {{ data-transfer-full-name }}

Вы можете отслеживать изменения данных в _кластере-источнике_ {{ mpg-name }} и отправлять их в _кластер-приемник_ {{ mkf-name }} с помощью технологии Change Data Capture (CDC).

Чтобы настроить CDC с использованием сервиса {{ data-transfer-name }}:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте кластер-приемник](#prepare-target).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер-источник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * с базой данных `db1`;
    * с пользователем `pg-user`;
    * с хостами в публичном доступе.

1. [Создайте кластер-приемник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

1. Настройте группы безопасности кластеров, чтобы к ним можно было подключаться из интернета:

    * [Инструкция для {{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups).
    * [Инструкция для {{ mkf-name }}](../../managed-kafka/operations/connect.md#configuring-security-groups).

1. Установите на локальный компьютер [утилиту](https://github.com/edenhill/kcat) `kcat` (`kafkacat`) и [клиент командной строки PostgreSQL](https://www.postgresql.org/download/). Например, в Ubuntu 20.04 выполните команду:

    ```bash
    sudo apt update && sudo apt install kafkacat postgresql-client --yes
    ```

## Подготовьте кластер-источник {#prepare-source}

1. Чтобы сервис {{ data-transfer-name }} мог получать от кластера {{ mpg-name }} уведомления об изменениях в данных, в кластере-источнике необходимо создать публикацию (publication). Чтобы пользователь `pg-user` мог создать публикацию, [назначьте](../../managed-postgresql/operations/grant.md) ему роль роль `mdb_replication`.

1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect.md) `db1` от имени пользователя `pg-user`.

1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию с некоторых датчиков автомобиля.

    Создайте таблицу:

    ```sql
    CREATE TABLE public.measurements (
        "device_id" text PRIMARY KEY NOT NULL,
        "datetime" timestamp NOT NULL,
        "latitude" real NOT NULL,
        "longitude" real NOT NULL,
        "altitude" real NOT NULL,
        "speed" real NOT NULL,
        "battery_voltage" real,
        "cabin_temperature" real NOT NULL,
        "fuel_level" real
    );
    ```

    Наполните таблицу данными:

    ```sql
    INSERT INTO public.measurements VALUES
        ('iv9a94th6rztooxh5ur2', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qmz3sdbrbu', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th678tooxh5ur2', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

## Подготовьте кластер-приемник {#prepare-target}

Настройки различаются в зависимости от используемого [способа управления топиками](../../managed-kafka/concepts/topics.md#management). При этом имена топиков для данных конструируются по тому же принципу, что и в [Debezium](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names) — `<префикс топика>.<имя схемы>.<имя таблицы>`. В этом руководстве в качестве примера будет использоваться префикс `cdc`.

{% list tabs %}

* Интерфейсы {{ yandex-cloud }}

    Если управление топиками осуществляется с помощью стандартных интерфейсов {{ yandex-cloud }} (Консоль управления, YC CLI, {{ TF }}, API):

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `cdc.public.measurements`.

        Если необходимо отслеживать изменения в нескольких таблицах, создайте для каждой из них отдельный топик.

    1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `kafka-user` и ролями `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER`, действующими на созданные топики.

* Admin API

    Если для управления топиками используется Kafka Admin API:

    1. Создайте [пользователя-администратора](../../managed-kafka/operations/cluster-accounts.md) с именем `kafka-user`.

    1. Помимо роли `ACCESS_ROLE_ADMIN` назначьте пользователю-администратору роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` на топики, имена которых начинаются с префикса `cdc`.

        Необходимые топики будут созданы автоматически при первом событии изменения в отслеживаемых таблицах кластера-источника. Такое решение может быть удобным для отслеживания изменений во множестве таблиц, однако, требует запас свободного места в хранилище кластера. Подробнее см. в разделе [{#T}](../../managed-kafka/concepts/storage.md).

{% endlist %}


## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинты](../../data-transfer/operations/endpoint/index.md#create).

    * Эндпоинт для источника:

        * **Тип базы данных** — `PostgreSQL`.
        * **Параметры эндпоинта**:
            * **Настройки подключения** — `Кластер MDB`.
            * **Кластер MDB** — выберите [созданный ранее](#before-you-begin) кластер {{ mpg-name }}.
            * **Имя базы данных** — `db1`.
            * **Имя пользователя** — `pg-user`.
            * **Пароль** — укажите пароль пользователя `pg-user`.
            * **Список включенных таблиц** — `public.measurements`.

    * Эндпоинт для приемника:

        * **Тип базы данных** — `Kafka`.
        * **Параметры эндпоинта**:
            * **Подключение** — `Managed Kafka`.
            * **Managed Kafka**:
                * **ID кластера Managed Kafka** — выберите кластер-приемник.
                * **Аутентификация** — укажите данные созданного ранее пользователя `kafka-user`.

            * **Настройки кафка-топика** — `Полное имя топика`.
            * **Полное имя топика** — `cdc.public.measurements`.

            Если необходимо отслеживать изменения в нескольких таблицах, заполните поля следующим образом:

            * **Настройки кафка-топика** — `Префикс топика`.
            * **Префикс топика** — укажите префикс `cdc`, использованный при формировании имен топиков.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) со следующими настройками:

    * **Эндпоинты**:
        * **Источник** — созданный ранее эндпоинт для источника.
        * **Приемник** — созданный ранее эндпоинт для приемника.
    * **Тип трансфера** — {{ dt-type-repl }}.

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-repl }}.

## Проверьте работоспособность трансфера {#verify-transfer}

1. В отдельном терминале запустите утилиту `kafkacat` в режиме потребителя:

    ```bash
    kafkacat \
        -C \
        -b <FQDN хоста-брокера-1>:9091,...,<FQDN хоста-брокера N>:9091 \
        -t cdc.public.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<пароль> \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
        -Z \
        -K:
    ```

    FQDN хостов-брокеров можно получить со [списком хостов в кластере {{ mkf-name }}](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

    Будет выведена схема формата данных таблицы `public.measurements` и данные о добавленных в нее ранее строках.

    {% cut "Пример фрагмента сообщения" %}

    ```json
    {
      "payload": {
        "consumer":"dttuhfpp97l30jaka3ql"
      },
      "schema": {
        "fields": [
          {
            "field": "consumer",
            "optional":false,
            "type":"string"
          }
        ],
        "name": "__data_transfer_stub.public.__consumer_keeper.Key",
        "optional":false,
        "type":"struct"
      }
    }:{
      "payload": {
        "after": {
          "consumer":"dttuhfpp97l30jaka3ql",
          "locked_by":"dttuhfpp97l30jaka3ql-1",
          "locked_till":"2022-05-15T09:55:18Z"
        },
      "before": null,
      "op":"u",
      "source": {
        "connector":"postgresql",
        "db":"db1",
        "lsn":85865797008,
        "name":"__data_transfer_stub",
        "schema":"public",
        "snapshot":"false",
        "table":"__consumer_keeper",
        "ts_ms":1652608518883,
        "txId":245165,
        "version":"1.1.2.Final",
        "xmin":null
      },
    ...
    ```

    {% endcut %}

1. Подключитесь к кластеру-источнику и добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO public.measurements VALUES ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что в терминале с запущенной утилитой `kafkacat` отобразились сведения о добавленной строке.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) и [удалите](../../data-transfer/operations/transfer.md#delete) трансфер.

1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).

1. Удалите кластеры:

    * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
    * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

1. Если для доступа к хостам кластеров использовались статические публичные IP-адреса, освободите и {% if audience != "internal" %}[удалите](../../vpc/operations/address-delete.md){% else %}удалите{% endif %} их.
