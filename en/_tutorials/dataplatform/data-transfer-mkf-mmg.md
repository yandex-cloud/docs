# Delivering data from an {{ KF }} queue to {{ MG }} using {{ data-transfer-full-name }}


A {{ mmg-name }} cluster can get data from {{ KF }} topics in real time.

To run data delivery:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Prepare the data transfer infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a {{ mkf-name }} source cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration. To connect to the cluster from the user's local machine rather than doing so from the {{ yandex-cloud }} cloud network, enable public access to the cluster when creating it.

        1. [In the source cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.

        1. [In the source cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions for the new topic.

        1. [Create a {{ mmg-name }} target cluster](../../managed-mongodb/operations/cluster-create.md) of any suitable configuration with the following settings:

            * Database name: `db1`.
            * Username: `mmg-user`.
            * In the same availability zone as the source cluster.
            * To connect to the cluster from the user's local machine instead of the {{ yandex-cloud }} cloud network, enable public access to the cluster hosts.


        1. To connect to the cluster from the user's local machine, configure security groups:

            * [{{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
            * [{{ mmg-name }}](../../managed-mongodb/operations/connect/index.md#configuring-security-groups).


    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-mkf-mmg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-mongodb/blob/main/data-transfer-mkf-mmg.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to the {{ mkf-name }} and {{ mmg-name }} clusters.
            * {{ mkf-name }} source cluster.
            * {{ KF }} topic named `sensors`.
            * {{ KF }} user named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` access permissions to the `sensors` topic.
            * {{ mmg-name }} target cluster.
            * {{ MG }} database named `db1`.
            * {{ MG }} user named `mmg-user` with the `readWrite` access permissions for the `db1` database.
            * Transfer.

        1. In the `data-transfer-mkf-mmg.tf` file, specify these variables:

            * `source_kf_version`: {{ KF }} version in the source cluster.
            * `source_user_password`: `mkf-user` password in the source cluster.
            * `target_mg_version`: {{ MG }} version in the target cluster.
            * `target_user_password`: `mmg-user` password in the target cluster.
            * `transfer_enabled`: Set to `0` to ensure that no transfer is created until you [create endpoints manually](#prepare-transfer).

        1. Check that the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

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

## Prepare the test data {#prepare-data}

Let's assume the {{ KF }} `sensors` topic in the source cluster receives data from car sensors in JSON format.

Create a local `sample.json` file with the following test data:

{% cut "sample.json" %}

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

{% endcut %}

## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`{{ KF }}` source](../../data-transfer/operations/endpoint/source/kafka.md):

    **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.title }}**:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.connection.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the source cluster from the list.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaAuth.sasl.title }}`.

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.user.title }}**: `mkf-user`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.password.title }}**: Enter the user password.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}**: `sensors`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.advanced_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**: `json`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`.

                Insert the data schema in JSON format:

                {% cut "json" %}

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

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`{{ MG }}` target](../../data-transfer/operations/endpoint/target/mongodb.md):

    **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.title }}**:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}**: Select the source cluster from the list.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `db1`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `mmg-user`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the user password.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.database.title }}**: `db1`.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.
        1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - {{ TF }} {#tf}

        1. In the `data-transfer-mkf-mmg.tf` file, specify these variables:

            * `source_endpoint_id`: ID of the source endpoint.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Check that the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        1. The transfer will be activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Test the transfer {#verify-transfer}

Make sure the data from the topic in the source {{ mkf-name }} cluster is being moved to the {{ mmg-name }} cluster:

1. Send data from the `sample.json` file to the {{ mkf-name }} `sensors` topic using `jq` and `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
       -b <broker_host_FQDN>:9091 \
       -t sensors \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username="mkf-user" \
       -X sasl.password="<user_password_in_source_cluster>" \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
    ```

    To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../../managed-kafka/operations/connect/clients.md).

1. Make sure that the the {{ mmg-name }} cluster's `sensors` collection contains the data that was sent:

    1. [Connect to the {{ mmg-name }} cluster](../../managed-mongodb/operations/connect/index.md).

    1. Get the contents of the `sensors` collection using the query below:

        ```sql
        db.sensors.find()
        ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
    * [Delete the {{ mmg-name }} cluster](../../managed-mongodb/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
