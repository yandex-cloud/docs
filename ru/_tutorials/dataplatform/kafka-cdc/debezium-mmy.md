# Поставка данных из {{ mmy-full-name }} в {{ mkf-full-name }} с помощью Debezium

Вы можете отслеживать изменения данных в {{ mmy-name }} и отправлять их в {{ mkf-name }} с помощью технологии Change Data Capture (CDC).

Из этой статьи вы узнаете, как создать в {{ yandex-cloud }} виртуальную машину и настроить на ней [Debezium](https://debezium.io/documentation/reference/index.html) — программное обеспечение, используемое для CDC.

## Перед началом работы {#before-you-begin}

1. [Создайте _кластер-источник_](../../../managed-mysql/operations/cluster-create.md) со следующими настройками:

    * с хостами в публичном доступе;
    * с базой данных `db1`;
    * с пользователем `user1`.

1. [Создайте _кластер-приемник_ {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

1. [Создайте виртуальную машину](../../../compute/operations/vm-create/create-linux-vm.md) с Ubuntu 20.04 и публичным IP-адресом.

1. Настройте группы безопасности так, чтобы к кластерам можно было подключаться из интернета и созданной виртуальной машины, а к ней — из интернета по SSH:

    * [Настройка групп безопасности кластера {{ mkf-name }}](../../../managed-kafka/operations/connect.md#configuring-security-groups).
    * [Настройка групп безопасности кластера {{ mmy-name }}](../../../managed-mysql/operations/connect.md#configure-security-groups).

1. [Подключитесь к виртуальной машине по SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect) и выполните ее предварительную настройку:

    1. Установите зависимости:

        ```bash
        sudo apt update && \
            sudo apt install kafkacat openjdk-17-jre mysql-client --yes
        ```

    1. Создайте директорию для {{ KF }}:

        ```bash
        sudo mkdir -p /opt/kafka/
        ```

    1. Скачайте и распакуйте в эту директорию архив с исполняемыми файлами {{ KF }}. Например, для загрузки и распаковки {{ KF }} версии 3.0 выполните команду:

        ```bash
        wget https://archive.apache.org/dist/kafka/3.0.0/kafka_2.13-3.0.0.tgz && \
        sudo tar xf kafka_2.13-3.0.0.tgz --strip 1 --directory /opt/kafka/
        ```

        Актуальную версию {{ KF }} уточняйте на [странице загрузок проекта](https://kafka.apache.org/downloads).

    1. Установите на виртуальную машину сертификаты и убедитесь в доступности кластеров:

        * [{{ mkf-name }}](../../../managed-kafka/operations/connect.md) (используйте утилиту `kafkacat`).
        * [{{ mmy-name }}](../../../managed-mysql/operations/connect.md#get-ssl-cert) (используйте утилиту `mysql`).

    1. Создайте директорию, в которой будут храниться файлы, необходимые для работы коннектора Debezium:

        ```bash
        sudo mkdir -p /etc/debezium/plugins/
        ```

    1. Чтобы коннектор Debezium мог подключаться к хостам-брокерам {{ mkf-name }}, добавьте SSL-сертификат в защищенное хранилище сертификатов Java (Java Key Store). Для дополнительной защиты хранилища в параметре `-storepass` укажите пароль длиной не меньше 6 символов:

        ```bash
        sudo keytool \
            -importcert \
            -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt \
            -keystore /etc/debezium/keystore.jks \
            -storepass <пароль JKS> \
            --noprompt
        ```

## Подготовка кластера-источника {#prepare-source}

1. [Назначьте пользователю](../../../managed-mysql/operations/cluster-users.md#update-settings) `user1` глобальные привилегии `REPLICATION CLIENT` и `REPLICATION SLAVE`.

1. [Подключитесь к базе данных](../../../managed-mysql/operations/connect.md) `db1` от имени пользователя `user1`.

1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию с некоторых датчиков автомобиля.

    1. Создайте таблицу:

        ```sql
        CREATE TABLE measurements (
          `device_id` VARCHAR(32) PRIMARY KEY NOT NULL,
          `datetime` TIMESTAMP NOT NULL,
          `latitude` REAL NOT NULL,
          `longitude` REAL NOT NULL,
          `altitude` REAL NOT NULL,
          `speed` REAL NOT NULL,
          `battery_voltage` REAL,
          `cabin_temperature` REAL NOT NULL,
          `fuel_level` REAL
        );
        ```

    1. Наполните таблицу данными:

        ```sql
        INSERT INTO measurements VALUES
          ('iv9a94th6rztooxh5ur2', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
          ('rhibbh3y08qmz3sdbrbu', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
          ('iv9a94th678tooxh5ur2', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
        ```

## Настройте коннектор Debezium {#setup-debezium}

1. Подключитесь к виртуальной машине по SSH.

1. Скачайте и распакуйте актуальный [Debezium-коннектор](https://debezium.io/releases/) в директорию `/etc/debezium/plugins/`.

    Актуальную версию коннектора уточняйте на [странице проекта](https://debezium.io/releases/). Ниже приведены команды для версии `1.9.4.Final`.

    ```bash
    VERSION="1.9.4.Final"
    wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/${VERSION}/debezium-connector-mysql-${VERSION}-plugin.tar.gz && \
        sudo tar -xzvf debezium-connector-mysql-${VERSION}-plugin.tar.gz -C /etc/debezium/plugins/
    ```

1. Создайте файл `/etc/debezium/mdb-connector.conf` с настройками коннектора Debezium для подключения к кластеру-источнику:

    ```init
    name=debezium-mmy
    connector.class=io.debezium.connector.mysql.MySqlConnector
    database.hostname=c-<идентификатор кластера>.rw.{{ dns-zone }}
    database.port=3306
    database.user=user1
    database.password=<пароль пользователя user1>
    database.dbname=db1
    database.server.name=mmy
    database.ssl.mode=required_identity
    table.include.list=db1.measurements
    heartbeat.interval.ms=15000
    heartbeat.topics.prefix=__debezium-heartbeat

    snapshot.mode=never
    include.schema.changes=false
    database.history.kafka.topic=dbhistory.mmy
    database.history.kafka.bootstrap.servers=<FQDN хоста-брокера 1>:9091,...,<FQDN хоста-брокера N>:9091

    # Producer settings
    database.history.producer.security.protocol=SSL
    database.history.producer.ssl.truststore.location=/etc/debezium/keystore.jks
    database.history.producer.ssl.truststore.password=<пароль JKS>
    database.history.producer.sasl.mechanism=SCRAM-SHA-512
    database.history.producer.security.protocol=SASL_SSL
    database.history.producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<пароль пользователя debezium>";

    # Consumer settings
    database.history.consumer.security.protocol=SSL
    database.history.consumer.ssl.truststore.location=/etc/debezium/keystore.jks
    database.history.consumer.ssl.truststore.password=<пароль JKS>
    database.history.consumer.sasl.mechanism=SCRAM-SHA-512
    database.history.consumer.security.protocol=SASL_SSL
    database.history.consumer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<пароль пользователя debezium>";
    ```

    Здесь:

    * `name` — логическое имя коннектора Debezium. Используется для внутренних нужд коннектора.
    * `database.hostname` — [особый FQDN](../../../managed-mysql/operations/connect.md#fqdn-master) для подключения к хосту-мастеру кластера-источника.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../../managed-mysql/operations/cluster-list.md#list-clusters).

    * `database.user` — имя пользователя {{ MY }}.
    * `database.dbname` — имя базы данных {{ MY }}.
    * `database.server.name` — имя сервера баз данных, которое [Debezium будет использовать](#prepare-target) при выборе топика для отправки сообщений.
    * `table.include.list` — имена таблиц, для которых Debezium должен отслеживать изменения. Укажите полные имена, включающие в себя имя базы данных (`db1`). [Debezium будет использовать](#prepare-target) значения настроек из этого поля при выборе топика для отправки сообщений.
    * `heartbeat.interval.ms` и `heartbeat.topics.prefix` — настройки heartbeat, [необходимые для работы](https://debezium.io/documentation/reference/connectors/mysql.html#mysql-property-heartbeat-interval-ms) Debezium.
    * `database.history.kafka.topic` — имя служебного топика, используемого коннектором для отправки уведомлений об изменениях в схеме данных кластера-источника.

## Подготовьте кластер-приемник {#prepare-target}

1. [Создайте топик](../../../managed-kafka/operations/cluster-topics.md#create-topic), в который будут помещаться данные, поступающие от кластера-источника:

    * **Имя** — `mmy.db1.measurements`.

        Имена топиков для данных [конструируются](https://debezium.io/documentation/reference/connectors/mysql.html#mysql-topic-names) по принципу `<имя сервера>.<имя базы данных>.<имя таблицы>`.

        Согласно [файлу настроек коннектора Debezium](#setup-debezium):

        * Имя сервера `mmy` указано в параметре `database.server.name`.
        * Имя базы данных `db1` указано вместо с именем таблицы `measurements` в параметре `table.include.list`.

    Если необходимо отслеживать изменения в нескольких таблицах, создайте для каждой из них отдельный топик.

1. Создайте служебный топик для отслеживания состояния коннектора:

    * **Имя** — `__debezium-heartbeat.mmy`.

        Имена служебных топиков [конструируются](https://debezium.io/documentation/reference/connectors/mysql.html#mysql-property-heartbeat-topics-prefix) по принципу `<префикс для heartbeat>.<имя сервера>`.

        Согласно [файлу настроек коннектора Debezium](#setup-debezium):

        * Префикс `__debezium-heartbeat` указан в параметре `heartbeat.topics.prefix`.
        * Имя сервера `mmy` указано в параметре `database.server.name`.

    * **Политика очистки лога** — `Compact`.

    Если необходимо получать данные из нескольких кластеров-источников, создайте для каждого из них отдельный служебный топик.

1. Создайте служебный топик для отслеживания изменений в схеме формата данных:

    * **Имя** — `dbhistory.mmy`.
    * **Политика очистки лога** — `Delete`.
    * **Количество разделов** — `1`.

1. [Создайте пользователя](../../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `debezium`.

1. [Выдайте пользователю `debezium` права](../../../managed-kafka/operations/cluster-accounts.md#grant-permission) `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` на созданные топики.

## Запустите коннектор Debezium {#run-connector}

1. Создайте файл с настройками воркера Debezium:

    `/etc/debezium/worker.conf`

    ```ini
    # AdminAPI connect properties
    bootstrap.servers=<FQDN хоста-брокера 1>:9091,...,<FQDN хоста-брокера N>:9091
    sasl.mechanism=SCRAM-SHA-512
    security.protocol=SASL_SSL
    ssl.truststore.location=/etc/debezium/keystore.jks
    ssl.truststore.password=<пароль JKS>
    sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<пароль учетной записи debezium>";

    # Producer connect properties
    producer.sasl.mechanism=SCRAM-SHA-512
    producer.security.protocol=SASL_SSL
    producer.ssl.truststore.location=/etc/debezium/keystore.jks
    producer.ssl.truststore.password=<пароль JKS>
    producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<пароль пользователя debezium>";

    # Worker properties
    plugin.path=/etc/debezium/plugins/
    key.converter=org.apache.kafka.connect.json.JsonConverter
    value.converter=org.apache.kafka.connect.json.JsonConverter
    key.converter.schemas.enable=true
    value.converter.schemas.enable=true
    offset.storage.file.filename=/etc/debezium/worker.offset
    ```

1. В отдельном терминале запустите коннектор:

    ```bash
    sudo /opt/kafka/bin/connect-standalone.sh \
        /etc/debezium/worker.conf \
        /etc/debezium/mdb-connector.properties
    ```

## Проверьте работоспособность Debezium {#verify-debezium}

1. В отдельном терминале запустите утилиту `kafkacat` в режиме потребителя:

    ```bash
    kafkacat \
        -C \
        -b <FQDN хоста-брокера-1>:9091,...,<FQDN хоста-брокера N>:9091 \
        -t mmy.db1.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=debezium \
        -X sasl.password=<пароль> \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexCA.crt \
        -Z \
        -K:
    ```

    Будет выведена схема формата данных таблицы `db1.measurements` и данные о добавленных в нее ранее строках.

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
            "version": "1.8.1.Final",
            "connector": "mysql",
            "name": "mmy",
            "ts_ms": 1628245046882,
            "snapshot": "true",
            "db": "db1",
            "sequence": "[null,\"4328525512\"]",
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

1. [Подключитесь к кластеру-источнику](../../../managed-mysql/operations/connect.md) и добавьте еще одну строку в таблицу `measurements`:

    ```sql
    INSERT INTO measurements VALUES ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что в терминале с запущенной утилитой `kafkacat` отобразились сведения о добавленной строке.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите виртуальную машину](../../../compute/operations/vm-control/vm-delete.md).

    Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, освободите и [удалите его](../../../vpc/operations/address-delete.md).

1. Удалите кластеры:

    * [{{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
    * [{{ mmy-name }}](../../../managed-mysql/operations/cluster-delete.md).
