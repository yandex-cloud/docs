---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Getting data from {{ RMQ }}

A {{ mch-name }} cluster can get data from {{ RMQ }} in real time. {{ mch-name }} will automatically insert the data sent to certain exchanges of the specified {{ RMQ }} queues into the table run on the [{{ RMQ }} engine](https://clickhouse.tech/docs/en/engines/table-engines/integrations/rabbitmq/).

To set up data delivery from {{ RMQ }} to {{ mch-name }}:

1. [Set up integration with {{ RMQ }} for a {{ mch-name}} cluster](#configure-mch-for-rmq).
1. [Review the format of data received from {{ RMQ }}](#explore-rmq-data-format).
1. [In the {{ mch-name }} cluster, create a table on the {{ RMQ }} engine](#create-rmq-table).
1. [Send the test data to the {{ RMQ }} queue](#send-sample-data-to-rmq).
1. [Check that the test data is present in the {{ mch-name }} cluster table](#fetch-sample-data).

## Before you start {#before-you-begin}

1. [Create a {{ mch-name }} cluster](../operations/cluster-create.md) in any suitable configuration with the `db1` database and public access to all of its hosts.

    {% note info %}

    You can set up {{ RMQ }} integration when [creating a cluster](../operations/cluster-create.md). In this use case, integration will be configured [later](#configure-mch-for-rmq).

    {% endnote %}

1. Install the `amqp-publish` and `amqp-declare-queue` utilities to work with {{ RMQ }}. Check if you can create a queue named `cars` in {{ RMQ }} using `amqp-declare-queue`:

    ```bash
    amqp-declare-queue \
        --url=amqp://<RabbitMQ username>:<password>@<FQDN of the RabbitMQ host>:5672 \
        --queue=cars
    ```

1. Install the `clickhouse-client` utility and check that you can use it to [connect to the {{ CH }} cluster over SSL](../operations/connect#connection-string).

1. Install the [jq](https://stedolan.github.io/jq/) utility for piped processing of JSON files.

## Set up integration with {{ RMQ }} for the {{ mch-name }} cluster {#configure-mch-for-rmq}

[In the {{ mch-name }} cluster settings](../operations/update.md#change-clickhouse-config), specify the username and password for authentification in {{ RMQ }} (**DBMS settings → Rabbitmq**).

## Review the format of the data coming from {{ RMQ }} {#explore-rmq-data-format}

To process the data received from {{ RMQ }}, you need to know the message data format and properly configure the {{ RMQ }} engine when [creating a table](#create-rmq-table) in the {{ mch-name }} cluster.

As an example, let's input the JSON data from the car sensors to the `cars` queue at an `exchange` in {{ RMQ }}:

* String ID of the device, `device_id`.
* Date and time when the data was generated, `datetime`, in the format `YYYY-MM-DD HH:MM:SS`.
* Car coordinates:
    * `latitude`: Latitude.
    * `longitude`: Longitude.
    * `altitude`: Altitude above the sea level.
* `speed`: Current speed.
* `battery_voltage`: Battery voltage (used for electric cars. For cars with internal combustion engine, this parameter is `null`).
* `cabin_temperature`: Temperature in the cabin.
* `fuel_level`: Fuel level (used for cars with internal combustion engine; for electric cars, this parameter is `null`).

This data will be transmitted as {{ RMQ }} messages. Each such message will contain a JSON object as the following string:

```json
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

When inserting data in the table, the {{ mch-name }} cluster will use the [JSONEachRow format](https://clickhouse.tech/docs/en/interfaces/formats/#jsoneachrow). It helps to convert a string representation of a JSON object used in {{ RMQ }} messages to the needed set of column values.

## In the {{ mch-name }} cluster, create a table on the {{ RMQ }} engine {#create-rmq-table}

Using the above-mentioned data format, create in the {{ mch-name }} cluster a table to accept data received from {{ RMQ }}:

1. [Connect](../operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.

1. Run the query:

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
      rabbitmq_host_port = '<IP address or FQDN of the RabbitMQ server>:5672',
      rabbitmq_routing_key_list = 'cars',
      rabbitmq_exchange_name = 'exchange',
      rabbitmq_format = 'JSONEachRow';
    ```

This table will be automatically filled with messages read from the `cars` queue at the `exchange` of {{ RMQ }}. When reading the data, {{ mch-name }} uses the [provided authentication credentials](#configure-mch-for-rmq).

To learn more about creating a table on the {{ RMQ }} engine, see the [{{ CH }} documentation](https://clickhouse.tech/docs/en/engines/table-engines/integrations/rabbitmq/).

## Send the test data to the {{ RMQ }} queue {#send-sample-data-to-rmq}

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

1. Send the data from the `sample.json` file to the previously created `cars` queue of the `exchange` using `jq` and `amqp-publish`.

    ```bash
    jq --raw-output --compact-output . ./sample.json | amqp-publish \
        --url=amqp://<RabbitMQ username>:<password>@<FQDN of the RabbitMQ host>:5672 \
        --routing-key=cars \
        --exchange=exchange
    ```

## Check that the test data is present in the {{ mch-name }} cluster table{#fetch-sample-data}

Create a `MATERIALIZED VIEW` and use it to access data. When a materialized view is added to a table on the {{ RMQ }} engine, it starts collecting data in the background. This lets you continuously receive messages from {{ RMQ }} and convert them to the required format using `SELECT`.

{% note info %}

Although you can read data directly from the `db1.cars` table, we don't recommend this, because every message from the queue can be read by {{ CH }} only once.

{% endnote %}

To create a materialized view for the `db1.cars` table:

1. [Connect](../operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.

1. Run the following queries:

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

To get all the data from the `db1.cars_view` materialized view:

1. [Connect](../operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.

1. Run the query:

    ```sql
    SELECT * FROM db1.cars_view;
    ```

After you execute the query, you should get the {{ RMQ }} data in the table format.

To learn more about how to work with data received from {{ RMQ }}, see the [{{ CH }} documentation](https://clickhouse.tech/docs/en/engines/table-engines/integrations/rabbitmq/).

