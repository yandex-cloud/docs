В кластер {{ mch-name }} можно поставлять данные из кластера {{ mkf-name }} в реальном времени. {{ mch-name }} будет автоматически вставлять в таблицу на [движке {{ KF }}](https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/) данные, поступающие в определенные топики {{ KF }}.

Чтобы настроить поставку данных из {{ mkf-name }} в {{ mch-name }}:
1. [Настройте интеграцию с {{ KF }} для кластера {{ mch-name }}](#configure-mch-for-kf).
1. [Изучите формат данных, поступающих от {{ mkf-name }}](#explore-kf-data-format).
1. [Создайте в кластере {{ mch-name }} таблицу на движке {{ KF }}](#create-kf-table).
1. [Отправьте тестовые данные в кластер {{ mkf-name }}](#send-sample-data-to-kf).
1. [Проверьте наличие тестовых данных в таблице кластера {{ mch-name }}](#fetch-sample-data).


## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей вам конфигурации.
1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей вам конфигурации с базой данных `db1`.

   {% note info %}

   Интеграцию с {{ KF }} можно настроить уже на этапе [создания кластера](../../managed-clickhouse/operations/cluster-create.md). В этом практическом руководстве интеграция будет настроена [позже](#configure-mch-for-kf).

   {% endnote %}

1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) `datastore` в кластере {{ mkf-name }}.

1. [Создайте учетные записи](../../managed-kafka/operations/cluster-accounts.md#create-account) в кластере {{ mkf-name }}  для работы с топиком `datastore`:
   - учетную запись производителя `writer`;
   - учетную запись потребителя `reader`.

1. Установите утилиту `kafkacat` и убедитесь, что можете с ее помощью [подключиться к кластеру {{ mkf-name }} через SSL](../../managed-kafka/operations/connect.md#connection-string).

1. Установите утилиту `clickhouse-client` и убедитесь, что можете с ее помощью [подключиться к кластеру {{ mch-name }} через SSL](../../managed-clickhouse/operations/connect.md#connection-string).

1. Установите утилиту для потоковой обработки JSON-файлов [jq](https://stedolan.github.io/jq/).


## Настройте интеграцию с {{ KF }} для кластера {{ mch-name }} {#configure-mch-for-kf}

[Укажите в настройках кластера {{ mch-name }}](../../managed-clickhouse/operations/update.md#change-clickhouse-config) данные для аутентификации в кластере {{ mkf-name }} (секция **Настройки СУБД → Kafka**):
1. **Sasl mechanism** — `SCRAM-SHA-512`.
1. **Sasl password** — пароль [учетной записи потребителя](#before-you-begin) `reader`.
1. **Sasl username** — имя [учетной записи потребителя](#before-you-begin) (в этой пошаговой инструкции — `reader`).
1. **Security protocol** — `SASL_SSL`.

Кластер {{ mch-name }} будет использовать эти данные для аутентификации при обращении к любому топику {{ KF }}.


## Изучите формат данных, поступающих от {{ mkf-name }} {#explore-kf-data-format}

Чтобы обработать данные, поступающие от {{ mkf-name }}, нужно понимать, каким образом они представлены в сообщении {{ KF }}, и соответствующим образом настроить движок {{ KF }} при [создании таблицы](#create-kf-table) в кластере {{ mch-name }}.

В качестве примера в топик {{ KF }} `datastore` будут помещены данные от сенсоров автомобиля в формате JSON:
- строковый идентификатор устройства `device_id`;
- дата и время формирования данных `datetime` в формате `YYYY-MM-DD HH:MM:SS`;
- координаты автомобиля:
  - широта `latitude`;
  - долгота `longitude`;
  - высота над уровнем моря `altitude`;
- текущая скорость `speed`;
- напряжение батарей `battery_voltage` (для электромобиля, для автомобиля с ДВС значение этого параметра — `null`);
- температура в салоне `cabin_temperature`;
- уровень топлива `fuel_level` (для автомобиля с ДВС, для электромобиля значение этого параметра — `null`).

Эти данные будут передаваться в виде сообщений {{ KF }}. Каждое такое сообщение будет содержать JSON-объект как строку следующего вида:

```json
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

Кластер {{ mch-name }} будет использовать при вставке в таблицу [формат данных JSONEachRow](https://clickhouse.tech/docs/ru/interfaces/formats/#jsoneachrow), который позволяет преобразовать строковое представление JSON-объекта из сообщения {{ KF }} в нужный набор значений столбцов.


## Создайте в кластере {{ mch-name }} таблицу на движке {{ KF }} {#create-kf-table}

Исходя из формата данных, приведенного выше, создайте в кластере {{ mch-name }} таблицу, в которую будут заноситься поступающие от {{ mkf-name }} данные:
1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.
1. Выполните запрос:

   ```sql
   CREATE TABLE IF NOT EXISTS db1.kafka
   (
     device_id String,
     datetime DateTime,
     latitude Float32,
     longitude Float32,
     altitude Float32,
     speed Float32,
     battery_voltage Nullable(Float32),
     cabin_temperature Float32,
     fuel_level Nullable(Float32)
   ) ENGINE = Kafka()
   SETTINGS
       kafka_broker_list = '<FQDN хоста-брокера Kafka>:9091',
       kafka_topic_list = 'datastore',
       kafka_group_name = 'sample_group',
       kafka_format = 'JSONEachRow';
   ```

Эта таблица будет автоматически наполняться сообщениями, считываемыми из топика `datastore` кластера {{ mkf-name }}. При чтении данных {{ mch-name }} использует [указанные ранее настройки](#configure-mch-for-kf) для [учетной записи потребителя `reader`](#before-you-begin).

Подробнее о создании таблицы на движке {{ KF }} см. в [документации {{ CH }}](https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/).


## Отправьте тестовые данные в кластер {{ mkf-name }} {#send-sample-data-to-kf}

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

1. Отправьте данные из файла `sample.json` в топик `datastore` кластера {{ mkf-name }} с помощью `jq`  и `kafkacat`:

   ```bash
   jq -rc . sample.json | kafkacat kafkacat -P  \
      -b rc1a-gjnru23feni92o5a.{{ dns-zone }}:9091 \
      -t datastore \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username=writer \
      -X sasl.password="<пароль производителя>" \
      -X ssl.ca.location=<путь к корневому сертификату Yandex> -Z
   ```

Данные отправляются с помощью [учетной записи производителя `writer`](#before-you-begin). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../../managed-kafka/operations/connect.md).


## Проверьте наличие тестовых данных в таблице кластера {{ mch-name }} {#fetch-sample-data}

Хотя можно напрямую считать данные из таблицы `db1.kafka`, это не рекомендуется, т.к. каждое сообщение из топика может быть прочитано {{ CH }} только один раз.

Практичнее создать материализованное представление (`MATERIALIZED VIEW`) и использовать его для доступа к данным. Когда к таблице на движке {{ KF }} присоединяется материализованное представление, оно начинает в фоновом режиме собирать данные. Это позволяет непрерывно получать сообщения от {{ KF }} и преобразовывать их в необходимый формат с помощью `SELECT`.

Чтобы создать такое представление для таблицы `db1.kafka`:
1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.
1. Выполните запросы:

   ```sql
   CREATE TABLE db1.kafka_data_source
   (
     device_id String,
     datetime DateTime,
     latitude Float32,
     longitude Float32,
     altitude Float32,
     speed Float32,
     battery_voltage Nullable(Float32),
     cabin_temperature Float32,
     fuel_level Nullable(Float32)
   ) ENGINE = MergeTree()
   ORDER BY device_id;

   CREATE MATERIALIZED VIEW db1.data_view TO db1.kafka_data_source
       AS SELECT * FROM db1.kafka;
   ```

Чтобы получить все данные из материализованного представления `db1.data_view`:
1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.
1. Выполните запрос:

   ```sql
   SELECT * FROM db1.data_view;
   ```

После выполнения запроса вы должны получить отправленные в {{ mkf-name }} данные в табличном виде.

Подробнее о работе с данными, поставляемыми из {{ KF }}, см. [в документации {{ CH }}](https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/).
