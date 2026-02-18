# Delivering data from a {{ KF }} queue to {{ SD }} using {{ data-transfer-full-name }}


A {{ mmg-name }} cluster can ingest data from {{ KF }} topics in real time.

To start data delivery:

1. [Prepare your test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mkf-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* {{ mmg-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mmg-name }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. Set up your data delivery infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        {% include [public-access](../../_includes/mdb/note-public-access.md) %}

        1. [Create a {{ mkf-name }} source cluster](../../managed-kafka/operations/cluster-create.md) of any suitable configuration. To be able to connect to the cluster not only from within the {{ yandex-cloud }} network but also from your local machine, enable public access when creating it.

        1. [In the source cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.

        1. [In the source cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions for the new topic.

        1. [Create a {{ mmg-name }} target cluster](../../storedoc/operations/cluster-create.md) with the following settings:

            * Database name: `db1`.
            * Username: `mmg-user`.
            * In the same availability zone as the source cluster.
            * To connect to the cluster from the user's local machine instead of the {{ yandex-cloud }} cloud network, enable public access to the cluster hosts.

        
        1. To connect to the cluster from the user's local machine, configure security groups:

            * [{{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
            * [{{ mmg-name }}](../../storedoc/operations/connect/index.md#configuring-security-groups).


    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-mkf-mmg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-mongodb/blob/main/data-transfer-mkf-mmg.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * [Security group](../../vpc/concepts/security-groups.md) and rules allowing connections to the {{ mkf-name }} and {{ mmg-name }} clusters.
            * {{ mkf-name }} source cluster.
            * {{ KF }} topic named `sensors`.
            * {{ KF }} user named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` access permissions to the `sensors` topic.
            * {{ mmg-name }} target cluster.
            * {{ SD }} database named `db1`.
            * {{ SD }} user named `mmg-user` with the `readWrite` access permissions for the `db1` database.
            * Transfer.

        1. In the `data-transfer-mkf-mmg.tf` file, specify these variables:

            * `source_kf_version`: {{ KF }} version in the source cluster.
            * `source_user_password`: `mkf-user` password in the source cluster.
            * `target_mg_version`: {{ SD }} version in the target cluster.
            * `target_user_password`: `mmg-user` password in the target cluster.
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

1. Install these tools:

    - [kafkacat](https://github.com/edenhill/kcat): For data reads and writes in {{ KF }} topics.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Make sure you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    - [jq](https://stedolan.github.io/jq/): For stream processing of JSON files.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Prepare your test data {#prepare-data}

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

## Set up and activate the transfer {#prepare-transfer}

1. [Create](../../data-transfer/operations/endpoint/index.md#create) an [`{{ KF }}` source endpoint](../../data-transfer/operations/endpoint/source/kafka.md):

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

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**-type that will use the endpoints you created.
        1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - {{ TF }} {#tf}

        1. In the `data-transfer-mkf-mmg.tf` file, specify the following variables:

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

        1. The transfer will be activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Test your transfer {#verify-transfer}

Make sure data from the {{ mkf-name }} source cluster topic can be transferred to the {{ mmg-name }} cluster:

1. Send data from `sample.json` to the {{ mkf-name }} `sensors` topic using `jq` and `kafkacat`:

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

    To learn more about setting up an SSL certificate and using `kafkacat`, see [{#T}](../../managed-kafka/operations/connect/clients.md).

1. Make sure that the {{ mmg-name }} cluster's `sensors` collection contains the data that was sent:

    1. [Connect to the {{ mmg-name }} cluster](../../storedoc/operations/connect/index.md).

    1. Get the contents of the `sensors` collection using the query below:

        ```sql
        db.sensors.find()
        ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources, delete those you do not need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).
1. Delete the other resources depending on how you created them:

   {% list tabs group=instructions %}

   - Manually {#manual}

       1. [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
       1. [Delete the {{ mmg-name }} cluster](../../storedoc/operations/cluster-delete.md).

   - {{ TF }} {#tf}

       {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
