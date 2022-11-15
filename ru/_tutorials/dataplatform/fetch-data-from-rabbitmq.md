# Получение данных из {{ RMQ }}

В кластер {{ mch-name }} можно поставлять данные из {{ RMQ }} в реальном времени. {{ mch-name }} будет автоматически вставлять в таблицу на [движке {{ RMQ }}]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/) данные, поступающие на определенные точки обмена указанных очередей {{ RMQ }}.

Чтобы настроить поставку данных из {{ RMQ }} в {{ mch-name }}:

1. [Настройте интеграцию с {{ RMQ }} для кластера {{ mch-name}}](#configure-mch-for-rmq).
1. [Создайте в кластере {{ mch-name }} таблицу на движке {{ RMQ }}](#create-rmq-table).
1. [Отправьте тестовые данные в очередь {{ RMQ }}](#send-sample-data-to-rmq).
1. [Проверьте наличие тестовых данных в таблице кластера {{ mch-name }}](#fetch-sample-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

    1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей вам конфигурации с базой данных `db1`. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к хостам кластера при его создании.

        {% note info %}

        Интеграцию с {{ RMQ }} можно настроить уже на этапе создания кластера. В этой статье интеграция будет настроена [позже](#configure-mch-for-rmq).

        {% endnote %}

    1. {% if audience != "internal" %}[Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md){% else %}Создайте виртуальную машину{% endif %} для {{ RMQ }}. Для подключения к виртуальной машине с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ при ее создании.

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [clickhouse-cluster-and-vm-for-rabbitmq.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-cluster-and-vm-for-rabbitmq.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * кластер {{ mch-name }};
        * виртуальная машина.

    1. Укажите в файле `clickhouse-cluster-and-vm-for-rabbitmq.tf`:

        * Имя пользователя и пароль, которые будут использоваться для доступа к кластеру {{ mch-name }}.
        * Идентификатор публичного {% if audience != "internal" %}[образа](../../compute/operations/images-with-pre-installed-software/get-list.md){% else %}образа{% endif %} с Ubuntu без GPU для виртуальной машины. Например, `fd879gb88170to70d38a` для Ubuntu 20.04 LTS.
        * Логин и путь к файлу {% if audience != "internal" %}[открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys){% else %}открытого ключа{% endif %}, которые будут использоваться для доступа к виртуальной машине. По умолчанию в используемом образе указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.

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

1. {% if audience != "internal" %}[Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по {% if lang == "ru" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}{% else %}Подключитесь к виртуальной машине по SSH{% endif %}.

    1. Установите {{ RMQ }}:

        ```bash
        sudo apt update && sudo apt install rabbitmq-server --yes
        ```

    1. Создайте пользователя для {{ RMQ }}:

        ```bash
        sudo rabbitmqctl add_user <имя пользователя> <пароль>
        ```

    1. Выдайте этому пользователю права на подключение к серверу:

        ```bash
        sudo rabbitmqctl set_permissions -p / <имя пользователя> ".*" ".*" ".*" && \
        sudo rabbitmqctl set_topic_permissions -p / <имя пользователя> amq.topic "cars" "cars"
        ```

1. Установите утилиты `amqp-publish` и `amqp-declare-queue` для работы с {{ RMQ }} и [jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

    ```bash
    sudo apt update && sudo apt install amqp-tools --yes && sudo apt-get install jq --yes
    ```

1. Убедитесь, что можете создать в {{ RMQ }} очередь `cars` с помощью `amqp-declare-queue`:

    ```bash
    amqp-declare-queue \
        --url=amqp://<имя пользователя>:<пароль>@<IP-адрес или FQDN сервера RabbitMQ>:5672 \
        --queue=cars
    ```

1. Установите утилиту `clickhouse-client` для подключения к базе данных в кластере {{ mch-name }}.

    1. Подключите {% if audience != "internal" %}[DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages){% else %}DEB-репозиторий{% endif %} {{ CH }}:

        ```bash
        sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
        echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
        /etc/apt/sources.list.d/clickhouse.list
        ```

    1. Установите зависимости:

        ```bash
        sudo apt update && sudo apt install clickhouse-client --yes
        ```

    1. Загрузите файл конфигурации для `clickhouse-client`:

        ```bash
        mkdir --parents ~/.clickhouse-client && \
        wget "https://{{ s3-storage-host }}/mdb/clickhouse-client.conf.example" \
        --output-document ~/.clickhouse-client/config.xml
        ```

    Убедитесь, что можете с помощью `clickhouse-client` [подключиться к кластеру {{ mch-name }} через SSL](../../managed-clickhouse/operations/connect.md#connection-string).

## Настройте интеграцию {{ RMQ }} для кластера {{ mch-name }} {#configure-mch-for-rmq}

{% list tabs %}

- Вручную

    Укажите в [настройках кластера {{ mch-name }}](../../managed-clickhouse/operations/update.md#change-clickhouse-config) имя пользователя и пароль для аутентификации {{ RMQ }} в секции **Настройки СУБД** → **Rabbitmq**.

- С помощью {{ TF }}

    Добавьте к описанию кластера блок `clickhouse.config.rabbitmq` c именем пользователя и паролем для аутентификации {{ RMQ }}:

    ```hcl
    resource "yandex_mdb_clickhouse_cluster" "clickhouse-cluster" {
      ...
      clickhouse {
        ...
        config {
          rabbitmq {
            username = "<имя пользователя>"
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
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
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
        rabbitmq_host_port = '<Внутренний IP-адрес ВМ с RabbitMQ>:5672',
        rabbitmq_routing_key_list = 'cars',
        rabbitmq_exchange_name = 'exchange',
        rabbitmq_format = 'JSONEachRow';
    ```

Эта таблица будет автоматически наполняться сообщениями, считываемыми из очереди `cars` в точке обмена `exchange` {{ RMQ }}. При чтении данных {{ mch-name }} использует [указанные ранее данные](#configure-mch-for-rmq) для аутентификации.

## Отправьте тестовые данные в очередь {{ RMQ }} {#send-sample-data-to-rmq}

1. Создайте файл `sample.json` с тестовыми данными:

    ```json
    {
        "device_id": "iv9a94th6rztooxh5ur2",
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
        "device_id": "rhibbh3y08qmz3sdbrbu",
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
        "device_id": "iv9a94th6rztooxh5ur2",
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
    --url=amqp://<имя пользователя RabbitMQ>:<пароль>@<IP-адрес или FQDN сервера RabbitMQ>:5672 \
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

{% list tabs %}

- Вручную

    Если созданные ресурсы вам больше не нужны, удалите их:

    * [Удалите кластер {{ mch-full-name }}](../../managed-clickhouse/operations/cluster-delete.md).
    * {% if audience != "internal" %}[Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md){% else %}Удалите виртуальную машину{% endif %}.
    * Если вы зарезервировали публичные статические IP-адреса, освободите и {% if audience != "internal" %}[удалите их](../../vpc/operations/address-delete.md){% else %}удалите их{% endif %}.

- С помощью {{ TF }}

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
