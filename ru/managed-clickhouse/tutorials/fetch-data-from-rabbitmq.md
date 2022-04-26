# Получение данных из {{ RMQ }}

В кластер {{ mch-name }} можно поставлять данные из {{ RMQ }} в реальном времени. {{ mch-name }} будет автоматически вставлять в таблицу на [движке {{ RMQ }}](https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/rabbitmq/) данные, поступающие на определенные точки обмена указанных очередей {{ RMQ }}.

Чтобы настроить поставку данных из {{ RMQ }} в {{ mch-name }}:

1. [Настройте интеграцию с {{ RMQ }} для кластера {{ mch-name}}](#configure-mch-for-rmq).
1. [Изучите формат данных, поступающих от {{ RMQ }}](#explore-rmq-data-format).
1. [Создайте в кластере {{ mch-name }} таблицу на движке {{ RMQ }}](#create-rmq-table).
1. [Отправьте тестовые данные в очередь {{ RMQ }}](#send-sample-data-to-rmq).
1. [Проверьте наличие тестовых данных в таблице кластера {{ mch-name }}](#fetch-sample-data).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mch-name }}](../operations/cluster-create.md) любой подходящей вам конфигурации с базой данных `db1` и публичным доступом ко всем его хостам.

    {% note info %}

    Интеграцию с {{ RMQ }} можно настроить уже на этапе [создания кластера](../operations/cluster-create.md). В этой статье интеграция будет настроена [позже](#configure-mch-for-rmq).

    {% endnote %}

1. Установите утилиты `amqp-publish` и `amqp-declare-queue` для работы с {{ RMQ }}. Убедитесь, что можете создать в {{ RMQ }} очередь `cars` с помощью `amqp-declare-queue`:

    ```bash
    amqp-declare-queue \
        --url=amqp://<имя пользователя RabbitMQ>:<пароль>@<FQDN хоста RabbitMQ>:5672 \
        --queue=cars
    ```

1. Установите утилиту `clickhouse-client` и убедитесь, что можете с ее помощью [подключиться к кластеру {{ CH }} через SSL](../operations/connect#connection-string).

1. Установите утилиту для потоковой обработки JSON-файлов [jq](https://stedolan.github.io/jq/).

## Настройте интеграцию {{ RMQ }} для кластера {{ mch-name }} {#configure-mch-for-rmq}

[Укажите в настройках кластера {{ mch-name }}](../operations/update.md#change-clickhouse-config) имя пользователя и пароль для аутентификации в {{ RMQ }} (секция **Настройки СУБД → Rabbitmq**).

## Изучите формат данных, поступающих от {{ RMQ }} {#explore-rmq-data-format}

Чтобы обработать данные, поступающие от {{ RMQ }}, нужно понимать, каким образом они представлены в сообщениях, и соответствующим образом настроить движок {{ RMQ }} при [создании таблицы](#create-rmq-table) в кластере {{ mch-name }}.

В качестве примера в очередь `cars` на точке обмена `exchange` в {{ RMQ }} будут помещены данные от сенсоров автомобиля в формате JSON:

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

Кластер {{ mch-name }} будет использовать при вставке в таблицу [формат данных JSONEachRow](https://{{ ch-domain }}/docs/ru/interfaces/formats/#jsoneachrow), который позволяет преобразовать строковое представление JSON-объекта из сообщения {{ RMQ }} в нужный набор значений столбцов.

## Создайте в кластере {{ mch-name }} таблицу на движке {{ RMQ }} {#create-rmq-table}

Исходя из формата данных, приведенного выше, создайте в кластере {{ mch-name }} таблицу, в которую будут заноситься поступающие от {{ RMQ }} данные:

1. [Подключитесь](../operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.

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
      rabbitmq_host_port = '<IP-адрес или FQDN сервера RabbitMQ>:5672',
      rabbitmq_routing_key_list = 'cars',
      rabbitmq_exchange_name = 'exchange',
      rabbitmq_format = 'JSONEachRow';
    ```

Эта таблица будет автоматически наполняться сообщениями, считываемыми из очереди `cars` в точке обмена `exchange` {{ RMQ }}. При чтении данных {{ mch-name }} использует [указанные ранее данные](#configure-mch-for-rmq) для аутентификации.

## Отправьте тестовые данные в очередь {{ RMQ }} {#send-sample-data-to-rmq}

1. Создайте файл `sample.json` со следующими тестовыми данными:

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
    jq --raw-output --compact-output . ./sample.json | amqp-publish \
        --url=amqp://<имя пользователя RabbitMQ>:<пароль>@<FQDN хоста RabbitMQ>:5672 \
        --routing-key=cars \
        --exchange=exchange
    ```

## Проверьте наличие тестовых данных в таблице кластера {{ mch-name }} {#fetch-sample-data}

Создайте материализованное представление (`MATERIALIZED VIEW`) и используйте его для доступа к данным. Когда к таблице на движке {{ RMQ }} присоединяется материализованное представление, оно начинает в фоновом режиме собирать данные. Это позволяет непрерывно получать сообщения от {{ RMQ }} и преобразовывать их в необходимый формат с помощью `SELECT`.

{% note info %}

Хотя можно напрямую считать данные из таблицы `db1.cars`, это не рекомендуется, т. к. каждое сообщение из очереди может быть прочитано {{ CH }} только один раз.

{% endnote %}

Чтобы создать материализованное представление для таблицы `db1.cars`:

1. [Подключитесь](../operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.

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

1. [Подключитесь](../operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.

1. Выполните запрос:

    ```sql
    SELECT * FROM db1.cars_view;
    ```

После выполнения запроса вы должны получить отправленные в {{ RMQ }} данные в табличном виде.

Подробнее о работе с данными, поставляемыми из {{ RMQ }}, см. [в документации {{ CH }}](https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/rabbitmq/).
