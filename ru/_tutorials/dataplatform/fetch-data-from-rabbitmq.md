# Получение данных из {{ RMQ }} в {{ mch-full-name }}

В кластер {{ mch-name }} можно поставлять данные из {{ RMQ }} в реальном времени. {{ mch-name }} будет автоматически вставлять в таблицу на [движке {{ RMQ }}]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/) данные, поступающие на определенные точки обмена указанных очередей {{ RMQ }}.

Чтобы настроить поставку данных из {{ RMQ }} в {{ mch-name }}:

1. [Настройте интеграцию с {{ RMQ }} для кластера {{ mch-name }}](#configure-mch-for-rmq).
1. [Создайте в кластере {{ mch-name }} таблицу на движке {{ RMQ }}](#create-rmq-table).
1. [Отправьте тестовые данные в очередь {{ RMQ }}](#send-sample-data-to-rmq).
1. [Проверьте наличие тестовых данных в таблице кластера {{ mch-name }}](#fetch-sample-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей вам конфигурации с базой данных `db1`. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к хостам кластера при его создании.

        {% note info %}

        Интеграцию с {{ RMQ }} можно настроить уже на этапе создания кластера. В этой статье интеграция будет настроена [позже](#configure-mch-for-rmq).

        {% endnote %}

    1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для {{ RMQ }}. Для подключения к виртуальной машине с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ при ее создании.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [clickhouse-cluster-and-vm-for-rabbitmq.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-cluster-and-vm-for-rabbitmq.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * кластер {{ mch-name }};
        * виртуальная машина.

    1. Укажите в файле `clickhouse-cluster-and-vm-for-rabbitmq.tf`:

        * Имя пользователя и пароль, которые будут использоваться для доступа к кластеру {{ mch-name }}.
        * Идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) с [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) без [GPU](../../glossary/gpu.md) для виртуальной машины.
        * Логин и путь к файлу [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в используемом образе указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Выполните дополнительные настройки {#additional-settings}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по [SSH](../../glossary/ssh-keygen.md).

    1. Установите {{ RMQ }}:

        ```bash
        sudo apt update && sudo apt install rabbitmq-server --yes
        ```

    1. Создайте пользователя для {{ RMQ }}:

        ```bash
        sudo rabbitmqctl add_user <имя_пользователя> <пароль>
        ```

    1. Выдайте этому пользователю права на подключение к серверу:

        ```bash
        sudo rabbitmqctl set_permissions -p / <имя_пользователя> ".*" ".*" ".*" && \
        sudo rabbitmqctl set_topic_permissions -p / <имя_пользователя> amq.topic "cars" "cars"
        ```

1. Установите утилиты `amqp-publish` и `amqp-declare-queue` для работы с {{ RMQ }} и [jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

    ```bash
    sudo apt update && sudo apt install amqp-tools --yes && sudo apt-get install jq --yes
    ```

1. Убедитесь, что можете создать в {{ RMQ }} очередь `cars` с помощью `amqp-declare-queue`:

    ```bash
    amqp-declare-queue \
        --url=amqp://<имя_пользователя>:<пароль>@<IP-адрес_или_FQDN_сервера_RabbitMQ>:5672 \
        --queue=cars
    ```

1. Установите утилиту `clickhouse-client` для подключения к базе данных в кластере {{ mch-name }}.

    1. Подключите [DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

        ```bash
        sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
        echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
        /etc/apt/sources.list.d/clickhouse.list
        ```

    1. Установите зависимости:

        ```bash
        sudo apt update && sudo apt install clickhouse-client --yes
        ```

    1. Загрузите файл конфигурации для `clickhouse-client`:

        {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

    Убедитесь, что можете с помощью `clickhouse-client` [подключиться к кластеру {{ mch-name }} через SSL](../../managed-clickhouse/operations/connect.md#connection-string).

## Настройте интеграцию {{ RMQ }} для кластера {{ mch-name }} {#configure-mch-for-rmq}

{% list tabs group=instructions %}

- Вручную {#manual}

    Укажите в [настройках кластера {{ mch-name }}](../../managed-clickhouse/operations/update.md#change-clickhouse-config) имя пользователя и пароль для аутентификации {{ RMQ }} в секции **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **Rabbitmq**.

- {{ TF }} {#tf}

    Добавьте к описанию кластера блок `clickhouse.config.rabbitmq` с именем пользователя и паролем для аутентификации {{ RMQ }}:

    ```hcl
    resource "yandex_mdb_clickhouse_cluster" "clickhouse-cluster" {
      ...
      clickhouse {
        ...
        config {
          rabbitmq {
            username = "<имя_пользователя>"
            password = "<пароль>"
          }
        }
        ...
      }
    }
    ```

{% endlist %}

## Создайте в кластере {{ mch-name }} таблицу на движке {{ RMQ }} {#create-rmq-table}

Пусть в {{ RMQ }} в очередь `cars` на точке обмена `exchange` в {{ RMQ }} будут помещены данные от сенсоров автомобиля в формате JSON:

* строковый идентификатор устройства `device_id`;
* дата и время формирования данных `datetime` в формате `YYYY-MM-DD HH:MM:SS`;
* координаты автомобиля:

    * широта `latitude`;
    * долгота `longitude`;
    * высота над уровнем моря `altitude`;

* текущая скорость `speed`;
* напряжение батарей `battery_voltage` (для электромобиля, для автомобиля с ДВС значение этого параметра — `null`);
* температура в салоне `cabin_temperature`;
* уровень топлива `fuel_level` (для автомобиля с ДВС, для электромобиля значение этого параметра — `null`).

Эти данные будут передаваться в виде сообщений {{ RMQ }}. Каждое такое сообщение будет содержать JSON-объект как строку следующего вида:

```json
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

Кластер {{ mch-name }} будет использовать при вставке в таблицу [формат данных JSONEachRow]({{ ch.docs }}/interfaces/formats/#jsoneachrow), который преобразует строки из сообщения {{ RMQ }} в нужные значения столбцов.

Создайте в кластере {{ mch-name }} таблицу, в которую будут заноситься поступающие от {{ RMQ }} данные:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.

1. Выполните запрос:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.cars (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE = RabbitMQ
    SETTINGS
        rabbitmq_host_port = '<внутренний_IP-адрес_ВМ_с_RabbitMQ>:5672',
        rabbitmq_routing_key_list = 'cars',
        rabbitmq_exchange_name = 'exchange',
        rabbitmq_format = 'JSONEachRow';
    ```

Эта таблица будет автоматически наполняться сообщениями, считываемыми из очереди `cars` в точке обмена `exchange` {{ RMQ }}. При чтении данных {{ mch-name }} использует [указанные ранее данные](#configure-mch-for-rmq) для аутентификации.

## Отправьте тестовые данные в очередь {{ RMQ }} {#send-sample-data-to-rmq}

1. Создайте файл `sample.json` с тестовыми данными:

    ```json
    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-05 17:27:00",
        "latitude": 55.70329032,
        "longitude": 37.65472196,
        "altitude": 427.5,
        "speed": 0,
        "battery_voltage": 23.5,
        "cabin_temperature": 17,
        "fuel_level": null
    }

    {
        "device_id": "rhibbh3y08qm********",
        "datetime": "2020-06-06 09:49:54",
        "latitude": 55.71294467,
        "longitude": 37.66542005,
        "altitude": 429.13,
        "speed": 55.5,
        "battery_voltage": null,
        "cabin_temperature": 18,
        "fuel_level": 32
    }

    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-07 15:00:10",
        "latitude": 55.70985913,
        "longitude": 37.62141918,
        "altitude": 417.0,
        "speed": 15.7,
        "battery_voltage": 10.3,
        "cabin_temperature": 17,
        "fuel_level": null
    }
    ```

1. Отправьте в созданную ранее очередь `cars` в точку обмена `exchange` данные из файла `sample.json` с помощью `jq` и `amqp-publish`.

    ```bash
    jq \
    --raw-output \
    --compact-output . ./sample.json |\
    amqp-publish \
    --url=amqp://<имя_пользователя_RabbitMQ>:<пароль>@<IP-адрес_или_FQDN_сервера_RabbitMQ>:5672 \
    --routing-key=cars \
    --exchange=exchange
    ```

## Проверьте наличие тестовых данных в таблице кластера {{ mch-name }} {#fetch-sample-data}

Для доступа к данным используйте материализованное представление (`MATERIALIZED VIEW`). Когда к таблице на движке `{{ RMQ }}` присоединяется материализованное представление, оно начинает в фоновом режиме собирать данные. Это позволяет непрерывно получать сообщения от {{ RMQ }} и преобразовывать их в необходимый формат с помощью `SELECT`.

{% note info %}

Сообщение из очереди может быть прочитано {{ CH }} только один раз, поэтому вместо чтения данных напрямую из таблицы используйте материализованное представление.

{% endnote %}

Чтобы создать материализованное представление для таблицы `db1.cars`:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.

1. Выполните запросы:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.cars_data_source (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE MergeTree()
      ORDER BY device_id;

    CREATE MATERIALIZED VIEW db1.cars_view TO db1.cars_data_source
      AS SELECT * FROM db1.cars;
    ```

Чтобы получить все данные из материализованного представления `db1.cars_view`:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.

1. Выполните запрос:

    ```sql
    SELECT * FROM db1.cars_view;
    ```

Запрос вернет таблицу с данными, отправленными в {{ RMQ }}.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер {{ mch-full-name }}](../../managed-clickhouse/operations/cluster-delete.md).
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `clickhouse-cluster-and-vm-for-rabbitmq.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `clickhouse-cluster-and-vm-for-rabbitmq.tf`, будут удалены.

{% endlist %}
