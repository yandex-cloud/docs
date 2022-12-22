# Moving data between {{ mkf-full-name }} clusters using {{ data-transfer-full-name }}

You can move your data from {{ KF }} topics between one {{ mkf-name }} cluster and another in real time. Migration across versions is also supported. For example, you can move topics from {{ KF }} ver. 2.8 to ver. 3.1.

This method of data migration enables you to:

* Set up topic replication in the management console interface or in Terraform.
* Track the migration process using the [transfer monitoring](../../data-transfer/operations/monitoring.md).
* Go without creating an intermediate VM or granting online access to your {{ mkf-name }} target cluster.

To migrate data:

1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. Prepare the data delivery infrastructure:

   {% list tabs %}

   * Manually

      1. Create a [source and target {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) with public internet access, in any suitable configuration.
      1. [In the source cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.
      1. [In the source cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions to the created topic.
      1. [In the target cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions for all the topics.

   * Using {{ TF }}

      1. If you don't have {{ TF }}, {% if audience != "internal" %}[install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install and configure it{% endif %}.
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and {% if audience != "internal" %}[specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}specify the parameter values{% endif %}.
      1. Download the [data-transfer-mkf-mkf.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mkf-mkf.tf) configuration file to the same working directory.

         This file describes:

         * {% if audience != "internal" %}[Network](../../vpc/concepts/network.md#network){% else %}Network{% endif %}.
         * {% if audience != "internal" %}[Subnet](../../vpc/concepts/network.md#subnet){% else %}Subnet{% endif %}.
         * {% if audience != "internal" %}[Security groups](../../vpc/concepts/security-groups.md){% else %}Security groups{% endif %} and the rule required to connect to a {{ mkf-name }} cluster.
         * A source {{ mkf-name }} cluster with public internet access.
         * {{ mkf-name }} target cluster.
         * {{ KF }} topic.
         * Transfer.

      1. In the `data-transfer-mkf-mkf.tf` file, specify the values of parameters:

         * `source_kf_version`: {{ KF }} version in the source cluster.
         * `source_user_name`: Username for establishing a connection to the {{ KF }} topic.
         * `source_user_password`: User password.
         * `target_kf_version`: {{ KF }} version in the target cluster.
         * `transfer_enabled`: Set `0` to ensure that no transfer is created before the [source and target endpoints are created manually](#prepare-transfer).

      1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

   The created {{ KF }} `sensors` topic in the source cluster will receive test data from car sensors in JSON format, for example:

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

   * **Database type**: `{{ KF }}`.
   * **Endpoint parameters**:

      * **Connection settings**: `{{ mkf-name }} cluster`.

         Select a target cluster from the list and specify the cluster connection settings.

      * **Apache Kafka topic settings**.
         * **Topic full name**: `measurements`.

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **Database type**: `{{ KF }}`.
   * **Endpoint parameters**:
      * **Connection settings**: `{{ mkf-name }} cluster`.

         Select a source cluster from the list and specify the cluster connection settings.

      * **Topic full name**: `sensors`.

1. Create a transfer:

   {% list tabs %}

   * Manually

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the {{ dt-type-repl }} type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) it.

   * Using {{ TF }}

      1. In the `data-transfer-mkf-mkf.tf` file, specify the values of parameters:

         * `source_endpoint_id`: ID of the source endpoint.
         * `target_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set `1` to enable transfer creation.

      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, a transfer is activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Make sure that the data from the topic in the source cluster move to the topic in the target {{ mkf-name }} cluster:

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

   1. Send data from the `sample.json` file to the `sensors` topic in the source {{ mkf-name }} cluster using `jq` and `kafkacat`:

      ```bash
      jq -rc . sample.json | kafkacat -P \
         -b <broker FQDN in the source cluster>:9091 \
         -t sensors \
         -k key \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanisms=SCRAM-SHA-512 \
         -X sasl.username="<username in the source cluster>" \
         -X sasl.password="<user password in the source cluster>" \
         -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
      ```

      The data is sent on behalf of the [created user](#prepare-source). To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../../managed-kafka/operations/connect.md).

   1. Use the `kafkacat` utility to make sure that the data from the source cluster has moved to the target {{ mkf-name }} cluster:

      ```bash
      kafkacat -C \
               -b <broker FQDN in the target cluster>:9091 \
               -t measurements \
               -X security.protocol=SASL_SSL \
               -X sasl.mechanisms=SCRAM-SHA-512 \
               -X sasl.username="<username in the target cluster>" \
               -X sasl.password="<user password in the target cluster>" \
               -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
      ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [disable the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

If you no longer need these resources, delete them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for the source and target.

Delete the other resources, depending on the method used to create them:

{% list tabs %}

* Manually

   [Delete the clusters {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).

* Using {{ TF }}

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mkf-mkf.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-mkf-mkf.tf` configuration file will be deleted.

{% endlist %}
