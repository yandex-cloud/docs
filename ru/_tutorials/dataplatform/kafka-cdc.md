# Поставка данных из {{ mpg-name }} в {{ mkf-name }} с помощью Debezium

Вы можете отслеживать изменения данных в {{ mpg-name }} и отправлять их в {{ mkf-name }} с помощью технологии Change Data Capture (CDC).

Далее будет продемонстрировано на примере, как настроить CDC с помощью [Debezium](https://debezium.io/documentation/reference/index.html).


## Перед началом работы {#before-you-begin}

1. Создайте *кластер-источник* [{{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md):

    * с хостами в публичном доступе;
    * с базой данных `db1`;
    * с пользователем `user1`.

1. Создайте *кластер-приемник* [{{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей вам конфигурации с хостами в публичном доступе.
{% if audience != "internal" %}

1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для Debezium с [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) из {{ marketplace-name }} и публичным IP-адресом.

{% else %}

1. Создайте виртуальную машину для Debezium с [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) из {{ marketplace-name }} и публичным IP-адресом.

{% endif %}

1. Настройте группы безопасности так, чтобы к кластерам можно было подключиться из созданной виртуальной машины:

    * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups);
    * [{{ mkf-name }}](../../managed-kafka/operations/connect.md#configuring-security-groups).
{% if audience != "internal" %}

1. [Подключитесь к виртуальной машине](../../compute/operations/vm-connect/ssh.md#vm-connect) по SSH и установите зависимости:

{% else %}

1. Подключитесь к виртуальной машине по SSH и установите зависимости:

{% endif %}
    ```bash
    sudo apt update && \
    sudo apt install -y git docker.io kafkacat postgresql-client
    ```
{% if audience != "internal" %}

1. [Подключитесь к виртуальной машине](../../compute/operations/vm-connect/ssh.md#vm-connect) по SSH и проверьте, что доступны кластеры:

{% else %}

1. Подключитесь к виртуальной машине по SSH и проверьте, что доступны кластеры:

{% endif %}
    * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#connection-string) (используйте утилиту `psql`);
    * [{{ mkf-name }}](../../managed-kafka/operations/connect.md#connection-string) (используйте утилиту `kafkacat`).


## Подготовьте кластер-источник {#prepare-source}

{% list tabs %}

- {{ mpg-name }}

    1. [Назначьте пользователю](../../managed-postgresql/operations/grant.md) `user1` роль `mdb_replication`.

        Это нужно для создания публикации (publication), с помощью которой Debezium будет отслеживать изменения в кластере {{ mpg-name }}.

    1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect.md) `db1` кластера {{ mpg-name }} от имени пользователя `user1`.

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
{% if audience != "internal" %}

1. [Подключитесь к виртуальной машине](../../compute/operations/vm-connect/ssh.md#vm-connect) по SSH.

{% else %}

1. Подключитесь к виртуальной машине по SSH.

{% endif %}

1. Склонируйте репозиторий:

    ```bash
    cd ~/ && \
    git clone https://github.com/yandex-cloud/examples.git
    ```

1. Скачайте и распакуйте актуальный [Debezium-коннектор](https://debezium.io/releases/) в директорию `~/examples/mdb/managed-kafka/debezium-cdc/plugins/`. 

    Ниже приведен пример для версии `1.6.0`. Нужные команды зависят от типа кластера-источника:

    {% list tabs %}

    - {{ mpg-name }}

        ```bash
        mkdir  ~/examples/mdb/managed-kafka/debezium-cdc/plugins/ && \
        wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/1.6.0.Final/debezium-connector-postgres-1.6.0.Final-plugin.tar.gz && \
        tar -xzvf debezium-connector-postgres-1.6.0.Final-plugin.tar.gz -C ~/examples/mdb/managed-kafka/debezium-cdc/plugins/
        ```

   {% endlist %}

1. Соберите образ Docker:

    ```bash
    cd ~/examples/mdb/managed-kafka/debezium-cdc && \
    sudo docker build --tag debezium ./
    ```

1. Создайте файл `~/examples/mdb/managed-kafka/debezium-cdc/mdb-connector.properties` с настройками Debezium для подключения к кластеру-источнику:

    {% list tabs %}

    - {{ mpg-name }}

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
        * `database.hostname` — [особый FQDN](../../managed-postgresql/operations/connect.md#fqdn-master) для подключения к хосту-мастеру кластера-источника. Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-postgresql/operations/cluster-list.md#list).
        * `database.user` — имя пользователя {{ PG }}.
        * `database.dbname` — имя базы данных {{ PG }}.
        * `database.server.name` — произвольное имя сервера баз данных, которое [Debezium будет использовать](#prepare-target) при выборе топика для отправки сообщений.
        * `table.include.list` — список имен таблиц, для которых Debezium должен отслеживать изменения. Укажите полные имена, включающие в себя имя схемы (по умолчанию `public`). [Debezium будет использовать](#prepare-target) значения настроек из этого поля при выборе топика для отправки сообщений.
        * `publication.name` — имя публикации, [созданной на кластере-источнике](#prepare-source).
        * `slot.name` — имя слота репликации, который будет создан Debezium при работе с публикацией.
        * `heartbeat.interval.ms` и `heartbeat.topics.prefix` — настройки heartbeat, [необходимые для работы](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-wal-disk-space) Debezium.

    {% endlist %}


## Подготовьте кластер-приемник {#prepare-target}

Настройки кластера-приемника зависят от типа кластера-источника:

{% list tabs %}

- {{ mpg-name }}

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) `mpg.public.measurements`, в который будут помещаться данные, поступающие от кластера-источника.

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

    1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) `debezium`.

        [Выдайте ему](../../managed-kafka/operations/cluster-accounts.md#grant-permission) следующие права на созданные топики:

        * `ACCESS_ROLE_CONSUMER`
        * `ACCESS_ROLE_PRODUCER`

{% endlist %}


## Запустите Debezium {#start-debezium}

1. Укажите в файле `~/examples/mdb/managed-kafka/debezium-cdc/.env` переменные окружения, используемые для доступа к кластеру-приемнику:

    ```ini
    BROKERS=<FQDN хоста-брокера>:9091
    USER=debezium
    PASSWORD=<пароль пользователя debezium>
    ```

    Список FQDN хостов-брокеров можно запросить со [списком хостов в кластере](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

1. Запустите контейнер с собранным Docker-образом:

    ```bash
    cd ~/examples/mdb/managed-kafka/debezium-cdc/ && \
    sudo docker run --name debezium --rm --env-file .env \
      -v ~/examples/mdb/managed-kafka/debezium-cdc/plugins:/home/appuser/plugins \
      -v ~/examples/mdb/managed-kafka/debezium-cdc/mdb-connector.properties:/home/appuser/config/connector.properties \
      debezium:latest
    ```

    Контейнер будет непрерывно передавать новые данные из кластера-источника в кластер-приемник.


## Проверьте работоспособность Debezium {#test-debezium}

1. [Подключитесь к кластеру-приемнику](../../managed-kafka/operations/connect.md#connection-string), например, с помощью [kafkacat](../../managed-kafka/operations/connect.md#bash), и проверьте, что данные поступают.

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

        1. [Подключитесь к кластеру](../../managed-postgresql/operations/connect.md).

        1. Добавьте еще одну строку в таблицу `measurements`:

            ```sql
            INSERT INTO public.measurements VALUES ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
            ```

    {% endlist %}

1. Подключитесь к кластеру-приемнику и убедитесь, что в топик `mpg.public.measurements` попали новые данные.


## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
{% if audience != "internal" %}

1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).

1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).

{% else %}

1. Удалите виртуальную машину.

1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, удалите его.

{% endif%}

1. Удалите кластеры:

    * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md);
    * [{{ mkf-full-name }}](../../managed-kafka/operations/cluster-delete.md).
