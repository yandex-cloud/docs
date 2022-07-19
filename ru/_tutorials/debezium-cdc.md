Вы можете отслеживать изменения данных в {{ mpg-name }} и отправлять их в {{ mkf-name }} с помощью технологии Change Data Capture (CDC).

Чтобы настроить CDC с помощью [Debezium](https://debezium.io/documentation/reference/index.html):

1. [Подготовьте кластер-источник](#prepare-source).
1. [Настройте Debezium](#setup-debezium).
1. [Подготовьте кластер-приемник](#prepare-target).
1. [Запустите процесс с Debezium-коннектором](#start-debezium).
1. [Проверьте работоспособность Debezium](#test-debezium).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте *кластер-источник* [{{ mpg-name }}](../managed-postgresql/operations/cluster-create.md):

    * с хостами в публичном доступе;
    * с базой данных `db1`;
    * с пользователем `user1`.

1. Создайте *кластер-приемник* [{{ mkf-name }}](../managed-kafka/operations/cluster-create.md) любой подходящей вам конфигурации с хостами в публичном доступе.
{% if audience != "internal" %}

1. [Создайте виртуальную машину](../compute/operations/vm-create/create-linux-vm.md) для Debezium с Ubuntu 20.04 и публичным IP-адресом.

{% else %}

1. Создайте виртуальную машину для Debezium с Ubuntu 20.04 и публичным IP-адресом.

{% endif %}

1. Настройте группы безопасности так, чтобы к кластерам можно было подключиться из созданной виртуальной машины:

    * [{{ mpg-name }}](../managed-postgresql/operations/connect.md#configuring-security-groups);
    * [{{ mkf-name }}](../managed-kafka/operations/connect.md#configuring-security-groups).
{% if audience != "internal" %}

1. [Подключитесь к виртуальной машине](../compute/operations/vm-connect/ssh.md#vm-connect) по SSH и проверьте доступ к кластерам:

{% else %}

1. Подключитесь к виртуальной машине по SSH и проверьте доступ к кластерам:

{% endif %}
    1. Установите зависимости:

       ```bash
       sudo apt update && \
       sudo apt install -y git docker.io kafkacat postgresql-client
       ```

    2. Проверьте, что доступны кластеры:
       * [{{ mpg-name }}](../managed-postgresql/operations/connect.md#connection-string) (используйте утилиту `psql`);
       * [{{ mkf-name }}](../managed-kafka/operations/connect.md#connection-string) (используйте утилиту `kafkacat`).

## Подготовьте кластер-источник {#prepare-source}

{% list tabs %}

- {{ mpg-name }}

    1. [Назначьте пользователю](../managed-postgresql/operations/grant.md) `user1` роль `mdb_replication`.

        Это нужно для создания публикации (publication), с помощью которой Debezium будет отслеживать изменения в кластере {{ mpg-name }}.

    1. [Подключитесь к базе данных](../managed-postgresql/operations/connect.md) `db1` кластера {{ mpg-name }} от имени пользователя `user1`.

    1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию с некоторых датчиков автомобиля.

        Создайте таблицу:

        ```sql
        CREATE TABLE public.measurements(
          "device_id" TEXT PRIMARY KEY NOT NULL,
          "datetime" TIMESTAMP NOT NULL,
          "latitude" REAL NOT NULL,
          "longitude" REAL NOT NULL,
          "altitude" REAL NOT NULL,
          "speed" REAL NOT NULL,
          "battery_voltage" REAL,
          "cabin_temperature" REAL NOT NULL,
          "fuel_level" REAL
        );
        ```

        Наполните таблицу данными:

        ```sql
        INSERT INTO public.measurements VALUES
          ('iv9a94th6rztooxh5ur2', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
          ('rhibbh3y08qmz3sdbrbu', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
          ('iv9a94th678tooxh5ur2', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
        ```

    1. Создайте публикацию для добавленной таблицы:

        ```sql
        CREATE PUBLICATION mpg_publication FOR TABLE public.measurements;
        ```

{% endlist %}

## Настройте Debezium {#setup-debezium}

{% list tabs %}

- {{ KFC }}

    1. [Подключитесь к виртуальной машине](../compute/operations/vm-connect/ssh.md#vm-connect) по SSH.

    1. Создайте файл настроек процесса-исполнителя `/etc/kafka-connect-worker/worker.properties`:

        ```ini
        # AdminAPI connect properties
        bootstrap.servers=<FQDN хоста-брокера>:9091
        sasl.mechanism=SCRAM-SHA-512
        security.protocol=SASL_SSL
        ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
        ssl.truststore.password=<пароль к хранилищу сертификата>
        sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<пароль учетной записи debezium>";

        # Producer connect properties
        producer.sasl.mechanism=SCRAM-SHA-512
        producer.security.protocol=SASL_SSL
        producer.ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
        producer.ssl.truststore.password=<пароль к хранилищу сертификата>
        producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<пароль учетной записи debezium>";

        # Worker properties
        plugin.path=/etc/kafka-connect-worker/plugins
        key.converter=org.apache.kafka.connect.json.JsonConverter
        value.converter=org.apache.kafka.connect.json.JsonConverter
        key.converter.schemas.enable=true
        value.converter.schemas.enable=true
        offset.storage.file.filename=/etc/kafka-connect-worker/worker.offset
        ```

        {{ KFC }} будет подключаться к кластеру {{ mkf-name }} от имени учетной записи `debezium`, которая будет создана при [подготовке кластера-приемника](#prepare-target).

        FQDN хостов-брокеров можно запросить со [списком хостов в кластере](../managed-kafka/operations/cluster-hosts.md#list-hosts).

    1. Скачайте и распакуйте актуальный [Debezium-коннектор](https://debezium.io/releases/) в директорию `/etc/kafka-connect-worker/plugins/`.

        Ниже приведен пример для версии `1.6.0`. Нужные команды зависят от типа кластера-источника:

        **{{ mpg-name }}**

        ```bash
        sudo mkdir -p ~/examples/mdb/managed-kafka/debezium-cdc/plugins/ && \
        wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/1.6.0.Finaldebezium-connector-postgres-1.6.0.Final-plugin.tar.gz && \
        sudo mkdir -p /etc/kafka-connect-worker/plugins && \
        sudo tar -xzvf debezium-connector-postgres-1.6.0.Final-plugin.tar.gz -C /etckafka-connect-worker/plugins/
        ```

    1. Создайте файл `/etc/kafka-connect-worker/plugins/mdb-connector.properties` с настройками Debezium для подключения к кластеру-источнику. Содержание файла зависит от типа кластера-источника:

        **{{ mpg-name }}**

        ```ini
        name=debezium-mpg
        connector.class=io.debezium.connector.postgresql.PostgresConnector
        plugin.name=pgoutput
        database.hostname=c-<идентификатор кластера>.rw.{{ dns-zone }}
        database.port=6432
        database.user=user1
        database.password=<пароль пользователя user1>
        database.dbname=db1
        database.server.name=mpg
        table.include.list=public.measurements
        publication.name=mpg_publication
        slot.name=debezium_slot
        heartbeat.interval.ms=15000
        heartbeat.topics.prefix=__debezium-heartbeat
        ```

        Где:

        * `name` — имя коннектора Debezium.
        * `database.hostname` — [особый FQDN](../managed-postgresql/operations/connect.md#fqdn-master) для подключения к хосту-мастеру кластера-источника. Идентификатор кластера можно запросить со [списком кластеров в каталоге](../managed-postgresql/operations/cluster-list.md#list).
        * `database.user` — имя пользователя {{ PG }}.
        * `database.dbname` — имя базы данных {{ PG }}.
        * `database.server.name` — произвольное имя сервера баз данных, которое [Debezium будет использовать](#prepare-target) при выборе топика для отправки сообщений.
        * `table.include.list` — список имен таблиц, для которых Debezium должен отслеживать изменения. Укажите полные имена, включающие в себя имя схемы (по умолчанию `public`). [Debezium будет использовать](#prepare-target) значения из этого поля при выборе топика для отправки сообщений.
        * `publication.name` — имя публикации, [созданной на кластере-источнике](#prepare-source).
        * `slot.name` — имя слота репликации, который будет создан Debezium при работе с публикацией.
        * `heartbeat.interval.ms` и `heartbeat.topics.prefix` — настройки heartbeat, [необходимые для работы](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-wal-disk-space) Debezium.

{% endlist %}

## Подготовьте кластер-приемник {{ mkf-name }} {#prepare-target}

Настройки кластера-приемника зависят от типа кластера-источника:

{% list tabs %}

- {{ mpg-name }}

    1. [Создайте топик](../managed-kafka/operations/cluster-topics.md#create-topic) `mpg.public.measurements`, в который будут помещаться данные, поступающие от кластера-источника.

        Имена топиков для данных [конструируются](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names) по принципу: `<имя сервера>.<имя схемы>.<имя таблицы>`.

        Согласно [файлу настроек Debezium](#setup-debezium):

        * Имя сервера `mpg` указано в параметре `database.server.name`.
        * Имя схемы `public` указано вместе с именем таблицы `measurements` в параметре `table.include.list`.

        Если необходимо получить данные из нескольких таблиц, создайте для каждой из них отдельный топик.

    1. Создайте служебный топик `__debezium-heartbeat.mpg` с политикой очистки лога `compact`.

        Имена служебных топиков [конструируются](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-property-heartbeat-topics-prefix) по принципу: `<префикс для heartbeat>.<имя сервера>`.

        Согласно [файлу настроек Debezium](#setup-debezium):

        * Префикс `__debezium-heartbeat` указан в параметре `heartbeat.topics.prefix`.
        * Имя сервера `mpg` указано в параметре `database.server.name`.

        Если необходимо получить данные из нескольких кластеров-источников, создайте для каждого из них отдельный служебный топик.

    1. [Создайте учетную запись](../managed-kafka/operations/cluster-accounts.md#create-account) `debezium` с паролем, указанным в [файле настроек процесса-исполнителя](#setup-debezium).

        [Выдайте ей](../managed-kafka/operations/cluster-accounts.md#grant-permission) права на созданные топики:

        * `ACCESS_ROLE_CONSUMER`
        * `ACCESS_ROLE_PRODUCER`

{% endlist %}

## Запустите процесс с Debezium-коннектором {#start-debezium}

1. [Подключитесь к виртуальной машине](../compute/operations/vm-connect/ssh.md#vm-connect) по SSH.

1. Чтобы отправить тестовые данные в кластер, запустите процесс-исполнитель:

    {% list tabs %}

    - {{ KFC }}

        ```bash
        cd ~/kafka_2.12-2.6.2/bin/ && \
        sudo ./connect-standalone.sh \
            /etc/kafka-connect-worker/worker.properties \
            /etc/kafka-connect-worker/plugins/mdb-connector.properties
        ```

    {% endlist %}

Процесс будет непрерывно передавать новые данные из кластера-источника в кластер-приемник.

## Проверьте работоспособность Debezium {#test-debezium}

1. [Подключитесь к кластеру-приемнику](../managed-kafka/operations/connect.md#connection-string), например, с помощью [kafkacat](../managed-kafka/operations/connect.md#bash), и проверьте, что данные поступают.

    В сообщениях топика `mpg.public.measurements` должны присутствовать данные и схема их формата.

    {% cut "Пример фрагмента сообщения" %}

    ```json
    {
    "schema": {
        ...
    },
    "payload": {
        "before": null,
        "after": {
            "device_id": "iv9a94th6rztooxh5ur2",
            "datetime": 1591378020000000,
            "latitude": 55.70329,
            "longitude": 37.65472,
            "altitude": 427.5,
            "speed": 0.0,
            "battery_voltage": 23.5,
            "cabin_temperature": 17.0,
            "fuel_level": null
        },
        "source": {
            "version": "1.6.0.Final",
            "connector": "postgresql",
            "name": "mpg",
            "ts_ms": 1628245046882,
            "snapshot": "true",
            "db": "db1",
            "sequence": "[null,\"4328525512\"]",
            "schema": "public",
            "table": "measurements",
            "txId": 8861,
            "lsn": 4328525328,
            "xmin": null
        },
        "op": "r",
        "ts_ms": 1628245046893,
        "transaction": null
      }
    }
    ```

    {% endcut %}

1. Добавьте данные в таблицу на кластере-источнике:

    {% list tabs %}

    - {{ mpg-name }}

        1. [Подключитесь к кластеру](../managed-postgresql/operations/connect.md).

        1. Добавьте еще одну строку в таблицу `measurements`:

            ```sql
            INSERT INTO public.measurements VALUES ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
            ```

    {% endlist %}

1. Убедитесь, что в топик `mpg.public.measurements` попали новые данные.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
{% if audience != "internal" %}

1. [Удалите виртуальную машину](../compute/operations/vm-control/vm-delete.md).

1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../vpc/operations/address-delete.md).

{% else %}

1. Удалите виртуальную машину.

1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, удалите его.

{% endif%}

1. Удалите кластеры:

    * [{{ mpg-name }}](../managed-postgresql/operations/cluster-delete.md);
    * [{{ mkf-name }}](../managed-kafka/operations/cluster-delete.md).
