You can set up data transfer from a {{ mkf-full-name }} topic to {{ GP }} in {{ mgp-name }} using {{ data-transfer-full-name }}. To do this:

1. [Prepare the test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mkf-name }} cluster fee: Use of computing resources allocated to hosts (including ZooKeeper hosts) and disk storage (see [{{ KF }} pricing](../../../managed-kafka/pricing.md)).
* {{ GP }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).
* Fee for public IP addresses assigned to cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Fee per transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

1. Set up the infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a source {{ mkf-full-name }} cluster](../../../managed-kafka/operations/cluster-create.md#create-cluster) in any suitable configuration with publicly available hosts.

        1. [In the source cluster, create a topic](../../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.

        1. [In the source cluster, create a user](../../../managed-kafka/operations/cluster-accounts.md#create-account) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` access permissions for the topic.

        1. [Create a {{ GP }} target cluster](../../../managed-greenplum/operations/cluster-create.md#create-cluster) in any suitable configuration using the admin username (`user`) and hosts located in the public domain.

        1. Make sure that the cluster security groups are set up correctly and allow connecting to them:
            * [{{ mkf-name }}](../../../managed-kafka/operations/connect/index.md#configuring-security-groups).
            * [{{ mgp-name }}](../../../managed-greenplum/operations/connect.md#configuring-security-groups).

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [kafka-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-greenplum/blob/main/kafka-greenplum.tf) configuration file to the same working directory.

            This file describes:

            * [Networks](../../../vpc/concepts/network.md#network) and [subnets](../../../vpc/concepts/network.md#subnet) where your clusters will be hosted.
            * [Security groups](../../../vpc/concepts/security-groups.md) for making cluster connections.
            * {{ mkf-name }} source cluster.
            * {{ GP }} target cluster in {{ mgp-name }}.
            * Transfer.

        1. In the `kafka-greenplum.tf` file, specify user passwords and {{ KF }} and {{ GP }} versions.
        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will show any errors found in your configuration files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Install the following tools:

    * [kafkacat](https://github.com/edenhill/kcat): For reading from and writing to {{ KF }} topics.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Make sure you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../../managed-kafka/operations/connect/clients.md#bash-zsh).

    * [jq](https://stedolan.github.io/jq/): For stream processing of JSON files.

        ```bash
        sudo apt update && sudo apt-get install --yes jq

## Prepare the test data {#prepare-data}

Let's assume the {{ KF }} `sensors` topic in the source cluster receives data from car sensors in JSON format.

Create a file named `sample.json` with test data on your working instance:

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
```

{% endcut %}

## Set up and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/kafka.md) with the `{{ KF }}` type and specify the following items for it:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}**: `sensors`.
    * `json` conversion rules. In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** field, select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}` and copy and paste the following field specification into the form that opens:

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

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/target/greenplum.md) of the `{{ GP }}` type and put `user` for username.
1. Create and activate your transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. Create a _{{ dt-type-repl }}_-type [transfer](../../../data-transfer/operations/transfer.md#create) and configure it to use the previously created endpoints.
        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to {{ dt-status-repl }}.

    - {{ TF }} {#tf}

        1. In the `kafka-greenplum.tf` file, specify the following variables:

            * `kf_source_endpoint_id`: Source endpoint ID.
            * `gp_target_endpoint_id`: ID of the target endpoint.
            * `transfer_enabled`: Set to `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will show any errors found in your configuration files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. The transfer will activate automatically upon creation. Wait for its status to change to {{ dt-status-repl }}.

    {% endlist %}

## Test the transfer {#verify-transfer}

Make sure the data from the topic in the source {{ mkf-name }} cluster is being moved to the {{ GP }} database:

1. Send data from `sample.json` to the {{ mkf-name }} `sensors` topic using `jq` and `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
        -b <broker_host_FQDN>:9091 \
        -t sensors \
        -k key \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username="<username_in_source_cluster>" \
        -X sasl.password="<user_password_in_source_cluster>" \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
    ```

    To learn more about setting up an SSL certificate and using `kafkacat`, see [{#T}](../../../managed-kafka/operations/connect/clients.md).

1. Verify that the data has been transferred from the source {{ mkf-name }} cluster to the {{ GP }} database:

    1. [Connect to the {{ GP }} database](../../../managed-greenplum/operations/connect.md).
    1. Check that the database contains a table named `sensors` with the test data from the topic:

        ```sql
        SELECT * FROM public.sensors;
        ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* Make sure the transfer has the {{ dt-status-finished }} status and [delete](../../../data-transfer/operations/transfer.md#delete) it.
* [Delete both the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
* Delete the clusters:

    {% list tabs group=instructions %}

    - Manually {#manual}

        * [{{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
        * [{{ mgp-name }}](../../../managed-greenplum/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
