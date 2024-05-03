# Delivering data from {{ mpg-full-name }} to {{ mkf-full-name }} using {{ data-transfer-full-name }}

You can track data changes in a {{ mpg-name }} _source cluster_ and send them to a {{ mkf-name }} _target cluster_ using Change Data Capture (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare the target cluster](#prepare-target).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Create a {{ mpg-name }} source cluster](../../managed-postgresql/operations/cluster-create.md) in any suitable configuration with the following settings:

   * Database: `db1`
   * Username: `pg-user`
   * Hosts: Publicly available

1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration with publicly available hosts.


1. If you are using security groups, configure them to enable connecting to the clusters from the internet:

   * [Guide for {{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups)
   * [Guide for {{ mkf-name }}](../../managed-kafka/operations/connect.md#configuring-security-groups)


1. Install the `kcat` (`kafkacat`) [utility](https://github.com/edenhill/kcat) and [PostgreSQL command-line client](https://www.postgresql.org/download/) on the local machine. For example, in Ubuntu 20.04, run:

   ```bash
   sudo apt update && sudo apt install kafkacat postgresql-client --yes
   ```

## Prepare the source cluster {#prepare-source}

1. For {{ data-transfer-name }} to get notifications of data changes from a {{ mpg-name }} cluster, create a publication in a source cluster. The `pg-user` user can create a publication after you [assign](../../managed-postgresql/operations/grant.md) them the `mdb_replication` role.

1. [Connect](../../managed-postgresql/operations/connect.md) to the `db1` database on behalf of `pg-user`.

1. Add test data to the database. In this example, a simple table with information from car sensors is used.

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

## Prepare the target cluster{#prepare-target}

The settings vary depending on the [topic management method](../../managed-kafka/concepts/topics.md#management) used. The same conventions are used for topic names as in [Debezium](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names): `<topic_prefix>.<schema_name>.<table_name>`. In this tutorial, the `cdc` prefix is used as an example.

{% list tabs group=topic_management %}

- {{ yandex-cloud }} interfaces {#yc}

   If topics are managed using standard {{ yandex-cloud }} interfaces (management console, YC CLI, {{ TF }}, API):

   1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `cdc.public.measurements`.

      If you need to track data changes in multiple tables, create a separate topic for each one of them.

   1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `kafka-user` and `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for the created topics.

- Admin API {#api}

   If topics are managed using the Kafka Admin API:

   1. Create an [administrator-user](../../managed-kafka/operations/cluster-accounts.md) named `kafka-user`.

   1. In addition to `ACCESS_ROLE_ADMIN`, assign the administrator user the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for the topics which names begin with the `cdc` prefix.

      Required topics will be created automatically at the first change event in the tracked tables of a source cluster. This solution can be useful to track changes in multiple tables but requires extra free space in cluster storage. For more information, see [{#T}](../../managed-kafka/concepts/storage.md).

{% endlist %}


## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create).

   * Source endpoint:

      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`
      * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: Select the [created](#before-you-begin) {{ mpg-name }} cluster.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: `db1`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: `pg-user`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: Enter the password for `pg-user`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}**: `public.measurements`.

   * Target endpoint:

      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`
      * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the target cluster.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Enter the details of the created `kafka-user` user.

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}**: `cdc.public.measurements`.

         If you need to track changes in multiple tables, fill out the fields as follows:

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Enter the `cdc` prefix you used to generate topic names.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with the following settings:

   * **{{ ui-key.yacloud.data-transfer.label_endpoints }}**:
      * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}**: Created source endpoint.
      * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**: Created target endpoint.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**.

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

## Test the transfer {#verify-transfer}

1. In a separate terminal, run the `kafkacat` utility in consumer mode:

   ```bash
   kafkacat \
       -C \
       -b <FQDN_of_broker_host_1>:9091,...,<FQDN_of_broker_host_N>:9091 \
       -t cdc.public.measurements \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username=kafka-user \
       -X sasl.password=<password> \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
       -Z \
       -K:
   ```

   You can obtain the FQDNs of broker hosts with a [list of hosts in the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

   The data format schema of the `public.measurements` table and the information about the previously added rows will be printed.

   {% cut "Example of the message fragment" %}

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

1. Connect to the source cluster and add data to the `measurements` table:

   ```sql
   INSERT INTO public.measurements VALUES ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
   ```

1. Make sure the terminal running `kafkacat` displays details about the added row.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) and [delete](../../data-transfer/operations/transfer.md#delete) the transfer.

1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).

1. Delete the clusters:

   * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
   * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

1. If static public IP addresses were used for accessing the cluster hosts, release and [delete](../../vpc/operations/address-delete.md) them.

