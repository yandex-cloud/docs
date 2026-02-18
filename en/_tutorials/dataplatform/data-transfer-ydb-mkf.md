# Delivering data from {{ ydb-full-name }} to {{ mkf-full-name }}


You can track data changes in a {{ ydb-name }} _source_ and send them to a {{ mkf-name }} _target cluster_ using [change data capture](../../data-transfer/concepts/cdc.md) (CDC). The system will automatically insert this data into {{ mkf-short-name }} topics with {{ ydb-name }} table names.

{% include [CDC-YDB](../../_includes/data-transfer/note-ydb-cdc.md) %}

To start data delivery:

1. [Prepare the source](#prepare-source).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../ydb/pricing/index.md)). Its cost depends on the deployment mode:

	* In serverless mode, you pay for data operations as well as the amount of stored data and backups.
  	* In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.

* {{ mkf-name }} cluster, which includes computing resources allocated to hosts, as well as the storage and backup size (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer, which includes the use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

1. Set up your data delivery infrastructure:

   {% list tabs group=instructions %}

   - Manually {#manual}


       1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) of your preferred configuration.

       1. If you selected {{ dd }} database mode, [create](../../vpc/operations/security-group-create.md) and [configure](../../ydb/operations/connection.md#configuring-security-groups) a security group in the network hosting your database.

       1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration with publicly accessible hosts.

          {% include [public-access](../../_includes/mdb/note-public-access.md) %}

       
        1. If using security groups, [configure them to allow internet access to your cluster](../../managed-kafka/operations/connect/index.md#configuring-security-groups).


       1. Configure {{ KF }} topics in the target cluster. The settings vary depending on the [topic management method](../../managed-kafka/concepts/topics.md#management) used. The format for data topic names is as follows: `<topic_prefix>.<{{ ydb-short-name }}_table_name>`. In this tutorial, we will use the `cdc` prefix as an example.

          * When managing topics using the native {{ yandex-cloud }} interfaces (management console, CLI, or API):

              1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `cdc.sensors`.

                 To track changes in multiple tables, create a separate topic with the `cdc` prefix for each of them.

              1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) with the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for the `cdc.sensors` topic. To include all created topics, specify `cdc.*` in the topic name.

          * When managing topics via the Kafka Admin API:

              1. Create an [admin user](../../managed-kafka/operations/cluster-accounts.md).
              1. In addition to `ACCESS_ROLE_ADMIN`, assign the admin user the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for `cdc.*` topics whose names are prefixed with `cdc`.

                 The system will automatically create the relevant topics upon the first change to the source cluster tables you are tracking. This solution can help tracking changes in multiple tables but it requires extra free space in the cluster storage. For more information, see [{#T}](../../managed-kafka/concepts/storage.md).

   - {{ TF }} {#tf}

       1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
       1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
       1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
       1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

       1. Download the [data-transfer-ydb-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-kafka/blob/main/data-transfer-ydb-mkf.tf) configuration file to the same working directory.

           This file describes:

           * [Network](../../vpc/concepts/network.md#network).
           * [Subnet](../../vpc/concepts/network.md#subnet).
           * [Security group](../../vpc/concepts/security-groups.md) and the rule required for connecting to the {{ mkf-name }} cluster.
           * {{ ydb-name }} database.
           * {{ mkf-name }} target cluster.
           * {{ KF }} topic.
           * {{ KF }} user.
           * Transfer.

           The [topic management method](../../managed-kafka/concepts/topics.md#management) is specified in the `kf_topics_management` {{ TF }} variable. You set it when running the `terraform plan` and `terraform apply` commands (see below):

           * When managing topics using the native {{ yandex-cloud }} interfaces (management console, CLI, or API):
               1. To track changes in multiple tables, add the descriptions of separate topics with the `cdc` prefix to the configuration file, one for each table.
               1. Set the `kf_topics_management` {{ TF }} variable to `false`.

           * When managing topics using the Kafka Admin API, set the `kf_topics_management` {{ TF }} variable to `true`.

       1. In the `data-transfer-ydb-mkf.tf` file, specify the following variables:

           * `source_db_name`: {{ ydb-name }} database name.
           * `target_kf_version`: {{ KF }} version in the target cluster.
           * `target_user_name`: Username for connection to the {{ KF }} topic.
           * `target_user_password`: User password.
           * `transfer_enabled`: Set to `0` to ensure no transfer is created until you [create endpoints manually](#prepare-transfer).

       1. Validate your {{ TF }} configuration files using this command:

           ```bash
           terraform validate
           ```

           {{ TF }} will display any configuration errors detected in your files.

       1. Create the required infrastructure:

           {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

           {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. Install [kafkacat](https://github.com/edenhill/kcat) for data reads and writes in {{ KF }} topics.

    ```bash
    sudo apt update && sudo apt install --yes kafkacat
    ```

    Make sure you can use it to [connect to the {{ mkf-name }} target cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Prepare the source {#prepare-source}

1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
1. [Create a {{ ydb-short-name }} table](../../ydb/operations/schema.md#create-table). As an example, we will use the `sensors` table with data collected from some car sensors.

   Add the following columns to the table manually:

    | {{ ui-key.yacloud.ydb.browse.info.column_name }} | {{ ui-key.yacloud.ydb.browse.info.column_type }} | {{ ui-key.yacloud.ydb.table.form.column_primary-key }} |
    |:--------------------|:---------|:---------------|
    | `device_id`         | `String` | Yes             |
    | `datetime`          | `String` |                |
    | `latitude`          | `Double` |                |
    | `longitude`         | `Double` |                |
    | `altitude`          | `Double` |                |
    | `speed`             | `Double` |                |
    | `battery_voltage`   | `Double` |                |
    | `cabin_temperature` | `Uint8`  |                |
    | `fuel_level`        | `Uint32` |                |

    Leave the default values for the other settings.

    You can also create a table by running this YQL command:

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

## Set up and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `YDB`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} database from the list.

           
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select an existing service account or create a new one with the `editor` role.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**: Specify the names of tables and {{ ydb-name }} database directories to transfer.

           {% note warning %}

           Only the listed tables and directories will be replicated. If you do not specify any names, no tables will be transferred.

           {% endnote %}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):
    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the [previously created](#before-you-begin) {{ mkf-name }} source cluster.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Specify the credentials of the {{ KF }} user [you created](#before-you-begin).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: `cdc.sensors`.

        If you need to track changes in multiple tables, fill in the fields as follows:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Enter the `cdc` prefix you used to generate topic names.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the endpoints you created.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `data-transfer-ydb-mkf.tf` file, specify the following variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: Set to `1` to create a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            The transfer will be activated automatically upon creation.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. In a separate terminal, run `kafkacat` in consumer mode:

    ```bash
    kafkacat \
        -C \
        -b <broker_host_1_FQDN>:9091,...,<broker_host_N_FQDN>:9091 \
        -t cdc.sensors \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<password> \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
        -Z \
        -K:
    ```

    You can get the FQDNs of broker hosts with the [list of hosts in the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-hosts.md).

1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md) and [add test data](../../ydb/operations/crud.md) to the `sensors` table:

    ```sql
    REPLACE INTO sensors (device_id, datetime, latitude, longitude, altitude, speed, battery_voltage, cabin_temperature, fuel_level) VALUES 
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196, 427.5, 0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th6rzt********', '2022-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, NULL, 20.5, 15, 20);
    ```

1. Make sure the terminal running `kafkacat` displays the data format schema of the `sensors` table and information about the added rows.

    {% cut "Message snippet example" %}

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

Before deleting the resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources, delete those you do not need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).


1. If you created a service account when creating the source endpoint, [delete it](../../iam/operations/sa/delete.md).


1. Delete the other resources depending on how you created them:

   {% list tabs group=instructions %}

   - Manually {#manual}

       1. [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
       1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).

   - {{ TF }} {#tf}

       {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
