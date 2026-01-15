# Delivering data from {{ mmy-full-name }} to {{ mkf-full-name }} using {{ data-transfer-full-name }}

You can track data changes in a {{ mmy-name }} _source cluster_ and send them to a {{ mkf-name }} _target cluster_ using [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Set up the source cluster](#prepare-source).
1. [Set up the target cluster](#prepare-target).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mmy-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* {{ mkf-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) with any suitable configuration, using the following settings:

    * Database: `db1`
    * User: `my-user`
    * Hosts: Publicly available

1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) using any suitable configuration with publicly accessible hosts.


1. If using security groups, configure them to allow internet access to your clusters:

    * [Guide for {{ mmy-name }}](../../managed-mysql/operations/connect.md#configuring-security-groups)
    * [Guide for {{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups)


1. Install [`kcat`](https://github.com/edenhill/kcat) (formerly known as `kafkacat`) and the [MySQL command-line tool](https://www.mysql.com/downloads/) on your local machine. For example, if your computer is running Ubuntu 20.04, use this command:

    ```bash
    sudo apt update && sudo apt install kafkacat mysql-client --yes
    ```

    Check that can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Set up the source cluster {#prepare-source}

1. For {{ data-transfer-name }} to get notifications of data changes from a {{ mmy-name }} cluster, configure external replication in the source cluster. To enable `my-user` to perform replication, [assign](../../managed-mysql/operations/grant.md) the `ALL_PRIVILEGES` role for the `db1` database and [grant](../../managed-mysql/operations/cluster-users.md#update-settings) the `REPLICATION CLIENT` and `REPLICATION SLAVE` global privileges to the user.

1. [Connect](../../managed-mysql/operations/connect.md) to the `db1` database as `my-user`.

1. Populate the database with test data. In this example, we will use a simple table with car sensor information.

    Create a table:

    ```sql
    CREATE TABLE db1.measurements (
        device_id varchar(200) NOT NULL,
        datetime timestamp NOT NULL,
        latitude real NOT NULL,
        longitude real NOT NULL,
        altitude real NOT NULL,
        speed real NOT NULL,
        battery_voltage real,
        cabin_temperature real NOT NULL,
        fuel_level real,
        PRIMARY KEY (device_id)
    );
    ```

    Populate the table with data:

    ```sql
    INSERT INTO db1.measurements VALUES
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Set up the target cluster {#prepare-target}

The settings vary depending on the [topic management method](../../managed-kafka/concepts/topics.md#management) used. Data topic names follow the `<topic_prefix>.<schema_name>.<table_name>` convention. In this tutorial, we will use the `cdc` prefix.

{% list tabs group=topic_management %}

- {{ yandex-cloud }} interfaces {#yc}

    When managing topics using native {{ yandex-cloud }} interfaces (management console, CLI, {{ TF }}, or API):

    1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `cdc.db1.measurements`.

        To track changes in multiple tables, create a separate topic for each one.

    1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `kafka-user` with `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for the new topics. To include all such topics, use `cdc.*` as the topic name.

- Admin API {#api}

    When managing topics via the Kafka Admin API:

    1. Create an [admin user](../../managed-kafka/operations/cluster-accounts.md) named `kafka-user`.

    1. In addition to `ACCESS_ROLE_ADMIN`, assign this user the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for all topics prefixed with `cdc`.

        Required topics will be created automatically upon the first change to the source cluster tables you are tracking. While this approach can be convenient for tracking changes across multiple tables, it requires reserving free storage space in your cluster. For more information, see [{#T}](../../managed-kafka/concepts/storage.md).

{% endlist %}

## Set up and activate the transfer {#prepare-transfer}

1. [Create](../../data-transfer/operations/endpoint/index.md#create) a {{ MY }} source endpoint with the following [settings](../../data-transfer/operations/endpoint/source/mysql.md):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}**: Select the {{ mmy-name }} cluster you [created](#before-you-begin) earlier.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: `my-user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: Enter the `my-user` password.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}**: `db1.measurements`.

1. [Create](../../data-transfer/operations/endpoint/index.md#create) an {{ KF }} target endpoint with the following [settings](../../data-transfer/operations/endpoint/source/kafka.md):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the {{ mkf-name }} cluster you [created](#before-you-begin) earlier.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Specify the `kafka-user` credentials.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: `cdc.db1.measurements`.

        If you need to track changes in multiple tables, fill out the fields as follows:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Enter the `cdc` prefix you used to generate topic names.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the previously created source and target endpoints.
1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

## Test your transfer {#verify-transfer}

1. In a separate terminal, run `kafkacat` in consumer mode:

    ```bash
    kafkacat \
        -C \
        -b <broker_host_1_FQDN>:9091,...,<broker_host_N_FQDN>:9091 \
        -t cdc.db1.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<password> \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
        -Z \
        -K:
    ```

    You can get the FQDNs of broker hosts with the [list of hosts in the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-hosts.md).

1. Connect to the source cluster and populate the `measurements` table with data:

    ```sql
    INSERT INTO db1.measurements VALUES
        ('iv7b74th678t********', '2022-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL),
        ('iv9a94th678t********', '2022-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

1. Make sure the terminal running `kafkacat` displays the data format schema of the `db1.measurements` table and information about the added rows.

    {% cut "Message snippet example" %}

    ```json
    {
        "payload": {
            "device_id": "iv7b74th678t********"
        },
        "schema": {
            "fields": [
                {
                    "field": "device_id",
                    "optional": false,
                    "type": "string"
                }
            ],
            "name": "cdc.db1.measurements.Key",
            "optional": false,
            "type": "struct"
        }
    }: {
        "payload": {
            "after": {
                "altitude": 378,
                "battery_voltage": 5.3,
                "cabin_temperature": 20,
                "datetime": "2020-06-08T17:45:00Z",
                "device_id": "iv7b74th678t********",
                "fuel_level": null,
                "latitude": 53.70987913,
                "longitude": 36.62549834,
                "speed": 20.5
            },
            "before": null,
            "op": "c",
            "source": {
                "connector": "mysql",
                "db": "db1",
                "file": "mysql-log.000016",
                "gtid": "1e46a80b-2e96-11ed-adf7-d00d183780**:*-*****",
                "name": "cdc",
                "pos": 1547357,
                "query": null,
                "row": 0,
                "server_id": 0,
                "snapshot": "false",
                "table": "measurements",
                "thread": null,
                "ts_ms": 1662632515000,
                "version": "1.1.2.Final"
            },
            "transaction": null,
            "ts_ms": 1662632515000
        },
        "schema": {
            "fields": [
                {
                    "field": "before",
                    "fields": [
                        {
                            "field": "device_id",
                            "optional": false,
                            "type": "string"
                        },
                        ...
                    ],
                    "name": "cdc.db1.measurements.Value",
                    "optional": true,
                    "type": "struct"
                },
                {
                    "field": "after",
                    "fields": [
                        ...
                    ],
                    "name": "cdc.db1.measurements.Value",
                    "optional": true,
                    "type": "struct"
                },
                {
                    "field": "source",
                    "fields": [
                        {
                            "field": "version",
                            "optional": false,
                            "type": "string"
                        },
                        ...
                    ],
                    "name": "io.debezium.connector.mysql.Source",
                    "optional": false,
                    "type": "struct"
                },
                {
                    "field": "op",
                    "optional": false,
                    "type": "string"
                },
                ...
            ],
            "name": "cdc.db1.measurements.Envelope",
            "optional": false,
            "type": "struct"
        }
    }
    ```

    {% endcut %}

### Features of transferring data with {{ data-transfer-name }} {#features}

* When transferring data from {{ MY }} to {{ KF }}, certain data types undergo conversion:

  * `tinyint(1)` becomes `boolean`.
  * `real` becomes `double`.
  * `bigint unsigned` becomes `int64`.

* In the `payload.source` metadata section, `server_id` and `thread` remain blank.

## Delete the resources you created {#clear-out}

To reduce the consumption of resources you do not need, delete them:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) and [delete](../../data-transfer/operations/transfer.md#delete) the transfer.

1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).

1. Delete the clusters:

    * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md)
    * [{{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md)

1. If you used static public IP addresses to access the cluster hosts, release and [delete](../../vpc/operations/address-delete.md) them.
