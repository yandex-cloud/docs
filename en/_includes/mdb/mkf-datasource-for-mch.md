A {{ mch-name }} cluster can get data from a {{ mkf-name }} cluster in real time. {{ mch-name }} will automatically insert the data sent to certain {{ KF }} topics into the table run on the [{{ KF }} engine](https://clickhouse.tech/docs/en/engines/table-engines/integrations/kafka/).

To set up data delivery from {{ mkf-name }} to {{ mch-name }}:

1. [Set up integration with {{ KF }} for a {{ mch-name }} cluster](#configure-mch-for-kf).
1. [Review the format of data received from {{ mkf-name }}](#explore-kf-data-format).
1. [In the {{ mch-name }} cluster, create a table on the {{ KF }} engine](#create-kf-table).
1. [Send the test data to the {{ mkf-name }} cluster](#send-sample-data-to-kf).
1. [Check that the test data is present in the {{ mch-name }} cluster table](#fetch-sample-data).

## Before you start {#before-you-begin}

1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration.

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) in any suitable configuration and with the `db1` database.

   {% note info %}

   You can set up {{ KF }} integration when [creating a cluster](../../managed-clickhouse/operations/cluster-create.md). In this use case, integration will be configured [later](#configure-mch-for-kf).

   {% endnote %}

1. [Create the topic](../../managed-kafka/operations/cluster-topics.md#create-topic) `datastore` in the {{ mkf-name }} cluster.

1. [Create accounts](../../managed-kafka/operations/cluster-accounts.md#create-account) in the {{ mkf-name }} cluster to access the `datastore` topic:
   - Producer account: `writer`.
   - Consumer account: `reader`.

1. Install the `kafkacat` utility and check that you can use it to [connect to the {{ mkf-name }} cluster over SSL](../../managed-kafka/operations/connect.md#connection-string).

1. Install the `clickhouse-client` utility and check that you can use it to [connect to the {{ mch-name }} cluster over SSL](../../managed-clickhouse/operations/connect.md#connection-string).

1. Install the [jq](https://stedolan.github.io/jq/) utility for piped processing of JSON files.

## Set up integration with {{ KF }} for the {{ mch-name }} cluster {#configure-mch-for-kf}

[Enter in the {{ mch-name }} cluster settings](../../managed-clickhouse/operations/update.md#change-clickhouse-config) the authentication credentials for the {{ mkf-name }} cluster (**DBMS settings → Kafka** section):

1. **Sasl mechanism**: `SCRAM-SHA-512`.
1. **Sasl password**: Password of the [consumer account](#before-you-begin) `reader`.
1. **Sasl username**: Name of the [consumer account](#before-you-begin) (`reader` in this tutorial).
1. **Security protocol**: `SASL_SSL`.

The {{ mch-name }} cluster will use these authentication credentials to access any {{ KF }} topic.

## Review the format of the data coming from {{ mkf-name }} {#explore-kf-data-format}

To process the data received from {{ mkf-name }}, you need to know the data format in the message from {{ KF }} and properly configure the {{ KF }} engine when [creating a table](#create-kf-table) in the {{ mch-name }} cluster.

As an example, let's input the JSON data from the car sensors to the {{ KF }} `datastore` topic:

- String ID of the device, `device_id`.
- Date and time when the data was generated, `datetime`, in the format `YYYY-MM-DD HH:MM:SS`.
- Car coordinates:
  - `latitude`: Latitude.
  - `longitude`: Longitude.
  - `altitude`: Altitude above the sea level.
- `speed`: Current speed.
- `battery_voltage`: Battery voltage (used for electric cars. For cars with internal combustion engine, this parameter is `null`).
- `cabin_temperature`: Temperature inside the car.
- `fuel_level`: Fuel level (used for cars with internal combustion engine. For electric cars, this parameter is `null`).

This data will be transmitted as {{ KF }} messages. Each message will contain a JSON object as the following string:

```json
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

When inserting data in the table, the {{ mch-name }} cluster will use [JSONEachRow format](https://clickhouse.tech/docs/en/interfaces/formats/#jsoneachrow). It helps to convert a string representation of a JSON object used in {{ KF }} messages to the required set of column values.

## In the {{ mch-name }} cluster, create a table on the {{ KF }} engine {#create-kf-table}

Using the above-mentioned data format, create a table to accept data received from {{ mkf-name }} in the {{ mch-name }} cluster:

1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.

1. Run the query:

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
       kafka_broker_list = '<FQDN of the Kafka broker host>:9091',
       kafka_topic_list = 'datastore',
       kafka_group_name = 'sample_group',
       kafka_format = 'JSONEachRow';
   ```

This table will be automatically filled with messages read from the `datastore` topic of the {{ mkf-name }} cluster. When reading the data, {{ mch-name }} uses the [existing settings](#configure-mch-for-kf) for the [`reader` consumer account](#before-you-begin).

To learn more about creating a table on the {{ KF }} engine, see the [{{ CH }} documentation]{% if lang == "ru" %}(https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/){% endif %}{% if lang == "en" %}(https://clickhouse.tech/docs/en/engines/table-engines/integrations/kafka/){% endif %}.

## Send the test data to the {{ mkf-name }} cluster {#send-sample-data-to-kf}

1. Create a `sample.json` file with the following test data:

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

1. Send the data from the `sample.json` file to the `datastore` topic of the {{ mkf-name }} cluster using `jq` and `kafkacat`:

   ```bash
   jq -rc . sample.json | kafkacat kafkacat -P \
      -b rc1a-gjnru23feni92o5a.mdb.yandexcloud.net:9091 \
      -t datastore \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username=writer \
      -X sasl.password="<producer password>" \
      -X ssl.ca.location=<path to the Yandex root certificate> -Z
   ```

The data is sent using the [producer's `writer` account](#before-you-begin). To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../../managed-kafka/operations/connect.md).

## Check that the test data is present in the {{ mch-name }} cluster table {#fetch-sample-data}

Although you can read data directly from the `db1.kafka` table, we don't recommend this, because every message from the topic can be read by {{ CH }} only once.

It's more practical to create a `MATERIALIZED VIEW` and use it to access data. When a materialized view is added to a table on the {{ KF }} engine, it starts collecting data in the background. This lets you continuously receive messages from {{ KF }} and convert them to the required format using `SELECT`.

To create a materialized view for the `db1.kafka` table:

1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.

1. Run the following queries:

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

To get all the data from the `db1.data_view` materialized view:

1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.

1. Run the query:

   ```sql
   SELECT * FROM db1.data_view;
   ```

After you execute the query, you should get the {{ mkf-name }} data in the table format.

To learn more about how to work with data received from {{ KF }}, see the [{{ CH }} documentation]{% if lang == "ru" %}(https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/){% endif %}{% if lang == "en" %}(https://clickhouse.tech/docs/en/engines/table-engines/integrations/kafka/){% endif %}.
