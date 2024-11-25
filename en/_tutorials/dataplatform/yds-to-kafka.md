# Delivering data from an {{ yds-name }} queue to {{ mkf-name }} using {{ data-transfer-name }}

With {{ data-transfer-name }}, you can deliver data from a {{ yds-name }} stream to a {{ mkf-name }} cluster.

To transfer data:

1. [Prepare a {{ yds-name }}](#prepare-source) data stream.
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the data transfer infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.

    1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration with publicly available hosts.

    1. [In the {{ mkf-name }} cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `sensors`. 

    1. [In the {{ mkf-name }} cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` permissions for the new topic.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [yds-to-kafka.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-kafka/blob/main/yds-to-kafka.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to a {{ mkf-name }} cluster.
        * {{ ydb-name }} database.
        * {{ mkf-name }} cluster.
        * {{ mkf-name }} topic named `sensors`.
        * {{ mkf-name }} user with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` access permissions for the `sensors` topic.
        * Transfer.

    1. In the `yds-to-kafka.tf` file, specify the following parameters:

        * `mkf_version`: {{ KF }} cluster version.
        * `ydb_name`: {{ ydb-name }} database name.
        * `mkf_user_name`: Username in {{ mkf-name }} cluster.
        * `mkf_user_password`: User password in {{ mkf-name }} cluster.
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

## Create a {{ yds-name }} {#prepare-source}

[Create a {{ yds-name }} data stream](../../data-streams/quickstart/create-stream.md).

## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint for the {{ yds-name }} source](../../data-transfer/operations/endpoint/index.md#create).

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ yds-full-name }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select the {{ ydb-name }} database from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the {{ yds-name }} data stream.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select or create a service account with the `yds.editor` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**: `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`:

            Fill in the data schema:

            {% cut "Data schema" %}

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

1. [Create an endpoint for the {{ mkf-name }} target](../../data-transfer/operations/endpoint/index.md#create).

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.connection.title }}**:
        
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select a {{ mkf-name }} cluster from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Select **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaAuth.sasl.title }}**.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.user.title }}**: Enter a name for the {{ mkf-name }} cluster user.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.password.title }}**: Enter a password for the {{ mkf-name }} cluster user.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: Select **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: Enter a name for the topic in {{ mkf-name }} cluster.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}** type that will use the created endpoints.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

    - {{ TF }} {#tf}

        1. In the `yds-to-kafka.tf` file, specify the values of the following variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            The transfer will be activated automatically.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. [Send test data to {{ yds-name }} stream](../../data-streams/operations/aws-cli/send.md):

    ```json
    {
        "device_id":"iv9a94th6rzt********",
        "datetime":"2020-06-05T17:27:00",
        "latitude":"55.70329032",
        "longitude":"37.65472196",
        "altitude":"427.5",
        "speed":"0",
        "battery_voltage":"23.5",
        "cabin_temperature":"17",
        "fuel_level":null
    }
    ```

1. Make sure the data has been transferred to the `sensors` topic in the {{ mkf-name }} cluster:

    1. [Get an SSL certificate](../../managed-kafka/operations/connect/index.md#get-ssl-cert) to connect to the {{ mkf-name }} cluster.
    1. [Install](../../managed-kafka/operations/connect/clients.md#bash-zsh) the `kafkacat` utility:
    1. [Run](../../managed-kafka/operations/connect/clients.md#with-ssl_1) the command for receiving messages from a topic.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
1. If you had created a service account when creating the source endpoint, [delete it](../../iam/operations/sa/delete.md).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
    1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

    1. In the terminal window, go to the directory containing the infrastructure plan.
    
    1. Run this command:

        ```bash
        terraform destroy
        ```

    1. Confirm the deletion of resources.

{% endlist %}