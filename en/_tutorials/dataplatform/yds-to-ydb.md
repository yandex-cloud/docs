# Delivering data from an {{ yds-name }} queue to {{ ydb-name }} using {{ data-transfer-name }}

With {{ data-transfer-name }}, you can deliver data from a stream in {{ yds-name }} to a {{ ydb-name }} database.

To transfer data:

1. [Prepare a {{ yds-name }} data stream](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the data transfer infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration for the data stream in {{ yds-name }}.

    1. [Create a {{ ydb-name }} target database](../../ydb/operations/manage-databases.md) in any suitable configuration.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [yds-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-ydb/blob/main/yds-to-ydb.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to a {{ ydb-name }} database.
        * {{ ydb-name }} databases.
        * Transfer.

    1. In the `yds-to-ydb.tf` file, specify the following parameters:

        * `source_db_name`: Name of the {{ ydb-name }} database for the data stream in {{ yds-name }}.
        * `target_db_name`: {{ ydb-name }} target database name.
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

## Create a {{ yds-name }} data stream {#prepare-source}

[Create a {{ yds-name }} data stream](../../data-streams/quickstart/create-stream.md).

## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint for the {{ yds-name }} source](../../data-transfer/operations/endpoint/index.md#create).

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ yds-full-name }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select the {{ ydb-name }} database for the data stream in {{ yds-name }} from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the {{ yds-name }} data stream.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select or create a service account with the `yds.editor` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**: `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`.

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

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `YDB`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.connection.title }}**:

           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} target database from the list.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select or create a service account with the `ydb.editor` role.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}** type that will use the created endpoints.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

    - {{ TF }} {#tf}

        1. In the `yds-to-ydb.tf` file, specify the values of the following variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Check that the {{ TF }} configuration files are correct using this command:

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

1. [Send test data to the data stream in {{ yds-name }}](../../data-streams/operations/aws-cli/send.md):

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

1. Make sure the data has been moved to the target database:

     {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder with the DB.
        1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Select the database from the list.
        1. Go to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
        1. Make sure the `<stream_name>` table now contains the test data.

    - {{ ydb-short-name }} CLI {#cli}

        1. [Connect to the {{ ydb-name }}](../../ydb/operations/connection.md) database.
        1. Make sure the `<stream_name>` table now contains the test data:

            ```bash
            ydb table query execute \
            --query "SELECT * \
            FROM <stream_name>"
            ```

    {% endlist %}


## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
1. If you had created service accounts, [delete them](../../iam/operations/sa/delete.md).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ ydb-name }} databases](../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
