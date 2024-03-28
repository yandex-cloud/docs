# Delivering data from {{ mmy-full-name }} to {{ mkf-full-name }} using {{ data-transfer-full-name }}

You can track data changes in a {{ mmy-name }} _source cluster_ and send them to a {{ mkf-name }} _target cluster_ using [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare the target cluster](#prepare-target).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) in any suitable configuration with the following settings:

   * Database: `db1`
   * Username: `my-user`
   * Hosts: Publicly available

1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration with publicly available hosts.


1. If you are using security groups, configure them to enable connecting to the clusters from the internet:

   * [Guide for {{ mmy-name }}](../../managed-mysql/operations/connect.md#configuring-security-groups)
   * [Guide for {{ mkf-name }}](../../managed-kafka/operations/connect.md#configuring-security-groups)


1. Install the `kcat` (`kafkacat`) [utility](https://github.com/edenhill/kcat) and the [MySQL command-line tool](https://www.mysql.com/downloads/) on the local machine. For example, in Ubuntu 20.04, run:

   ```bash
   sudo apt update && sudo apt install kafkacat mysql-client --yes
   ```

## Prepare the source cluster {#prepare-source}

1. For {{ data-transfer-name }} to get notifications about data updates from a {{ mmy-name }} cluster, you need to configure external replication in the source cluster. To enable `my-user` to perform replication, [assign the user the role](../../managed-mysql/operations/grant.md) `ALL_PRIVILEGES` for the `db1` database and [grant the global privileges](../../managed-mysql/operations/cluster-users.md#update-settings) `REPLICATION CLIENT` and `REPLICATION SLAVE`.

1. [Connect to the database](../../managed-mysql/operations/connect.md) `db1` on behalf of `my-user`.

1. Add test data to the database. As an example, we will use a simple table with information transmitted by car sensors.

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

## Prepare the target cluster{#prepare-target}

The settings vary depending on the [topic management method](../../managed-kafka/concepts/topics.md#management) used. Data topic names are generated using the following convention: `<topic_prefix>.<schema_name>.<table_name>`. In this tutorial, the `cdc` prefix is used as an example.

{% list tabs group=topic_management %}

- {{ yandex-cloud }} interfaces {#yc}

   If topics are managed using standard {{ yandex-cloud }} interfaces (management console, YC CLI, {{ TF }}, API):

   1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `cdc.db1.measurements`.

      To track updates to more than one table, create a separate topic for each one.

   1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) named `kafka-user` with the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for the topics created. To include all such topics, put `cdc.*` in the topic name.

- Admin API {#api}

   If topics are managed using the Kafka Admin API:

   1. Create an [administrator-user](../../managed-kafka/operations/cluster-accounts.md) named `kafka-user`.

   1. In addition to `ACCESS_ROLE_ADMIN`, assign the administrative user the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for topics whose names begin with the `cdc` prefix.

      Required topics will be created automatically at the first change event in the tracked tables of a source cluster. This solution can be useful to track changes in multiple tables but requires extra free space in cluster storage. For more information, see [{#T}](../../managed-kafka/concepts/storage.md).

{% endlist %}

## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the {{ MY }} source with the following [settings](../../data-transfer/operations/endpoint/source/mysql.md):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MYSQL }}`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}**: Select the [created](#before-you-begin) {{ mmy-name }} cluster.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.database.title }}**: `db1`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: `my-user`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: Specify the password for `my-user`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}**: `db1.measurements`.

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the {{ KF }} target with the following [settings](../../data-transfer/operations/endpoint/source/kafka.md):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-KAFKA }}`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the [created](#before-you-begin) {{ mkf-name }} cluster.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Enter the details of the created `kafka-user` user.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: `cdc.db1.measurements`.

      If you need to track changes in multiple tables, fill out the fields as follows:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Enter the `cdc` prefix you used to generate topic names.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type with the created source and target endpoints.
1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

## Test the transfer {#verify-transfer}

1. In a separate terminal, run the `kafkacat` utility in consumer mode:

   ```bash
   kafkacat \
       -C \
       -b <FQDN_of_broker_host_1>:9091,...,<FQDN_of_broker_host_N>:9091 \
       -t cdc.db1.measurements \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username=kafka-user \
       -X sasl.password=<password> \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
       -Z \
       -K:
   ```

   You can obtain the FQDNs of broker hosts with a [list of hosts in the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

1. Connect to the source cluster and add data to the `measurements` table:

   ```sql
   INSERT INTO db1.measurements VALUES
       ('iv7b74th678t********', '2022-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL),
       ('iv9a94th678t********', '2022-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
   ```

1. Make sure the terminal running the `kafkacat` utility is displaying the `db1.measurements` table data format schema and information on the inserted rows.

   {% cut "Example of the message fragment" %}

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

### Specifics of data delivery with {{ data-transfer-name }} {#features}

* Transferring data from {{ MY }} to {{ KF }} modifies some data types:

   * `tinyint(1)` transfers as `boolean`.
   * `real` transfers as `double`.
   * `bigint unsigned` transfers as `int64`.

* Under `payload.source` source metadata, omit the `server_id` and `thread` parameters.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) and [delete](../../data-transfer/operations/transfer.md#delete) the transfer.

1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).

1. Delete the clusters:

   * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
   * [{{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).

1. If static public IP addresses were used for accessing the cluster hosts, release and [delete](../../vpc/operations/address-delete.md) them.
