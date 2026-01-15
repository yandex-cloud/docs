# Delivering data from {{ mpg-full-name }} to {{ mkf-full-name }} using {{ data-transfer-full-name }}

You can track data changes in a {{ mpg-name }} _source cluster_ and send them to a {{ mkf-name }} _target cluster_ using Change Data Capture (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Set up the source cluster](#prepare-source).
1. [Set up the target cluster](#prepare-target).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mpg-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* {{ mkf-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

1. [Create a {{ mpg-name }} source cluster](../../managed-postgresql/operations/cluster-create.md) with any suitable configuration, using the following settings:

    * Database: `db1`
    * User: `pg-user`
    * Hosts: Publicly available

1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) using any suitable configuration with publicly accessible hosts.


1. If using security groups, configure them to allow internet access to your clusters:

    * [Guide for {{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups)
    * [Guide for {{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups)


1. Install the `kcat` (`kafkacat`) [utility](https://github.com/edenhill/kcat) and the [PostgreSQL command-line client](https://www.postgresql.org/download/) on your local machine. For example, on Ubuntu 20.04, use this command:

    ```bash
    sudo apt update && sudo apt install kafkacat postgresql-client --yes
    ```

    Check that can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Set up the source cluster {#prepare-source}

1. For {{ data-transfer-name }} to receive data change notifications from a {{ mpg-name }} cluster, you must create a publication on the source cluster. [Assign](../../managed-postgresql/operations/grant.md) `pg-user` the `mdb_replication` role to allow publication creation.

1. [Connect](../../managed-postgresql/operations/connect.md) to the `db1` database as `pg-user`.

1. Populate the database with test data. In this example, we will use a simple table with car sensor information.

    Create a table:

    ```sql
    CREATE TABLE public.measurements (
        "device_id" text PRIMARY KEY NOT NULL,
        "datetime" timestamp NOT NULL,
        "latitude" real NOT NULL,
        "longitude" real NOT NULL,
        "altitude" real NOT NULL,
        "speed" real NOT NULL,
        "battery_voltage" real,
        "cabin_temperature" real NOT NULL,
        "fuel_level" real
    );
    ```

    Populate the table with data:

    ```sql
    INSERT INTO public.measurements VALUES
        ('iv9a94th6rzt********', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th678t********', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

## Set up the target cluster {#prepare-target}

The configuration may vary depending on the chosen [topic management method](../../managed-kafka/concepts/topics.md#management). Topic names follow the same convention as [Debezium](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names): `<topic_prefix>.<schema_name>.<table_name>`. In this tutorial, we will use the `cdc` example prefix.

{% list tabs group=topic_management %}

- {{ yandex-cloud }} interfaces {#yc}

    When topic management is handled via native {{ yandex-cloud }} interfaces, i.e., management console, CLI, {{ TF }}, or API:

    1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `cdc.public.measurements`.

        If you need to track data changes in multiple tables, create a separate topic for each one.

    1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `kafka-user` with `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles applying to the created topics.

- Admin API {#api}

    When managing topics via the Kafka Admin API:

    1. Create an [admin user](../../managed-kafka/operations/cluster-accounts.md) named `kafka-user`.

    1. In addition to the `ACCESS_ROLE_ADMIN` role, assign the admin user the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for topics whose names begin with the `cdc` prefix.

        The system will automatically create the required topics when the first change occurs in the monitored tables of the source cluster. While this approach can be convenient for tracking changes across multiple tables, it requires reserving free storage space in your cluster. For more information, see [{#T}](../../managed-kafka/concepts/storage.md).

{% endlist %}


## Set up and activate the transfer {#prepare-transfer}

1. [Create endpoints](../../data-transfer/operations/endpoint/index.md#create).

    * Source endpoint:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}**:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: Your previously [created](#before-you-begin) {{ mpg-name }} cluster.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `pg-user` password.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}**: `public.measurements`.

    * Target endpoint:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the target cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Specify the `kafka-user` credentials.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}**: `cdc.public.measurements`.

            If you need to track changes in multiple tables, fill in the fields as follows:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Specify the `cdc` prefix you used to generate topic names.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with the following settings:

    * **{{ ui-key.yacloud.data-transfer.label_endpoints }}**:
        * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}**: Source endpoint you created earlier.
        * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**: Target endpoint you created earlier.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**.

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

## Test your transfer {#verify-transfer}

1. In a separate terminal, run `kafkacat` in consumer mode:

    ```bash
    kafkacat \
        -C \
        -b <broker_host_1_FQDN>:9091,...,<broker_host_N_FQDN>:9091 \
        -t cdc.public.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<password> \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
        -Z \
        -K:
    ```

    You can get the FQDNs of broker hosts with the [list of hosts in the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-hosts.md).

    The utility will print the `public.measurements` table schema along with the data from previously inserted rows.

    {% cut "Message snippet example" %}

    ```json
    {
      "payload": {
        "consumer":"dttuhfpp97l3********"
      },
      "schema": {
        "fields": [
          {
            "field": "consumer",
            "optional":false,
            "type":"string"
          }
        ],
        "name": "__data_transfer_stub.public.__consumer_keeper.Key",
        "optional":false,
        "type":"struct"
      }
    }:{
      "payload": {
        "after": {
          "consumer":"dttuhfpp97l3********l",
          "locked_by":"dttuhfpp97l3********-1",
          "locked_till":"2022-05-15T09:55:18Z"
        },
      "before": null,
      "op":"u",
      "source": {
        "connector":"postgresql",
        "db":"db1",
        "lsn":85865797008,
        "name":"__data_transfer_stub",
        "schema":"public",
        "snapshot":"false",
        "table":"__consumer_keeper",
        "ts_ms":1652608518883,
        "txId":245165,
        "version":"1.1.2.Final",
        "xmin":null
      },
    ...
    ```

    {% endcut %}

1. Connect to the source cluster and populate the `measurements` table with data:

    ```sql
    INSERT INTO public.measurements VALUES ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Check that the terminal running `kafkacat` shows the information about the new row.

## Delete the resources you created {#clear-out}

To reduce the consumption of resources you do not need, delete them:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) and [delete](../../data-transfer/operations/transfer.md#delete) the transfer.

1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).

1. Delete the clusters:

    * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
    * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

1. If you used static public IP addresses to access the cluster hosts, release and [delete](../../vpc/operations/address-delete.md) them.

