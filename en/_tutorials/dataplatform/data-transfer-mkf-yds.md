# Delivering data from an {{ KF }} queue to {{ DS }}


A {{ yds-name }} stream can get data from {{ KF }} topics in real time.

To run data delivery:

1. [Create a stream for the {{ yds-name }} target](#create-target-yds).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Prepare the data transfer infrastructure:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a {{ mkf-name }} source cluster](../../managed-kafka/operations/cluster-create.md) with any suitable configuration.
      1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.
      1. [In the source cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.
      1. [In the source cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions to the created topic.

   - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [data-transfer-mkf-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-yds/blob/main/data-transfer-mkf-ydb.tf) configuration file to the same working directory.

         This file describes:

         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security group](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mkf-name }} cluster.
         * {{ mkf-name }} source cluster.
         * {{ KF }} topic.
         * {{ ydb-name }} database.
         * Transfer.

      1. In the `data-transfer-mkf-ydb.tf` file, specify the variables:

         * `source_kf_version`: {{ KF }} version in the source cluster.
         * `source_user_name`: Username for establishing a connection to the {{ KF }} topic.
         * `source_user_password`: User password.
         * `target_db_name`: {{ ydb-name }} database name.
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

   The created {{ KF }} `sensors` topic in the source cluster will receive test data from car sensors in JSON format:

   ```json
   {
       "device_id":"iv9a94th6rzt********",
       "datetime":"2020-06-05 17:27:00",
       "latitude":"55.70329032",
       "longitude":"37.65472196",
       "altitude":"427.5",
       "speed":"0",
       "battery_voltage":"23.5",
       "cabin_temperature":"17",
       "fuel_level":null
   }
   ```

1. Install the utilities:

   - [kafkacat](https://github.com/edenhill/kcat) to read and write data to {{ KF }} topics.

      ```bash
      sudo apt update && sudo apt install --yes kafkacat
      ```

      Check that you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

   - [jq](https://stedolan.github.io/jq/) for JSON file stream processing.

      ```bash
      sudo apt update && sudo apt-get install --yes jq
      ```

## Create a stream for the {{ yds-name }} target {#create-target-yds}

[Create a stream for the {{ yds-name }} target](../../data-streams/operations/aws-cli/create.md) in the {{ ydb-name }} database.

## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`{{ KF }}` source](../../data-transfer/operations/endpoint/source/kafka.md):

   **Endpoint parameters**:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`

      Select a source cluster from the list and specify its connection settings.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.advanced_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**: `json`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: You can specify a schema in two ways:

         * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.fields.title }}`.

            Set a list of topic fields manually:

            | Name | Type | Key |
            | :-- | :-- | :--- |
            | `device_id` | `STRING` | Yes |
            | `datetime` | `STRING` |  |
            | `latitude` | `DOUBLE` |  |
            | `longitude` | `DOUBLE` |  |
            | `altitude` | `DOUBLE` |  |
            | `speed` | `DOUBLE` |  |
            | `battery_voltage` | `DOUBLE` |
            | `cabin_temperature` | `UINT16` |
            | `fuel_level` | `UINT16` |

         * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`.

            Create and upload the `json_schema.json` file in JSON format:

            {% cut "json_schema.json" %}

            ```json
            [
                {
                    "name": "device_id",
                    "type": "string",
                    "key": true
                },
                {
                    "name": "datetime",
                    "type": "string"
                },
                {
                    "name": "latitude",
                    "type": "double"
                },
                {
                    "name": "longitude",
                    "type": "double"
                },
                {
                    "name": "altitude",
                    "type": "double"
                },
                {
                    "name": "speed",
                    "type": "double"
                },
                {
                    "name": "battery_voltage",
                    "type": "double"
                },
                {
                    "name": "cabin_temperature",
                    "type": "uint16"
                },
                {
                    "name": "fuel_level",
                    "type": "uint16"
                }
            ]
            ```

            {% endcut %}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`{{ yds-full-name }}` target](../../data-transfer/operations/endpoint/target/data-streams.md):

   **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTarget.connection.title }}**:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select the {{ ydb-name }} database from the list.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the {{ yds-name }} data stream.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select or create a service account with the `yds.editor` role.

1. Create a transfer:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   - {{ TF }} {#tf}

      1. In the `data-transfer-mkf-ydb.tf` file, specify the variables:

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
1. Make sure the data from the topic in the source {{ mkf-name }} cluster is being moved to the {{ yds-name }} stream:

   1. Create a `sample.json` file with the following test data:

      ```json
      {
          "device_id": "iv9a94th6rzt********",
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
          "device_id": "rhibbh3y08qm********",
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
          "device_id": "iv9a94th6r********",
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

   1. Send data from the `sample.json` file to the {{ mkf-name }} `sensors` topic using `jq` and `kafkacat`:

      ```bash
      jq -rc . sample.json | kafkacat -P \
         -b <broker_host_FQDN>:9091 \
         -t sensors \
         -k key \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanisms=SCRAM-SHA-512 \
         -X sasl.username="<username_in_the_source_cluster>" \
         -X sasl.password="<user_password_in_the_source_cluster>" \
         -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
      ```

      The data is sent on behalf of the [created user](#prepare-source). To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../../managed-kafka/operations/connect/clients.md).

   {% include [get-yds-data](../../_includes/data-transfer/get-yds-data.md) %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
1. If you created a service account together with the target endpoint, [delete it](../../iam/operations/sa/delete.md).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
   1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mkf-ydb.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file `data-transfer-mkf-ydb.tf` will be deleted.

{% endlist %}
