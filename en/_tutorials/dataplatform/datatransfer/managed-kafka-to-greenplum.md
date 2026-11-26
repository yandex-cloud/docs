

You can set up data transfer from a {{ mkf-full-name }} topic to {{ GP }}/{{ CB }} in {{ mgp-full-name }} using {{ data-transfer-full-name }}. Follow these steps:

1. [Set up your infrastructure](#prepare-infrastructure).
1. [Prepare your test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ mkf-name }} cluster: use of computing resources allocated to hosts and storage size (see [{{ mkf-name }} pricing](../../../managed-kafka/pricing.md)).
* {{ mgp-name }} cluster: use of computing resources allocated to hosts, storage and backup size (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


## Set up your infrastructure {#prepare-infrastructure}

1. Set up your data delivery infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        
        {% include [public-access](../../../_includes/mdb/note-public-access.md) %}


        1. [Create a {{ mkf-full-name }} source cluster](../../../managed-kafka/operations/cluster-create.md#create-cluster) of any suitable configuration with publicly accessible hosts.

        1. [In the source cluster, create a topic](../../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`.

        1. [In the source cluster, create a user](../../../managed-kafka/operations/cluster-accounts.md#create-account) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions for the new topic.

        1. [Create a {{ GP }} target cluster](../../../managed-greenplum/operations/cluster-create.md#create-cluster) with publicly accessible hosts and `user` as the admin username. Use any configuration you need.

        1. Make sure the cluster security groups are properly configured and allow inbound cluster connections:
            * [{{ mkf-name }}](../../../managed-kafka/operations/connect/index.md#configuring-security-groups).
            * [{{ mgp-name }}](../../../managed-greenplum/operations/connect/index.md#configuring-security-groups).

    
    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [kafka-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-greenplum/blob/main/kafka-greenplum.tf) configuration file to your current working directory.

            This file describes:

            * [Networks](../../../vpc/concepts/network.md#network) and [subnets](../../../vpc/concepts/network.md#subnet) that will host your clusters.
            * [Security groups](../../../vpc/concepts/security-groups.md) for cluster access.
            * {{ mkf-name }} source cluster.
            * {{ GP }} target cluster in {{ mgp-name }}.
            * {{ KF }} endpoint.
            * Transfer.

        1. In the `kafka-greenplum.tf` file, specify the user passwords and the versions of {{ KF }} and {{ GP }}.
        1. Validate your {{ TF }} configuration using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}


    {% endlist %}

1. Install these tools:

    * [kafkacat](https://github.com/edenhill/kcat): For reading from and writing to {{ KF }} topics.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Check that you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../../managed-kafka/operations/connect/clients.md#bash-zsh).

    * [jq](https://stedolan.github.io/jq/): For stream processing of JSON files.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```


## Prepare your test data {#prepare-data}

Suppose the {{ KF }} `sensors` topic in the source cluster receives JSON-formatted data from car sensors.

On your local machine, create a file named `sample.json` with test data:

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

## Prepare and activate a transfer {#prepare-transfer}

1. [Create an endpoint for the {{ GP }} target](../../../data-transfer/operations/endpoint/target/greenplum.md):

    * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
    * Name the endpoint.
    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Greenplum/Yandex MPP Analytics`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: Select `Cluster`.
        * **Cluster**: Select a cluster from the list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Specify the name database of interest.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Specify `user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter the `user` password.

1. Create a {{ KF }} source endpoint and transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a `{{ KF }}` type source endpoint](../../../data-transfer/operations/endpoint/source/kafka.md):

            * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
            * Name the endpoint.
            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                * **Installation type**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the source cluster from the list.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaAuth.sasl.title }}` and the name and password of the user created [earlier](#prepare-infrastructure).
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}**: Specify `sensors`.
                * In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** field, specify the `json` type conversion rules. Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}` and paste the following field specification into the form that opens:

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

        1. [Create](../../../data-transfer/operations/transfer.md#create) a _{{ dt-type-repl }}_-type transfer and configure it to use the previously created endpoints.
        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to {{ dt-status-repl }}.

    
    - {{ TF }} {#tf}

        1. In `kafka-greenplum.tf`, specify the following variables:

            * `gp_target_endpoint_id`: {{ GP }} target endpoint ID.
            * `transfer_enabled`: Set to `1` to create the transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. The transfer will be activated automatically. Wait for its status to change to {{ dt-status-repl }}.


    {% endlist %}

## Test the transfer {#verify-transfer}

Make sure data from the topic in the {{ mkf-name }} source cluster is reaching the {{ GP }} database:

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

1. Make sure the {{ GP }} database now contains the data from the {{ mkf-name }} source cluster:

    1. [Connect to the {{ GP }} database](../../../managed-greenplum/operations/connect/index.md).
    1. Check that the database contains the `sensors` table with the test data from the topic:

        ```sql
        SELECT * FROM public.sensors;
        ```

## Delete the resources you created {#clear-out}

To reduce resource usage, delete the resources you no longer need:

1. Make sure the transfer status is {{ dt-status-finished }}, then [delete](../../../data-transfer/operations/transfer.md#delete) it.


1. Delete the resources, applying the same method used for their creation:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
        1. [Delete the {{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-delete.md).
        1. [Delete the {{ mgp-name }} cluster](../../../managed-greenplum/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

1. [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).

