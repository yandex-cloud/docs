# Delivering data from an {{ KF }} queue to {{ PG }} using {{ data-transfer-full-name }}


You can set up data transfer from a {{ mkf-name }} topic to {{ mpg-name }} using {{ data-transfer-full-name }}. Proceed as follows:

1. [Prepare your test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mkf-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mkf-name }} pricing](../../../managed-kafka/pricing.md)).
* {{ mpg-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. Set up your infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

        1. [Create a {{ mkf-name }} source cluster](../../../managed-kafka/operations/cluster-create.md#create-cluster) in any [availability zone](../../../overview/concepts/geo-scope.md) with any suitable configuration and public access.

        1. [In the source cluster, create a topic](../../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.

        1. [In the source cluster, create a user](../../../managed-kafka/operations/cluster-accounts.md#create-account) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` access permissions for the new topic.

        1. In the same availability zone, [create a {{ mpg-name }} target cluster](../../../managed-postgresql/operations/cluster-create.md#create-cluster) of any suitable configuration with `pg-user` as admin and publicly accessible hosts.

        1. Make sure the cluster security groups are configured correctly and allow inbound cluster connections:
            * [{{ mkf-name }}](../../../managed-kafka/operations/connect/index.md#configuring-security-groups).
            * [{{ mpg-name }}](../../../managed-postgresql/operations/connect.md#configuring-security-groups).

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [kafka-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-postgresql/blob/main/kafka-postgresql.tf) configuration file to the same working directory.

            This file describes:

            * [Networks](../../../vpc/concepts/network.md#network) and [subnets](../../../vpc/concepts/network.md#subnet) that will host your clusters.
            * [Security groups](../../../vpc/concepts/security-groups.md) for cluster access.
            * {{ mkf-name }} source cluster.
            * {{ mpg-name }} target cluster.
            * Target endpoint.
            * Transfer.

        1. In `kafka-postgresql.tf`, specify the following:

            * {{ KF }} and {{ PG }} versions.
            * {{ KF }} and {{ PG }} user passwords.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Install these tools:

    * [kafkacat](https://github.com/edenhill/kcat): For data reads and writes in {{ KF }} topics.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Make sure you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../../managed-kafka/operations/connect/clients.md#bash-zsh).

    * [jq](https://stedolan.github.io/jq/): For stream processing of JSON files.

        ```bash
        sudo apt update && sudo apt-get install --yes jq

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

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/kafka.md) of the `{{ KF }}` type and specify the following for it:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}**: `sensors`.
    * `json` conversion rules. In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** field, select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`, copy the following field specification, and paste it into the form that opens:

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

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a `{{ PG }}` target endpoint](../../../data-transfer/operations/endpoint/target/postgresql.md) with these cluster connection settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<target_{{ PG }}_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.
        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the endpoints you created.
        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - {{ TF }} {#tf}

        1. In the `kafka-postgresql.tf` file, specify the following variables:

            * `kf_source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: Set to `1` to create a target endpoint and a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. The transfer will be activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Test your transfer {#verify-transfer}

Make sure data from the {{ mkf-name }} source cluster topic is being transferred to the {{ mpg-name }} database:

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

    To learn more about setting up an SSL certificate and using `kafkacat`, see [{#T}](../../../managed-kafka/operations/connect/clients.md).

1. Make sure the data from the source {{ mkf-name }} cluster has been transferred to the {{ mpg-name }} database:

    1. [Connect to the {{ mpg-name }} database](../../../managed-postgresql/operations/connect.md).
    1. Check that the `sensors` table contains the data that was sent:

        ```sql
        SELECT * FROM sensors;
        ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources, delete those you do not need:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
1. Delete the other resources depending on how you created them:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
        1. [Delete the {{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-delete.md).
        1. [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
