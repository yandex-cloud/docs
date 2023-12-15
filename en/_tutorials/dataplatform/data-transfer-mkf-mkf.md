# Migrating data between {{ KF }} clusters using {{ data-transfer-full-name }}

You can transfer your data from {{ KF }} topics between one {{ KF }} cluster and another in real time. Migration across versions is also supported. For example, you can move topics from {{ KF }} ver. 2.8 to ver. 3.1.

This method of data migration enables you to:

* Set up topic replication in the management console interface or in {{ TF }}.
* Track the migration process using the [transfer monitoring](../../data-transfer/operations/monitoring.md).
* Go without creating an intermediate VM or granting online access to your target cluster.

{% note info %}

This tutorial describes a scenario for migrating data from one {{ mkf-name }} cluster to another.

{% endnote %}

To migrate data:

1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Prepare the data transfer infrastructure:

   {% list tabs %}

   * Manually

      1. Create a [source and target {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) with public internet access, in any suitable configuration.
      1. [In the source cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.
      1. [In the source cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions to the created topic.
      1. [In the target cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions for all the topics.

   * Using {{ TF }}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [data-transfer-mkf-mkf.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mkf-mkf.tf) configuration file to the same working directory.

         This file describes:

         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mkf-name }} cluster.
         * {{ mkf-name }} source cluster with public internet access.
         * {{ mkf-name }} target cluster.
         * {{ KF }} topic.
         * Transfer.

      1. In the `data-transfer-mkf-mkf.tf` file, specify the values of parameters:

         * `source_kf_version`: {{ KF }} version in the source cluster.
         * `source_user_name`: Username for establishing a connection to the {{ KF }} topic.
         * `source_user_password`: User password.
         * `target_kf_version`: {{ KF }} version in the target cluster.
         * `transfer_enabled`: Set `0` to ensure that no transfer is created before the [source and target endpoints are created manually](#prepare-transfer).

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

   The created {{ KF }} `sensors` topic in the source cluster will receive test data from car sensors in JSON format, for example:

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

      Check that you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect.md#connection-string).

   - [jq](https://stedolan.github.io/jq/) for JSON file stream processing.

      ```bash
      sudo apt update && sudo apt-get install --yes jq
      ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-KAFKA }}`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.

         Select a target cluster from the list and specify its connection settings.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**:
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: `measurements`.

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-KAFKA }}`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.

         Select a source cluster from the list and specify its connection settings.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}**: `sensors`.

1. Create a transfer:

   {% list tabs %}

   * Manually

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the {{ dt-type-repl }} type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   * Using {{ TF }}

      1. In the `data-transfer-mkf-mkf.tf` file, specify the values of parameters:

         * `source_endpoint_id`: ID of the source endpoint.
         * `target_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set `1` to enable transfer creation.

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

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Make sure that the data from the topic in the source cluster move to the topic in the target {{ mkf-name }} cluster:

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
          "device_id": "iv9a94th6rzt********",
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

   1. Send data from the `sample.json` file to the `sensors` topic in the source {{ mkf-name }} cluster using `jq` and `kafkacat`:

      ```bash
      jq -rc . sample.json | kafkacat -P \
         -b <source_cluster_broker_FQDN>:9091 \
         -t sensors \
         -k key \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanisms=SCRAM-SHA-512 \
         -X sasl.username="<username_in_the_source_cluster>" \
         -X sasl.password="<user_password_in_the_source_cluster>" \
         -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
      ```

      The data is sent on behalf of the [created user](#prepare-source). To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../../managed-kafka/operations/connect.md).

   1. Use the `kafkacat` utility to make sure that the data from the source cluster has moved to the target {{ mkf-name }} cluster:

      ```bash
      kafkacat -C \
               -b <target_cluster_broker_FQDN>:9091 \
               -t measurements \
               -X security.protocol=SASL_SSL \
               -X sasl.mechanisms=SCRAM-SHA-512 \
               -X sasl.username="<username_in_the_target_cluster>" \
               -X sasl.password="<user_password_in_the_target_cluster>" \
               -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
      ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.

Delete the other resources, depending on the method used to create them:

{% list tabs %}

* Manually

   [Delete the clusters {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).

* Using {{ TF }}

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mkf-mkf.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-mkf-mkf.tf` configuration file will be deleted.

{% endlist %}
