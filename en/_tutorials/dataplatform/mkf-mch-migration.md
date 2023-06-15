# Delivering data from {{ mkf-full-name }} to {{ mch-full-name }} using {{ data-transfer-full-name }}

A {{ mch-name }} cluster can get data from {{ KF }} topics in real time. Managed Service for ClickHouse automatically inserts data sent to {{ CH }} tables on the [`Kafka` engine]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

To set up data delivery from {{ mkf-name }} to {{ mch-name }}:

1. [Send test data to {{ mkf-name }} topic](#send-sample-data-to-kf).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

* Manually

   1. [Create a source {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) of any suitable [configuration](../../managed-kafka/concepts/instance-types.md). To connect to the cluster from the user's local machine rather than doing so from the {{ yandex-cloud }} cloud network, enable public access to the cluster when creating it.

   1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) in the {{ mkf-name }} cluster.

   1. [Create users](../../managed-kafka/operations/cluster-accounts.md#create-account) so that the [producer and consumer](../../managed-kafka/concepts/producers-consumers.md) can access the topic in the {{ mkf-name }} cluster:

      * With the `ACCESS_ROLE_PRODUCER` role for the producer.
      * With the `ACCESS_ROLE_CONSUMER` role for the consumer.

   1. Create a [{{ mch-name }} target cluster](../../managed-clickhouse/operations/cluster-create.md) with any suitable [configuration](../../managed-clickhouse/concepts/instance-types.md). To connect to the cluster from the user's local machine rather than doing so from the {{ yandex-cloud }} cloud network, enable public access to the cluster when creating it.

   
   1. If you are using security groups, configure them to enable connecting to the clusters from the internet:

      * [{{ mkf-name }}](../../managed-kafka/operations/connect.md#configuring-security-groups).
      * [{{ mch-name }}](../../managed-clickhouse/operations/connect.md#configuring-security-groups).

      {% include [preview-pp.md](../../_includes/preview-pp.md) %}


* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [data-transfer-mkf-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mkf-mch.tf) to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [security group](../../vpc/concepts/security-groups.md) and rules required to connect to the clusters from the internet.
      * A source {{ mkf-name }} cluster with a description of a topic and two users on whose behalf the producer and consumer will connect to the topic.
      * {{ mch-name }} target cluster.
      * Target endpoint.
      * Transfer.

   1. In the `data-transfer-mkf-mch.tf` file, specify:

      * Source {{ mkf-name }} cluster parameters:

         * `source_user_producer` and `source_password_producer`: Username and password for the producer user.
         * `source_user_consumer` and `source_password_consumer`: Username and password of the consumer user.
         * `source_topic_name`: Name of the topic.

      * The {{ mch-name }} target cluster parameters that will also be used as the [target endpoint parameters](../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

         * `target_db_name`: Database name {{ mch-name }}.
         * `target_user` and `target_password`: Database owner username and password.

   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Configure additional settings {#additional-settings}

1. Install the utilities:

   * [kafkacat](https://github.com/edenhill/kcat): To read and write data to the {{ KF }} topic.

      ```bash
      sudo apt update && sudo apt install --yes kafkacat
      ```

      Check that you can use it to [connect to {{ mkf-name }} clusters over SSL](../../managed-kafka/operations/connect.md#connection-string).

   * [clickhouse-client]({{ ch.docs }}/interfaces/cli/): to connect to the database in the {{ mch-name }} cluster.

      1. Connect the [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

         ```bash
         sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
         sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
         echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
         /etc/apt/sources.list.d/clickhouse.list
         ```

      1. Install the dependencies:

         ```bash
         sudo apt update && sudo apt install --yes clickhouse-client
         ```

      1. Download the configuration file for `clickhouse-client`:

         {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

      Check that you can use it to [connect to the {{ mch-name }} cluster over SSL](../../managed-clickhouse/operations/connect.md#connection-string).

   * [jq](https://stedolan.github.io/jq/) for JSON file stream processing.

      ```bash
      sudo apt update && sudo apt-get install --yes jq
      ```

## Send test data to the {{ mkf-name }} topic {#send-sample-data-to-kf}

Suppose that your {{ KF }} topic receives data from car sensors. This data will be transmitted as {{ KF }} messages in JSON format:

```json
{
    "device_id":"iv9a94th6rztooxh5ur2",
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

The {{ mch-name }} cluster will use [JSONEachRow format]({{ ch.docs }}/interfaces/formats/#jsoneachrow) to insert data to `Kafka` tables. This format converts strings from {{ KF }} messages to relevant column values.

1. Create a `sample.json` file with the following test data:

   {% cut "sample.json" %}

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

   {% endcut %}

1. Send data from the `sample.json` file to the {{ mkf-name }} topic using `jq` and `kafkacat`:

   ```bash
   jq -rc . sample.json | kafkacat -P \
      -b <FQDN broker host>:9091 \
      -t <topic name> \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username="<producer username>" \
      -X sasl.password="<user password for the producer>" \
      -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
   ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.connection.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.connection_type.title }}**: `Yandex Managed Service for Kafka cluster`.

         * **Managed Service for Kafka cluster**: Select the source cluster from the list.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.user.title }}**: Enter the consumer username.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.password.title }}**: Enter the consumer password.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}**: Enter the name of the topic in the {{ mkf-name }} cluster.

      * (Optional) : **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.advanced_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**:

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}**: `JSON`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: `JSON specification`.

            Create and upload the `json_schema.json` file in JSON format:

            {% cut "json_schema.json" %}

            ```json
            [
                {
                    "name": "device_id",
                    "type": "string"
                },
                {
                    "name": "datetime",
                    "type": "datetime"
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
                    "type": "any"
                },
                {
                    "name": "cabin_temperature",
                    "type": "double"
                },
                {
                    "name": "fuel_level",
                    "type": "any"
                }
            ]
            ```

            {% endcut %}

1. Create an endpoint for the target and the transfer:

   {% list tabs %}

   * Manually

      1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ CH }}`.
         * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.connection.title }}**:

               * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.mdb_cluster_id.title }}`.

                  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.mdb_cluster_id.title }}**: Select the source cluster from the list.

               * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: Enter the database name.
               * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.user.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.password.title }}**: Enter the name and password of the user who has access to the database (for example, the database owner).

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.advanced_settings.title }}** → **Upload data in JSON format**: Enable this option if you enabled **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}** in the advanced settings of the source endpoint.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   * Using {{ TF }}

      1. In the `data-transfer-mkf-mch.tf` file, uncomment:

         * The `source_endpoint_id` parameter and assign to it the value of the endpoint ID for the source created in the previous step.
         * The `yandex_datatransfer_endpoint` and `yandex_datatransfer_transfer` resources.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, your transfer will be activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the data from the source {{ mkf-name }} cluster has been moved to the {{ mch-name }} database:

   1. [Connect to the cluster](../../managed-clickhouse/operations/connect.md) using `clickhouse-client`:

   1. Run the following query:

      ```sql
      SELECT * FROM <{{ CH }} database name>.<{{ KF }} topic name>
      ```

1. Change values in the `sample.json` file and send data from it to the {{ mkf-name }} topic:

   ```bash
   jq -rc . sample.json | kafkacat -P \
      -b <opic name>:9091 \
      -t <topic name> \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username="<producer username>" \
      -X sasl.password="<user password for the producer>" \
      -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
   ```

1. Make sure that the new values are now in the {{ mch-name }} database:

   1. [Connect to the cluster](../../managed-clickhouse/operations/connect.md) using `clickhouse-client`:

   1. Run the following query:

      ```sql
      SELECT * FROM <{{ CH }} database name>.<{{ KF }} topic name>
      ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [disable the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).

Delete the other resources, depending on the method used to create them:

{% list tabs %}

* Manually

   * [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
   * [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
   * [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).

* Using {{ TF }}

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the configuration file `data-transfer-mkf-mch.tf`.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file `data-transfer-mkf-mch.tf` will be deleted.

{% endlist %}
