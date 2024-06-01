# Delivering data from {{ mkf-full-name }} to {{ ydb-full-name }}


You can track data changes in a {{ ydb-name }} _source_ and send them to a {{ mkf-name }} _target cluster_ using [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC). This data is automatically added to {{ mkf-short-name }} topics with {{ ydb-name }} table names.

{% include [CDC-YDB](../../_includes/data-transfer/note-ydb-cdc.md) %}

To run data delivery:

1. [Prepare the source](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Prepare the data transfer infrastructure:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.

      1. If you selected {{ dd }} DB mode, [create](../../vpc/operations/security-group-create.md) and [configure](../../ydb/operations/connection.md#configuring-security-groups) a security group in the network hosting the DB.

      1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration with publicly available hosts.

      
      1. If you are using security groups, [configure them so that you can connect to the cluster from the internet](../../managed-kafka/operations/connect/index.md#configuring-security-groups).


      1. Configure {{ KF }} topics in the target cluster. The settings vary depending on the [topic management method](../../managed-kafka/concepts/topics.md#management) used. Data topic names are generated in `<topic_prefix>.<{{ ydb-short-name}}_table_name>` format. In this tutorial, we will use the `cdc` prefix as an example.

         * If topics are managed using standard {{ yandex-cloud }} interfaces (management console, CLI, or API):

            1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `cdc.sensors`.

               To track changes in multiple tables, create a separate topic with the `cdc` prefix for each of them.

            1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) with the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for the `cdc.sensors` topic. To include all created topics, specify `cdc.*` in the topic name.

         * If topics are managed using the Kafka Admin API:

            1. Create an [admin user](../../managed-kafka/operations/cluster-accounts.md).
            1. In addition to `ACCESS_ROLE_ADMIN`, assign the admin user the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for `cdc.*` topics whose names begin with the `cdc` prefix.

               Required topics will be created automatically at the first change in the tracked tables of the source cluster. This solution can be useful to track changes in multiple tables but requires extra free space in cluster storage. For more information, see [{#T}](../../managed-kafka/concepts/storage.md).

         {% endlist %}

   - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [data-transfer-ydb-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-kafka/blob/main/data-transfer-ydb-mkf.tf) configuration file to the same working directory.

         This file describes:

         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mkf-name }} cluster.
         * {{ ydb-name }} database.
         * {{ mkf-name }} target cluster.
         * {{ KF }} topic.
         * {{ KF }} user.
         * Transfer.

         The [topic management method](../../managed-kafka/concepts/topics.md#management) is specified in the {{ TF }} `kf_topics_management` variable. It is set when running the `terraform plan` and `terraform apply` commands (see below):

         * If topics are managed using standard {{ yandex-cloud }} interfaces (management console, CLI, or API):
            1. To track changes in multiple tables, add a description of a separate topic with the `cdc` prefix for each table to the configuration file.
            1. Set the {{ TF }} `kf_topics_management` variable to `false`.

         * If the topics are managed using the Kafka Admin API, set the {{ TF }} `kf_topics_management` variable to `true`.

      1. In the `data-transfer-ydb-mkf.tf` file, specify the variables:

         * `source_db_name`: {{ ydb-name }} database name.
         * `target_kf_version`: {{ KF }} version in the target cluster.
         * `target_user_name`: Username for connecting to the {{ KF }} topic.
         * `target_user_password`: User password.
         * `transfer_enabled`: Set to `0` to ensure that no transfer is created until you [create endpoints manually](#prepare-transfer).

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. Install [kafkacat](https://github.com/edenhill/kcat) to read and write data to {{ KF }} topics.

   ```bash
   sudo apt update && sudo apt install --yes kafkacat
   ```

   Check that you can use it to [connect to the {{ mkf-name }} target cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Prepare the source {#prepare-source}

1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
1. [Create a {{ ydb-short-name }} table](../../ydb/operations/schema.md#create-table). As an example, we will use the `sensors` table with information transmitted by, say, car sensors.

   Add the following columns to the table manually:

   | {{ ui-key.yacloud.ydb.browse.info.column_name }} | {{ ui-key.yacloud.ydb.browse.info.column_type }} | {{ ui-key.yacloud.ydb.table.form.column_primary-key }} |
   |:--------------------|:---------|:---------------|
   | `device_id`         | `String` | Yes            |
   | `datetime`          | `String` |                |
   | `latitude`          | `Double` |                |
   | `longitude`         | `Double` |                |
   | `altitude`          | `Double` |                |
   | `speed`             | `Double` |                |
   | `battery_voltage`   | `Double` |                |
   | `cabin_temperature` | `Uint8`  |                |
   | `fuel_level`        | `Uint32` |                |

   In other settings, leave the defaults.

   You can also create a table with the following YQL command:

   ```sql
   CREATE TABLE sensors (
       device_id String,
       datetime String,
       latitude Double,
       longitude Double,
       altitude Double,
       speed Double,
       battery_voltage Double,
       cabin_temperature Uint8,
       fuel_level Uint32,
       PRIMARY KEY (device_id)
   )
   ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `YDB`.
   * **Endpoint parameters**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} database from the list.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select or create a service account with the `editor` role.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**: Specify the names of tables and {{ ydb-name }} database directories to transfer.

         {% note warning %}

         Only the listed tables and directories will be replicated. If you do not specify any names, no tables will be transferred.

         {% endnote %}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):
   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
   * **Endpoint parameters**:
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the [previously created](#before-you-begin) {{ mkf-name }} source cluster.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Specify the details of the [created](#before-you-begin) {{ KF }} user.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: `cdc.sensors`.

      If you need to track changes in multiple tables, fill out the fields as follows:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Enter the `cdc` prefix you used to generate topic names.

1. Create a transfer:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   - {{ TF }} {#tf}

      1. In the `data-transfer-ydb-mkf.tf` file, specify the variables:

         * `source_endpoint_id`: ID of the source endpoint.
         * `target_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set to `1` to enable transfer creation.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, your transfer will be activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. In a separate terminal, run the `kafkacat` utility in consumer mode:

   ```bash
   kafkacat \
       -C \
       -b <FQDN_of_broker_host_1>:9091,...,<FQDN_of_broker_host_N>:9091 \
       -t cdc.sensors \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username=kafka-user \
       -X sasl.password=<password> \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
       -Z \
       -K:
   ```

   You can obtain the FQDNs of broker hosts with a [list of hosts in the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md) and [add test data](../../ydb/operations/crud.md) to the `sensors` table:

   ```sql
   REPLACE INTO sensors (device_id, datetime, latitude, longitude, altitude, speed, battery_voltage, cabin_temperature, fuel_level) VALUES
       ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196, 427.5, 0, 23.5, 17, NULL),
       ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
       ('iv9a94th6rzt********', '2022-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, NULL, 20.5, 15, 20);
   ```

1. Make sure the terminal running the `kafkacat` utility displays the `sensors` table data format schema and information about the rows added.

   {% cut "Example of the message fragment" %}

   ```json
   {
     "payload": {
         "device_id": "aXY5YTk0dGg2cnp0b294********"
       },
       "schema": {
         "fields": [
           {
               "field": "device_id",
               "optional": false,
               "type": "bytes"
           }
         ],
         "name": "cdc..sensors.Key",
         "optional": false,
         "type": "struct"
       }
   }: {
     "payload": {
       "after": {
           "altitude": 378,
           "battery_voltage": 20.5,
           "cabin_temperature": 15,
           "datetime": "MjAyMi0wNi0wOCAxNzo0********",
           "device_id": "aXY5YTk0dGg2cnp0b294********",
           "fuel_level": 20,
           "latitude": 53.70987913,
           "longitude": 36.62549834,
           "speed": null
       },
       "before": null,
       "op": "c",
       "source": {
           "db": "",
           "name": "cdc",
           "snapshot": "false",
           "table": "sensors",
           "ts_ms": 1678642104797,
           "version": "1.1.2.Final"
       },
       "transaction": null,
       "ts_ms": 1678642104797
     },
     "schema": {
       "fields": [
           {
               "field": "before",
               "fields": [
                   {
                       "field": "device_id",
                       "optional": false,
                       "type": "bytes"
                   },
                   ...
               ],
               "name": "cdc..sensors.Value",
               "optional": true,
               "type": "struct"
           },
           {
               "field": "after",
               "fields": [
                   {
                       "field": "device_id",
                       "optional": false,
                       "type": "bytes"
                   },
                   ...
               ],
               "name": "cdc..sensors.Value",
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
                   {
                       "field": "connector",
                       "optional": false,
                       "type": "string"
                   },
                   {
                       "field": "name",
                       "optional": false,
                       "type": "string"
                   },
                   {
                       "field": "ts_ms",
                       "optional": false,
                       "type": "int64"
                   },
                   {
                       "default": "false",
                       "field": "snapshot",
                       "name": "io.debezium.data.Enum",
                       "optional": true,
                       "parameters": {
                           "allowed": "true,last,false"
                       },
                       "type": "string",
                       "version": 1
                   },
                   {
                       "field": "db",
                       "optional": false,
                       "type": "string"
                   },
                   {
                       "field": "table",
                       "optional": false,
                       "type": "string"
                   }
               ],
               "optional": false,
               "type": "struct"
           },
           ...,
           {
               "field": "transaction",
               "fields": [
                   {
                       "field": "id",
                       "optional": false,
                       "type": "string"
                   },
                   {
                       "field": "total_order",
                       "optional": false,
                       "type": "int64"
                   },
                   {
                       "field": "data_collection_order",
                       "optional": false,
                       "type": "int64"
                   }
               ],
               "optional": true,
               "type": "struct"
           }
       ],
       "name": "cdc..sensors.Envelope",
       "optional": false,
       "type": "struct"
     }
   }
   ```

   {% endcut %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
1. If you created a service account together with the source endpoint, [delete it](../../iam/operations/sa/delete.md).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
   1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-ydb-mkf.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file `data-transfer-mkf-ydb.tf` will be deleted.

{% endlist %}
