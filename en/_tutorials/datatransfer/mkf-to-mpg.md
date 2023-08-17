# Delivering data from a {{ KF }} queue to {{ PG }} using {{ data-transfer-full-name }}

You can set up data transfer from a {{ mkf-name }} topic to {{ mpg-name }} using {{ data-transfer-full-name }}. To do this:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Prepare the infrastructure:

   {% list tabs %}

   * Manually

      1. [Create a source {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md#create-cluster) in any [availability zone](../../overview/concepts/geo-scope.md), with any appropriate configuration and public access allowed.

      1. [In the source cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.

      1. [In the source cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions to the created topic.

      1. In the same availability zone, [create a target {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster) with any appropriate configuration, `pg-user` as the admin username, and hosts located in the public domain.

      1. Make sure that the cluster's security groups have been set up correctly and allow connecting to them:
         * [{{ mkf-name }}](../../managed-kafka/operations/connect.md#configuring-security-groups).
         * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups).

   * Using {{ TF }}

      1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
      1. Download the [kafka-postgresql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/kafka-postgresql.tf) configuration file to the same working directory.

         This file describes:

         * [Networks](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) for hosting the clusters.
         * [Security groups](../../vpc/concepts/security-groups.md) for making cluster connections.
         * {{ mkf-name }} source cluster.
         * {{ mpg-name }} target cluster.
         * Target endpoint.
         * Transfer.

      1. In `kafka-postgresql.tf`, specify:

         * Versions {{ KF }} and {{ PG }}.
         * {{ KF }} and {{ PG }} user passwords.

      1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider's resources and data sources.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. Install the utilities:

   * [kafkacat](https://github.com/edenhill/kcat) to read and write data to {{ KF }} topics.

      ```bash
      sudo apt update && sudo apt install --yes kafkacat
      ```

      Check that you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect.md#connection-string).

   * [jq](https://stedolan.github.io/jq/) for JSON file stream processing.

      ```bash
      sudo apt update && sudo apt-get install --yes jq

## Prepare the test data {#prepare-data}

Let's assume the {{ KF }} `sensors` topic in the source cluster receive data from car sensors in JSON format.

Create a local `sample.json` file with the following test data:

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

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/kafka.md) with the `{{ KF }}` type and specify the following items for it:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}**: `sensors`.
   * `json` conversion rules. In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** field, select `JSON specification` and copy the following field specification in the form that opens:

   {% cut "sensors-specification" %}

   ```json
   [
       {
           "name": "device_id",
           "type": "utf8",
           "key": true
       },
       {
           "name": "datetime",
           "type": "utf8"
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

1. Create a target endpoint and a transfer:

   {% list tabs %}

   * Manually

      1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it.

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}**: `Yandex Managed Service for PostgreSQL cluster`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }} target cluster name>` from the drop-down list.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: `db1`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: `pg-user`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: `<user password>`.
      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.
      1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

   * Using {{ TF }}

      1. In `kafka-postgresql.tf`, specify the following variables:

         * `kf_source_endpoint_id`: ID of the source endpoint.
         * `transfer_enabled`: Set `1` for creating a target endpoint and a transfer.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      1. The transfer is activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

   {% endlist %}

## Test the transfer {#verify-transfer}

Make sure the data from the topic in the source {{ mkf-name }} cluster is being moved to the {{ mpg-name }} database:

1. Send data from the `sample.json` file to the {{ mkf-name }} `sensors` topic using `jq` and `kafkacat`:

   ```bash
   jq -rc . sample.json | kafkacat -P \
       -b <FQDN of the broker host>:9091 \
       -t sensors \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username="mkf-user" \
       -X sasl.password="<user password in the source cluster>" \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
   ```

   To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../../managed-kafka/operations/connect.md).

1. Make sure the data from the source {{ mkf-name }} cluster has been moved to the {{ mpg-name }} database:

   1. [Connect to the {{ mpg-name }} database](../../managed-postgresql/operations/connect.md).
   1. Check that the `sensors` table contains the sent data:

      ```sql
      SELECT * FROM sensors;
      ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [disable the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. Delete the other resources, depending on the method used to create them:

   {% list tabs %}

   * Manually

      * [Target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
      * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
      * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

   * Using {{ TF }}

      1. In the terminal window, switch to the directory containing the infrastructure plan.
      1. Delete the `kafka-postgresql.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the resources have been updated:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         This will delete all the resources described in the `kafka-postgresql.tf` configuration file.

   {% endlist %}
