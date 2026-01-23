# Saving a data stream from {{ yds-full-name }} to {{ mch-full-name }}


{{ data-transfer-name }} enables you to deliver data from a [{{ yds-name }} stream](../../data-streams/concepts/glossary.md#stream-concepts) to {{ mch-name }}.

To transfer data:

1. [Set up a data stream in {{ yds-name }}](#prepare-source).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../ydb/pricing/index.md)). Its pricing is based on deployment mode:

	* In serverless mode, you pay for data operations and storage volume, including stored backups.
  	* In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.

* {{ yds-name }} (see [{{ yds-name }} pricing](../../data-streams/pricing.md)). The cost depends on the pricing model:

    * [Based on allocated resources](../../data-streams/pricing.md#rules): You pay a fixed hourly rate for the established throughput limit and message retention period, and additionally for the number of units of actually written data.
    * [On-demand](../../data-streams/pricing.md#on-demand): You pay for the performed read/write operations, the amount of read or written data, and the actual storage used for messages that are still within their retention period.

* {{ mch-name }} cluster: Use of computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) with your preferred configuration.
    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with any suitable configuration.
    1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.connection.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.

                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}**: Select the source cluster from the list.

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: Enter the database name.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}**: Enter the name and password of the user who has access to the database, e.g., the database owner.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-transfer-yds-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-clickhouse/blob/main/data-transfer-yds-mch.tf) configuration file to the same working directory.

        This file describes:

        * {{ ydb-name }} database.
        * Service account with the `yds.editor` role.
        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and rules for internet access to the {{ mch-name }} cluster.
        * {{ mch-name }} target cluster.
        * Target endpoint.
        * Transfer.

    1. In the `data-transfer-yds-mch.tf` file, specify the following:

        * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) for the new resources.
        * `sa_name`: Service account name for endpoints.
        * `source_db_name`: {{ ydb-name }} database name.
        * `target_db_name`: {{ CH }} database name.
        * `target_user` and `target_password`: {{ CH }} database owner username and password.
        * `transfer_enabled`: Set to `0` to postpone transfer creation until you manually [set up a source endpoint](#prepare-transfer).

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up a data stream in {{ yds-name }} {#prepare-source}

1. [Create a data stream in {{ yds-name }}](../../data-streams/operations/aws-cli/create.md).
1. [Send test data to this stream](../../data-streams/operations/aws-cli/send.md). Use the vehicle sensor data in JSON format as the message:

```json
{
    "device_id":"iv9a94th6rzt********",
    "datetime":"2022-06-05 17:27:00",
    "latitude":55.70329032,
    "longitude":37.65472196,
    "altitude":427.5,
    "speed":0,
    "battery_voltage":"23.5",
    "cabin_temperature":17,
    "fuel_level":null
}
```

## Set up and activate the transfer {#prepare-transfer}

{% include [tips for endpoint settings](../../_includes/data-transfer/queue-ch-transfer-tips.md) %}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ yds-full-name }}`.
    * **Endpoint settings**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select the {{ ydb-name }} database from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the stream in {{ yds-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select or create a service account with the `yds.editor` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**: `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: You can define a schema using one of two methods:
              * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.fields.title }}`.

                Set a list of topic fields manually:

                | {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ColSchema.name.title }} | {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ColSchema.type.title }} | {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ColSchema.key.title }} |
                | :-- | :-- | :--- |
                |`device_id`|`STRING`| Yes|
                |`datetime` |`DATETIME`|  |
                |`latitude` |`DOUBLE`|  |
                |`longitude`|`DOUBLE`|  |
                |`altitude` |`DOUBLE`|  |
                |`speed`    |`DOUBLE`|  |
                |`battery_voltage`| `ANY`||
                |`cabin_temperature`| `DOUBLE`||
                | `fuel_level`|`ANY`||

              * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`.

                Create and upload a data schema file in JSON format, `json_schema.json`:

                {% cut "json_schema.json" %}

                ```json
                [
                    {
                        "name": "device_id",
                        "type": "string",
                        "key": true
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

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**-type that will use the endpoints you created.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `data-transfer-yds-mch.tf` file, specify the following variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: Set to `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will show any errors found in your configuration files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Once created, your transfer will be activated automatically.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. [Send a new message to the {{ yds-name }} data stream](../../data-streams/operations/aws-cli/send.md):

    ```json
    {
        "device_id":"rhibbh3y08qm********",
        "datetime":"2022-06-06 09:49:54",
        "latitude":55.71294467,
        "longitude":37.66542005,
        "altitude":429.13,
        "speed":55.5,
        "battery_voltage":null,
        "cabin_temperature":18,
        "fuel_level":32
    }
    ```

1. Check that the {{ yds-name }} stream data has been transferred to your {{ mch-name }} cluster database:

   1. [Connect to the target {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/clients.md).
   1. Check that the {{ CH }} database now contains a table named after the [{{ yds-name }} data stream](#prepare-source). The table must have columns matching the [source endpoint’s data schema](#prepare-transfer) and must include the test data that you sent.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. Delete the resources depending on how you created them:

   {% list tabs group=instructions %}

   - Manually {#manual}

       1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
       1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
       1. [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).

   - {{ TF }} {#tf}

       {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}

1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
